Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/11] android/tester: Use uint16_t for handles
Date: Tue, 13 Jan 2015 14:48:44 +0100
Message-ID: <5620633.L9LTxfBoZk@uw000953>
In-Reply-To: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 08 of January 2015 10:17:39 Jakub Tyszkowski wrote:
> Handles are only 2 bytes in size. We should use uint16_t to be able to
> safely cast iovec with such handle to uint16_t and vice versa.
> ---
>  android/tester-gatt.c | 28 ++++++++++++++--------------
>  android/tester-main.h | 16 ++++++++--------
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index f6b0492..f4d22fd 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -81,9 +81,9 @@
>  
>  static struct queue *list; /* List of gatt test cases */
>  
> -static int srvc1_handle;
> -static int inc_srvc1_handle;
> -static int char1_handle;
> +static uint16_t srvc1_handle;
> +static uint16_t inc_srvc1_handle;
> +static uint16_t char1_handle;
>  
>  struct set_att_data {
>  	char *to;
> @@ -92,7 +92,7 @@ struct set_att_data {
>  };
>  
>  struct att_write_req_data {
> -	int *attr_handle;
> +	uint16_t *attr_handle;
>  	uint8_t *value;
>  };
>  
> @@ -189,12 +189,12 @@ struct add_service_data {
>  
>  struct add_included_service_data {
>  	int app_id;
> -	int *inc_srvc_handle;
> -	int *srvc_handle;
> +	uint16_t *inc_srvc_handle;
> +	uint16_t *srvc_handle;
>  };
>  struct add_char_data {
>  	int app_id;
> -	int *srvc_handle;
> +	uint16_t *srvc_handle;
>  	bt_uuid_t *uuid;
>  	int properties;
>  	int permissions;
> @@ -202,30 +202,30 @@ struct add_char_data {
>  
>  struct add_desc_data {
>  	int app_id;
> -	int *srvc_handle;
> +	uint16_t *srvc_handle;
>  	bt_uuid_t *uuid;
>  	int permissions;
>  };
>  
>  struct start_srvc_data {
>  	int app_id;
> -	int *srvc_handle;
> +	uint16_t *srvc_handle;
>  	int transport;
>  };
>  
>  struct stop_srvc_data {
>  	int app_id;
> -	int *srvc_handle;
> +	uint16_t *srvc_handle;
>  };
>  
>  struct delete_srvc_data {
>  	int app_id;
> -	int *srvc_handle;
> +	uint16_t *srvc_handle;
>  };
>  
>  struct send_indication_data {
>  	int app_id;
> -	int *attr_handle;
> +	uint16_t *attr_handle;
>  	int conn_id;
>  	int len;
>  	int confirm;
> @@ -531,7 +531,7 @@ static struct add_service_data add_sec_service_data_1 = {
>  	.num_handles = 1
>  };
>  
> -static int srvc_bad_handle = -1;
> +static uint16_t srvc_bad_handle = 0xffff;
>  
>  static struct add_included_service_data add_inc_service_data_1 = {
>  	.app_id = APP1_ID,
> @@ -634,7 +634,7 @@ static struct delete_srvc_data delete_bad_srvc_data_1 = {
>  	.srvc_handle = &srvc_bad_handle
>  };
>  
> -static int srvc_indication_handle_1 = 0x01;
> +static uint16_t srvc_indication_handle_1 = 0x01;
>  
>  static struct send_indication_data send_indication_data_1 = {
>  	.app_id = APP1_ID,
> diff --git a/android/tester-main.h b/android/tester-main.h
> index dc1a2bb..7fe73fe 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -651,11 +651,11 @@ struct bt_callback_data {
>  	int offset;
>  	bool is_long;
>  	int connected;
> -	int *attr_handle;
> -	int *srvc_handle;
> -	int *inc_srvc_handle;
> -	int *char_handle;
> -	int *desc_handle;
> +	uint16_t *attr_handle;
> +	uint16_t *srvc_handle;
> +	uint16_t *inc_srvc_handle;
> +	uint16_t *char_handle;
> +	uint16_t *desc_handle;
>  	btgatt_srvc_id_t *service;
>  	btgatt_gatt_id_t *characteristic;
>  	btgatt_gatt_id_t *descriptor;
> @@ -709,9 +709,9 @@ struct step {
>  	void *set_data_to;
>  	int set_data_len;
>  
> -	int *store_srvc_handle;
> -	int *store_char_handle;
> -	int *store_desc_handle;
> +	uint16_t *store_srvc_handle;
> +	uint16_t *store_char_handle;
> +	uint16_t *store_desc_handle;
>  };
>  
>  struct test_case {
> 

Patches 1-5 applied, thanks.

-- 
Best regards, 
Szymon Janc
