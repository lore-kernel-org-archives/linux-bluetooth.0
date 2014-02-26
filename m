Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393343453-4105-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393343453-4105-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Wed, 26 Feb 2014 16:01:51 +0200
Message-ID: <CABBYNZLf=r-EauovkR1pWqJQ_z40M5pJbO2z_fAoyFEjJYG1BA@mail.gmail.com>
Subject: Re: [PATCH] android/hal-ipc-api: Fix Add Set Volume command struct packing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tue, Feb 25, 2014 at 5:50 PM, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@tieto.com> wrote:
> This adds missed packed struct attribute to hal-ipc command.
> ---
>  android/hal-msg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 7c6110a..ee08c37 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -987,7 +987,7 @@ struct hal_cmd_avrcp_register_notification {
>  #define HAL_OP_AVRCP_SET_VOLUME                        0x0a
>  struct hal_cmd_avrcp_set_volume {
>         uint8_t value;
> -};
> +} __attribute__((packed));
>
>  #define HAL_EV_AVRCP_REMOTE_FEATURES           0x81
>  struct hal_ev_avrcp_remote_features {
> --
> 1.8.5.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
