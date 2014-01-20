Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 02/11] android/hidhost: Fix miscalculation of get report event struct length
Date: Mon, 20 Jan 2014 16:22:35 +0100
Message-ID: <2481120.IZcvT0pjE9@uw000953>
In-Reply-To: <1389914751-18545-3-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1389914751-18545-3-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Friday 17 of January 2014 01:25:42 Ravi kumar Veeramally wrote:
> ---
>  android/hal-hidhost.c | 3 ++-
>  android/hidhost.c     | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
> index fd3ad2d..5445d08 100644
> --- a/android/hal-hidhost.c
> +++ b/android/hal-hidhost.c
> @@ -73,7 +73,8 @@ static void handle_get_report(void *buf, uint16_t len)
>  {
>  	struct hal_ev_hidhost_get_report *ev = buf;
>  
> -	if (len != sizeof(*ev) + ev->len) {
> +	if (len != sizeof(*ev) + sizeof(struct hal_ev_hidhost_get_report)
> +								+ ev->len) {

I don't understand this change. We have header and data len. There should be
no need for any extra calculations.


>  		error("invalid get report event, aborting");
>  		exit(EXIT_FAILURE);
>  	}
> diff --git a/android/hidhost.c b/android/hidhost.c
> index c004063..8a2668c 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -371,13 +371,14 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
>  	ba2str(&dev->dst, address);
>  	DBG("device %s", address);
>  
> -	ev_len = sizeof(*ev) + sizeof(struct hal_ev_hidhost_get_report) + 1;
> +	ev_len = sizeof(*ev) + sizeof(struct hal_ev_hidhost_get_report);

I don't understand why there is double sizeof() in first place.(*ev is same type)

>  
>  	if (!((buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_INPUT)) ||
>  			(buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_OUTPUT)) ||
>  			(buf[0]	== (HID_MSG_DATA | HID_DATA_TYPE_FEATURE)))) {
>  		ev = g_malloc0(ev_len);
>  		ev->status = buf[0];
> +		ev->len = 0;
>  		bdaddr2android(&dev->dst, ev->bdaddr);
>  		goto send;
>  	}

I have a feeling that there is something wrong with ev_len calculations in
bt_hid_notify_get_report(). I'd rather prefer to have this function properly
fixed (and possibly refactored on how it handles ev data allocation).
 

-- 
Best regards, 
Szymon Janc
