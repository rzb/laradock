vcl 4.0;

backend default {
    .host = "nginx";
    .port = "8080";
}

sub vcl_recv {
    if (req.url ~ "(?i)\.(css|js|jpg|jpeg|gif|png|ico)(\?.*)?$") {
        unset req.http.Cookie;
    }
}

sub vcl_backend_response {
    set beresp.ttl = 10s;
    set beresp.grace = 1h;
}

sub vcl_deliver {
    set resp.http.X-Server-IP = server.ip;
    unset resp.http.Via;
    unset resp.http.X-Varnish;
}