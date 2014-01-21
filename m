Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 1/2] android/hidhost: Fix miscalculation of get report event notification length
Date: Tue, 21 Jan 2014 16:20:12 +0100
Message-ID: <3134335.xIcFuNRt7s@uw000953>
In-Reply-To: <1390307059-7772-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1390307059-7772-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tuesday 21 of January 2014 14:24:18 Ravi kumar Veeramally wrote:
> Event length is size of struct + data len (if any). It is miscalulated.
> ---
>  android/hidhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 3da77c8..108493a 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -371,7 +371,7 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
>  	ba2str(&dev->dst, address);
>  	DBG("device %s", address);
>  
> -	ev_len = sizeof(*ev) + sizeof(struct hal_ev_hidhost_get_report) + 1;
> +	ev_len = sizeof(*ev);
>  
>  	if (!((buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_INPUT)) ||
>  			(buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_OUTPUT)) ||
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
