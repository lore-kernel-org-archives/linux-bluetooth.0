Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/bluetooth: Set unpaired cb list to NULL while unregistering bt
Date: Wed, 03 Sep 2014 16:42:16 +0200
Message-ID: <5343442.cWqiWZM8Bx@uw000953>
In-Reply-To: <1409750233-23314-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1409750233-23314-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wednesday 03 of September 2014 15:17:12 Grzegorz Kolodziejczyk wrote:
> Unpaired callback list for profiles needs to be set to NULL while
> unregistering bluetooth. Other profiles may try to unregister and remove
> its unpair cb, this cause invalid read callback list.
> ---
>  android/bluetooth.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 8b47015..d275dea 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -5281,4 +5281,5 @@ void bt_bluetooth_unregister(void)
>  	hal_ipc = NULL;
>  
>  	queue_destroy(unpaired_cb_list, NULL);
> +	unpaired_cb_list = NULL;
>  }

Both patches applied (after fixing typo in prefix of 2nd patch), thanks.

-- 
Best regards, 
Szymon Janc
