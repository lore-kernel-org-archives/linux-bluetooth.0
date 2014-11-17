Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416237073-8846-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1416237073-8846-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Mon, 17 Nov 2014 16:59:53 +0100
Message-ID: <CAMv5GbcLpoei_5D2eBW1U9+Ea0exBYnuSdtaRBkDoTcJ3DZ4KA@mail.gmail.com>
Subject: Re: [PATCH] android/client: Add support for handshake callback
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 17 November 2014 16:11, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@tieto.com> wrote:
> ---
>  android/client/if-hh.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/android/client/if-hh.c b/android/client/if-hh.c
> index b2bf8ca..115809e 100644
> --- a/android/client/if-hh.c
> +++ b/android/client/if-hh.c
> @@ -156,6 +156,19 @@ static void get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t hh_status,
>                                         bthh_status_t2str(hh_status), rpt_size);
>  }
>
> +/*
> + * Callback for set_report/set_protocol api and if error
> + * occurs for get_report/get_protocol api.
> + */
> +static void handshake_cb(bt_bdaddr_t *bd_addr, bthh_status_t hh_status)
> +{
> +       char addr[MAX_ADDR_STR_LEN];
> +
> +       haltest_info("%s: bd_addr=%s hh_status=%s", __func__,
> +                                               bt_bdaddr_t2str(bd_addr, addr),
> +                                               bthh_status_t2str(hh_status));
> +}
> +
>  static bthh_callbacks_t bthh_callbacks = {
>         .size = sizeof(bthh_callbacks),
>         .connection_state_cb = connection_state_cb,
> @@ -163,7 +176,8 @@ static bthh_callbacks_t bthh_callbacks = {
>         .protocol_mode_cb = protocol_mode_cb,
>         .idle_time_cb = idle_time_cb,
>         .get_report_cb = get_report_cb,
> -       .virtual_unplug_cb = virtual_unplug_cb
> +       .virtual_unplug_cb = virtual_unplug_cb,
> +       .handshake_cb = handshake_cb
>  };
>
>  /* init */
> --
> 1.9.3
>

Please skip it. I have forgotten if definitions for android version 5.0

BR,
Grzegorz
