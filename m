Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1371458131-2741-7-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1371458131-2741-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1371458131-2741-7-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Tue, 18 Jun 2013 14:53:37 +0300
Message-ID: <CABBYNZLFFMNXfK_=YS6S+go+3ABLhFEH+RqL9mBb7HXra8F5Pg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] obexd: Fix crash when retrieving multiple MAP
 event reports
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Mon, Jun 17, 2013 at 11:35 AM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> The remote address used for dispatching the MAP notifications is
> initialized when the MNS is connected. Therefore it needs to be freed
> when the session is destroyed and not after receiving an event report.
>
> Trace:
>
>   0  0x00007ffff6a6a1c9 in raise () from /usr/lib/libc.so.6
>   1  0x00007ffff6a6b5c8 in abort () from /usr/lib/libc.so.6
>   2  0x00007ffff6aa8037 in __libc_message () from /usr/lib/libc.so.6
>   3  0x00007ffff6aad8ae in malloc_printerr () from /usr/lib/libc.so.6
>   4  0x00007ffff6aae587 in _int_free () from /usr/lib/libc.so.6
>   5  0x00000000004273b0 in event_report_close (obj=0x69a5b0)
>      at obexd/client/mns.c:295
>   6  0x0000000000429549 in os_reset_session (os=0x69c210)
>      at obexd/src/obex.c:199
>   7  0x000000000041bec6 in transfer_complete (transfer=0x69a9d0, err=0x0)
>      at gobex/gobex-transfer.c:103
>   8  0x000000000041c20c in transfer_put_req (obex=0x69b470,
>      req=<optimized out>, user_data=0x69a9d0) at
>        gobex/gobex-transfer.c:407
>   9  0x000000000041988d in handle_request (req=0x69f3d0, obex=0x69b470)
>      at gobex/gobex.c:1022
>   10 incoming_data (io=<optimized out>, cond=<optimized out>,
>      user_data=0x69b470) at gobex/gobex.c:1194
>   11 0x00007ffff702de46 in g_main_context_dispatch ()
>      from /usr/lib/libglib-2.0.so.0
>   12 0x00007ffff702e198 in ?? () from /usr/lib/libglib-2.0.so.0
>   13 0x00007ffff702e59a in g_main_loop_run () from
>        /usr/lib/libglib-2.0.so.0
>   14 0x000000000040dead in main (argc=1, argv=0x7fffffffddc8)
>      at obexd/src/main.c:319
> ---
>  obexd/client/mns.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/obexd/client/mns.c b/obexd/client/mns.c
> index 3d64a9c..d22ec96 100644
> --- a/obexd/client/mns.c
> +++ b/obexd/client/mns.c
> @@ -83,14 +83,15 @@ static void reset_request(struct mns_session *mns)
>                 g_obex_apparam_free(mns->inparams);
>                 mns->inparams = NULL;
>         }
> -
> -       if (mns->remote_address)
> -               g_free(mns->remote_address);
>  }
>
>  static void mns_session_free(struct mns_session *mns)
>  {
>         reset_request(mns);
> +
> +       if (mns->remote_address)
> +               g_free(mns->remote_address);
> +
>         g_free(mns);
>  }
>
> --
> 1.8.2.3

This patch has been applied, the rest of the set I will review latter
as we are preparing a new release.


--
Luiz Augusto von Dentz
