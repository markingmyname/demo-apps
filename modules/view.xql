xquery version "1.0";

import module namespace templates="http://exist-db.org/xquery/templates" at "templates.xql";

declare option exist:serialize "method=html5 media-type=text/html";

declare variable $modules :=
    <modules>
        <module prefix="config" uri="http://exist-db.org/xquery/apps/config" at="config.xql"/>
        <module prefix="demo" uri="http://exist-db.org/apps/demo" at="demo.xql"/>
        <module prefix="cex" uri="http://exist-db.org/apps/demo/cex" at="cex.xql"/>
    </modules>;

let $content := request:get-data()
return
    templates:apply($content, $modules, ())