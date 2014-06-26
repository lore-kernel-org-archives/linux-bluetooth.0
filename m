Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] android/hog: Fix using invalid range for external report
Date: Thu, 26 Jun 2014 09:45:10 +0200
Message-ID: <1424193.PU3ordgJzu@uw000953>
In-Reply-To: <1403696947-6777-1-git-send-email-luiz.dentz@gmail.com>
References: <1403696947-6777-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wednesday 25 of June 2014 14:49:07 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  android/hog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/hog.c b/android/hog.c
> index 652c374..4f1a4a8 100644
> --- a/android/hog.c
> +++ b/android/hog.c
> @@ -303,7 +303,7 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
>  	DBG("External report reference read, external report characteristic "
>  						"UUID: 0x%04x", uuid16);
>  	bt_uuid16_create(&uuid, uuid16);
> -	gatt_discover_char(hog->attrib, 0x00, 0xff, &uuid,
> +	gatt_discover_char(hog->attrib, 0x0001, 0xffff, &uuid,
>  					external_service_char_cb, hog);
>  }
>  

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
