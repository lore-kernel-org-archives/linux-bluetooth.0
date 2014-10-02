Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] android/tester: Make client2 app uuid value name consistent
Date: Thu, 02 Oct 2014 13:51:13 +0200
Message-ID: <4907090.RgJ2BYQ5Al@uw000953>
In-Reply-To: <1412076227-32664-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412076227-32664-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 30 of September 2014 13:23:42 Grzegorz Kolodziejczyk wrote:
> Application uudis for tester should be name unified and consistent.
> ---
>  android/tester-gatt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index 693a8a3..b1c6ece 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -56,6 +56,11 @@ static bt_uuid_t app1_uuid = {
>  				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
>  };
>  
> +static bt_uuid_t app2_uuid = {
> +	.uu = { 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
> +				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02 },
> +};
> +
>  struct emu_cid_data {
>  	const int pdu_len;
>  	const void *pdu;
> @@ -117,11 +122,6 @@ struct write_char_data {
>  	char *p_value;
>  };
>  
> -static bt_uuid_t client2_app_uuid = {
> -	.uu = { 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
> -				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02 },
> -};
> -
>  static bt_bdaddr_t emu_remote_bdaddr_val = {
>  	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
>  };
> @@ -1117,7 +1117,7 @@ static struct test_case test_cases[] = {
>  		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
>  		ACTION_SUCCESS(gatt_client_register_action, &app1_uuid),
>  		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
> -		ACTION_SUCCESS(gatt_client_register_action, &client2_app_uuid),
> +		ACTION_SUCCESS(gatt_client_register_action, &app2_uuid),
>  		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
>  		ACTION_SUCCESS(gatt_client_start_scan_action,
>  							INT_TO_PTR(APP1_ID)),
> 

Please rebase and resend. Thanks.

-- 
Best regards, 
Szymon Janc
