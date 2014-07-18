Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/8] android/gatt: Fix service class id of built in gatt services
Date: Fri, 18 Jul 2014 11:15:49 +0200
Message-ID: <1490799.Vggir6MhC3@uw000953>
In-Reply-To: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
References: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 17 of July 2014 10:42:43 Marcin Kraglak wrote:
> ---
>  android/gatt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 986f435..19d9b60 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -6199,6 +6199,7 @@ static void register_gap_service(void)
>  	gatt_db_service_set_active(gatt_db, gap_srvc_data.srvc , true);
>  
>  	/* SDP */
> +	bt_uuid16_create(&uuid, 0x1800);
>  	start = gap_srvc_data.srvc;
>  	end = gatt_db_get_end_handle(gatt_db, gap_srvc_data.srvc);
>  	gap_sdp_handle = add_sdp_record(&uuid, start, end,
> @@ -6308,6 +6309,7 @@ static void register_device_info_service(void)
>  	gatt_db_service_set_active(gatt_db, srvc_handle, true);
>  
>  	/* SDP */
> +	bt_uuid16_create(&uuid, 0x180a);
>  	end_handle = gatt_db_get_end_handle(gatt_db, srvc_handle);
>  	dis_sdp_handle = add_sdp_record(&uuid, srvc_handle, end_handle,
>  						"Device Information Service");
> @@ -6404,6 +6406,7 @@ static void register_gatt_service(void)
>  	gatt_db_service_set_active(gatt_db, srvc_handle, true);
>  
>  	/* SDP */
> +	bt_uuid16_create(&uuid, 0x1801);
>  	end_handle = gatt_db_get_end_handle(gatt_db, srvc_handle);
>  	gatt_sdp_handle = add_sdp_record(&uuid, srvc_handle, end_handle,
>  						"Generic Attribute Profile");
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
