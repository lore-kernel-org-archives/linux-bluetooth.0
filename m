Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Apr 2014 11:05:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 13/36] android/gatt: Add register GAP Service
Message-ID: <20140429080504.GD21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1398734107-4793-15-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398734107-4793-15-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> Register GAP service with device name characteristic,
> appearance and peripheral privacy flag
> ---
>  android/gatt.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 5ca22e2..d2b1684 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -161,6 +161,8 @@ static struct gatt_db *gatt_db = NULL;
>  
>  static GIOChannel *listening_sk = NULL;
>  
> +static char device_name[249] = "BlueZ for Android";

Shouldn't this be hooked up to adapter.name in android/bluetooth.c?

> +struct gap_srvc_handles {
> +	uint16_t srvc;
> +
> +	/*Characteristics */

Space after /*

> +	if (handle == gap_srvc_data.dev_name) {
> +		len = enc_read_resp((uint8_t *)&device_name[0],

Space after typecast (our user space coding style convention).

> +static void register_gap_service(void)
> +{
> +	bt_uuid_t uuid;
> +
> +	/*GAP UUID */

Space after /*

Johan
