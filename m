Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Will Wang <wiwang@mozilla.com>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] android/hal-handsfree: Fix missing HFP WBS callback
Date: Thu, 27 Aug 2015 21:47:27 +0200
Message-ID: <3863916.JczJmVLfSE@athlon>
In-Reply-To: <1440676922-29249-3-git-send-email-wiwang@mozilla.com>
References: <1440676922-29249-1-git-send-email-wiwang@mozilla.com> <1440676922-29249-3-git-send-email-wiwang@mozilla.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Will,

On Thursday 27 August 2015 20:02:01 Will Wang wrote:
> ---
>  android/hal-handsfree.c | 12 ++++++++++++
>  android/hal-msg.h       |  6 ++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
> index 279b26a..9ab04c5 100644
> --- a/android/hal-handsfree.c
> +++ b/android/hal-handsfree.c
> @@ -153,6 +153,16 @@ static void handle_nrec(void *buf, uint16_t len, int
> fd) #endif
>  }
> 
> +#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
> +static void handle_wbs(void *buf, uint16_t len, int fd)
> +{
> +	struct hal_ev_handsfree_wbs *ev = buf;
> +
> +	if (cbs->wbs_cb)
> +		cbs->wbs_cb(ev->wbs, (bt_bdaddr_t *) (ev->bdaddr));
> +}
> +#endif
> +

This will not compile on Android KitKat (we still support it). Since daemon is 
version independent we need to have empty handler on hal. So #ifdefs should be 
inside function like:

static void handle_wbs(void *buf, uint16_t len, int fd)
{
#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
...
#endif
}

>  static void handle_chld(void *buf, uint16_t len, int fd)
>  {
>  	struct hal_ev_handsfree_chld *ev = buf;
> @@ -289,6 +299,8 @@ static const struct hal_ipc_handler ev_handlers[] = {
>  	/* HAL_EV_HANDSFREE_HSP_KEY_PRESS */
>  	{ handle_hsp_key_press, false,
>  				sizeof(struct hal_ev_handsfree_hsp_key_press) },
> +	/* HAL_EV_HANDSFREE_WBS */
> +	{ handle_wbs, false, sizeof(struct hal_ev_handsfree_wbs) },
>  };
> 
>  static uint8_t get_mode(void)
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 698f45a..ea79fa7 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -1638,6 +1638,12 @@ struct hal_ev_handsfree_hsp_key_press {
>  	uint8_t bdaddr[6];
>  } __attribute__((packed));
> 
> +#define HAL_EV_HANDSFREE_WBS		0x91
> +struct hal_ev_handsfree_wbs {
> +	uint8_t wbs;
> +	uint8_t bdaddr[6];
> +} __attribute__((packed));
> +
>  #define HAL_AVRCP_FEATURE_NONE			0x00
>  #define HAL_AVRCP_FEATURE_METADATA		0x01
>  #define HAL_AVRCP_FEATURE_ABSOLUTE_VOLUME	0x02

-- 
Szymon K. Janc
szymon.janc@gmail.com
