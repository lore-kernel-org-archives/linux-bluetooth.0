Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Update expected UUIDs with MPS
Date: Wed, 11 Jun 2014 13:34:32 +0200
Message-ID: <8302076.HcY9oh4MYA@uw000953>
In-Reply-To: <1402478709-24207-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1402478709-24207-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wednesday 11 of June 2014 11:25:09 Grzegorz Kolodziejczyk wrote:
> Some tests verify that all local UUIDs are present.
> ---
>  android/android-tester.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index f04f8ac..bf39517 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -1408,9 +1408,13 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
>  
>  static bt_bdaddr_t enable_done_bdaddr_val = { {0x00} };
>  static const char enable_done_bdname_val[] = "BlueZ for Android";
> -static bt_uuid_t enable_done_uuids_val = {
> -	.uu = { 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
> -					0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
> +static const char enable_done_uuids_val[] = {
> +	/* Multi profile UUID */
> +	0x00, 0x00, 0x11, 0x3b, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
> +					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
> +	/* Device identification profile UUID */
> +	0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
> +					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
>  };
>  static bt_device_type_t enable_done_tod_val = BT_DEVICE_DEVTYPE_DUAL;
>  static bt_scan_mode_t enable_done_scanmode_val = BT_SCAN_MODE_NONE;
> @@ -1771,9 +1775,13 @@ static const struct generic_data bluetooth_getprop_disctimeout_success_test = {
>  	.expected_adapter_status = BT_STATUS_SUCCESS,
>  };
>  
> -static bt_uuid_t getprop_uuids = {
> -	.uu = { 0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
> -					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB },
> +static const char getprop_uuids[] = {
> +	/* Multi profile UUID */
> +	0x00, 0x00, 0x11, 0x3b, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
> +					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
> +	/* Device identification profile UUID */
> +	0x00, 0x00, 0x12, 0x00, 0x00, 0x00, 0x10, 0x00, 0x80, 0x00,
> +					0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB,
>  };
>  
>  static struct priority_property getprop_uuids_props[] = {
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
