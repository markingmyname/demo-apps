module namespace cex="http://exist-db.org/apps/demo/cex";

import module namespace config="http://exist-db.org/xquery/apps/config" at "config.xqm";
import module namespace kwic="http://exist-db.org/xquery/kwic"
    at "resource:org/exist/xquery/lib/kwic.xql";

declare function cex:query($node as node()*, $params as element(parameters)?, $model as item()*) {
    <div class="cex-results">
    {
        let $query := request:get-parameter("query", ())
        for $result in ft:search("/db/", concat('page:', $query))/search
        let $fields := $result/field
        return
            <div class="item">
                <p class="itemhead">Document: {$result/@uri/string()} - Score: {$result/@score/string()}</p>
                <p class="itemhead">Found {count($fields)} matches in document. Only first 10 will be shown.</p>
                {
                    for $field in subsequence($fields, 1, 10)
                    let $page := text:groups($field, "\[\[([0-9]+)")
                    return
                        <p>
                            { concat("page ", $page[2]) }
                            {kwic:summarize($field, <config width="40"/>)}
                        </p>
                }
            </div>
    }
    </div>
};