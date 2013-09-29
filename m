Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380034036-25143-1-git-send-email-luiz.dentz@gmail.com>
References: <1380034036-25143-1-git-send-email-luiz.dentz@gmail.com>
Date: Sun, 29 Sep 2013 17:15:32 +0300
Message-ID: <CABBYNZ+PUxNaV=C0cybZvrw=NYby3Vmoa6e2-6GA4A2t=XH05Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] gobex: Fix crash on g_obex_pending_req_abort
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 24, 2013 at 5:47 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> It is not safe to call g_obex_pending_req_abort directly as pending_req
> can be NULL:
> Invalid read of size 4
>    at 0x41231E: g_obex_pending_req_abort (gobex.c:693)
>    by 0x416A8A: g_obex_cancel_transfer (gobex-transfer.c:647)
>    by 0x42DEF2: obc_transfer_cancel (transfer.c:180)
>    by 0x43D833: process_message.isra.5 (object.c:259)
>    by 0x3B0701CE85: ??? (in /usr/lib64/libdbus-1.so.3.7.4)
>    by 0x3B0700FA30: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.4)
>    by 0x43A5B7: message_dispatch (mainloop.c:76)
>    by 0x3B03C48962: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x3B03C47E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x3B03C48157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x3B03C48559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x40D53C: main (main.c:319)
>  Address 0x30 is not stack'd, malloc'd or (recently) free'd
> ---
>  gobex/gobex-transfer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index 4203fec..b815d60 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -644,7 +644,10 @@ gboolean g_obex_cancel_transfer(guint id, GObexFunc complete_func,
>         transfer->complete_func = complete_func;
>         transfer->user_data = user_data;
>
> -       ret = g_obex_pending_req_abort(transfer->obex, NULL);
> +       if (transfer->req_id == 0)
> +               goto done;
> +
> +       ret = g_obex_cancel_req(transfer->obex, transfer->req_id, FALSE);
>         if (ret)
>                 return TRUE;
>
> --
> 1.8.3.1

I went ahead an pushed this set upstream.



-- 
Luiz Augusto von Dentz
