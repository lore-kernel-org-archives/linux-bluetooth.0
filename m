Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171101103123.12041-1-luiz.dentz@gmail.com>
References: <20171101103123.12041-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Nov 2017 14:09:30 +0200
Message-ID: <CABBYNZLrDawOz7_v_zpMaanOjqHiuvCs857F-WfcJgbrWKdK=g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Fix crash while disconnecting ATT
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 1, 2017 at 12:31 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Since get_ccc_state can be called from both read and write callbacks it
> was causing the disconnect handler to be register twice causing the
> following crash:
>
> bluetoothd[31312]: src/gatt-database.c:att_disconnected()
> bluetoothd[31312]: src/gatt-database.c:ccc_write_cb() External CCC write received with value: 0x0000
> bluetoothd[31312]: src/gatt-database.c:att_disconnected()
> Invalid read of size 8
>    at 0x475639: att_disconnected (gatt-database.c:301)
>    by 0x4D6C75: disconn_handler (att.c:538)
>    by 0x4D22EF: queue_foreach (queue.c:220)
>    by 0x4D8959: disconnect_cb (att.c:590)
>    by 0x4E559A: watch_callback (io-glib.c:170)
>    by 0x50CD246: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5200.3)
>    by 0x50CD5E7: ??? (in /usr/lib64/libglib-2.0.so.0.5200.3)
>    by 0x50CD901: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5200.3)
>    by 0x40CD10: main (main.c:770)
>  Address 0x8e30250 is 0 bytes inside a block of size 32 free'd
>    at 0x4C2FD18: free (vg_replace_malloc.c:530)
>    by 0x4756D5: device_state_free (gatt-database.c:271)
>    by 0x4756D5: att_disconnected (gatt-database.c:313)
>    by 0x4D6C75: disconn_handler (att.c:538)
>    by 0x4D22EF: queue_foreach (queue.c:220)
>    by 0x4D8959: disconnect_cb (att.c:590)
>    by 0x4E559A: watch_callback (io-glib.c:170)
>    by 0x50CD246: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5200.3)
>    by 0x50CD5E7: ??? (in /usr/lib64/libglib-2.0.so.0.5200.3)
>    by 0x50CD901: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5200.3)
>    by 0x40CD10: main (main.c:770)
> ---
>  src/gatt-database.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 1d262ccd4..3e10c901c 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -360,7 +360,9 @@ static struct device_state *get_device_state(struct btd_gatt_database *database,
>         queue_push_tail(database->device_states, dev_state);
>
>  done:
> -       dev_state->disc_id = bt_att_register_disconnect(att, att_disconnected,
> +       if (!dev_state->disc_id)
> +               dev_state->disc_id = bt_att_register_disconnect(att,
> +                                                       att_disconnected,
>                                                         dev_state, NULL);
>
>         return dev_state;
> --
> 2.13.6

Applied.


-- 
Luiz Augusto von Dentz
