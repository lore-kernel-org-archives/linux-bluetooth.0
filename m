Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357919757-10334-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1357919757-10334-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Sun, 13 Jan 2013 17:55:31 +0200
Message-ID: <CABBYNZKLNngQw6rSUUPJBapZ+rt7C4PsVajegFKwv6j+-8zvrg@mail.gmail.com>
Subject: Re: [PATCH 1/8] obexd: Handle empty path name in SetPath
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Christian Fetzer <christian.fetzer@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Fri, Jan 11, 2013 at 5:55 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> If the empty path is given, an empty name should be sent via OBEX.
> Currently the name field is not set at all and later checks which
> depend on data->index will access invalid memory regions as g_strsplit
> returns NULL when an empty string is given.
>
> 0  0x000000000041a181 in g_obex_setpath (obex=obex@entry=0x662eb0, path=
>     0x20 <Address 0x20 out of bounds>, func=func@entry=0x42d300 <setpath_cb>,
>     user_data=user_data@entry=0x668f10, err=err@entry=0x7fffffffda08)
>     at gobex/gobex.c:1397
> 1  0x000000000042d395 in setpath_cb (obex=0x662eb0, err=0x0, rsp=<optimized out>,
>     user_data=0x668f10) at obexd/client/session.c:902
> 2  0x0000000000418e54 in handle_response (obex=obex@entry=0x662eb0, err=err@entry=0x0,
>     rsp=rsp@entry=0x668f40) at gobex/gobex.c:948
> 3  0x0000000000419d7a in incoming_data (io=<optimized out>, cond=<optimized out>,
>     user_data=0x662eb0) at gobex/gobex.c:1191
> 4  0x00007ffff703c845 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
> 5  0x00007ffff703cb78 in ?? () from /usr/lib/libglib-2.0.so.0
> 6  0x00007ffff703cf72 in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
> 7  0x000000000040def2 in main (argc=1, argv=0x7fffffffdd88) at obexd/src/main.c:323
> ---
>  obexd/client/session.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index 9cc824e..db37a86 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -934,7 +934,7 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
>         p = pending_request_new(session, NULL, setpath_complete, data);
>
>         /* Relative path */
> -       if (path[0] != '/') {
> +       if (path[0] != '/' && path[0] != 0) {
>                 first = data->remaining[data->index];
>                 data->index++;
>         }
> --
> 1.8.1

But what empty means in this case, I would like to stick with cd
behavior, so empty should set back to root. Otherwise the patchset
seems fine.

--
Luiz Augusto von Dentz
