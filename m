Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/handsfree-client: Decrease number of memcpy
Date: Wed, 10 Dec 2014 13:29:24 +0100
Message-ID: <1513695.a75XeskFpa@leonov>
In-Reply-To: <1418046990-12279-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418046990-12279-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 08 of December 2014 14:56:30 Lukasz Rymanowski wrote:
> Some string we can directly copy from context to IPC event struct.
> ---
>  android/handsfree-client.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index b32a038..a559505 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -85,6 +85,9 @@
>  #define CODEC_ID_CVSD 0x01
>  #define CODEC_ID_MSBC 0x02
> 
> +#define MAX_NUMBER_LEN 33
> +#define MAX_OPERATOR_NAME_LEN 17
> +
>  enum hfp_indicator {
>  	HFP_INDICATOR_SERVICE = 0,
>  	HFP_INDICATOR_CALL,
> @@ -941,7 +944,6 @@ static void clcc_cb(struct hfp_context *context, void
> *user_data) uint8_t buf[IPC_MTU];
>  	struct hal_ev_hf_client_current_call *ev = (void *) buf;
>  	unsigned int val;
> -	char number[33];
> 
>  	DBG("");
> 
> @@ -983,10 +985,9 @@ static void clcc_cb(struct hfp_context *context, void
> *user_data)
> 
>  	ev->multiparty = val;
> 
> -	if (hfp_context_get_string(context, number, sizeof(number))) {
> -		ev->number_len = strlen(number) + 1;
> -		memcpy(ev->number, number, ev->number_len);
> -	}
> +	if (hfp_context_get_string(context, (char *) &ev->number[0],
> +								MAX_NUMBER_LEN))
> +		ev->number_len = strlen((char *) ev->number) + 1;
> 
>  	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
>  					HAL_EV_HF_CLIENT_CURRENT_CALL,
> @@ -1023,7 +1024,6 @@ static void cnum_cb(struct hfp_context *context, void
> *user_data) {
>  	uint8_t buf[IPC_MTU];
>  	struct hal_ev_hf_client_subscriber_service_info *ev = (void *) buf;
> -	char number[33];
>  	unsigned int service;
> 
>  	DBG("");
> @@ -1031,11 +1031,14 @@ static void cnum_cb(struct hfp_context *context,
> void *user_data) /* Alpha field is empty string, just skip it */
>  	hfp_context_skip_field(context);
> 
> -	if (!hfp_context_get_string(context, number, sizeof(number))) {
> +	if (!hfp_context_get_string(context, (char *) &ev->name[0],
> +							MAX_NUMBER_LEN)) {
>  		error("hf-client: Could not get number");
>  		return;
>  	}
> 
> +	ev->name_len = strlen((char *) &ev->name[0]) + 1;
> +
>  	/* Type is not used in Android */
>  	hfp_context_skip_field(context);
> 
> @@ -1045,9 +1048,6 @@ static void cnum_cb(struct hfp_context *context, void
> *user_data) if (!hfp_context_get_number(context, &service))
>  		return;
> 
> -	ev->name_len = strlen(number) + 1;
> -	memcpy(ev->name, number, ev->name_len);
> -
>  	switch (service) {
>  	case 4:
>  		ev->type = HAL_HF_CLIENT_SUBSCR_TYPE_VOICE;
> @@ -1069,7 +1069,6 @@ static void cops_cb(struct hfp_context *context, void
> *user_data) {
>  	uint8_t buf[IPC_MTU];
>  	struct hal_ev_hf_client_operator_name *ev = (void *) buf;
> -	char name[17];
>  	unsigned int format;
> 
>  	DBG("");
> @@ -1083,13 +1082,13 @@ static void cops_cb(struct hfp_context *context,
> void *user_data) if (format != 0)
>  		info("hf-client: Not correct string format in +COSP");
> 
> -	if (!hfp_context_get_string(context, name, sizeof(name))) {
> +	if (!hfp_context_get_string(context, (char *) &ev->name[0],
> +						MAX_OPERATOR_NAME_LEN)) {
>  		error("hf-client: incorrect COPS response");
>  		return;
>  	}
> 
> -	ev->name_len = strlen(name) + 1;
> -	memcpy(ev->name, name, ev->name_len);
> +	ev->name_len = strlen((char *) &ev->name[0]) + 1;
> 
>  	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
>  					HAL_EV_HF_CLIENT_OPERATOR_NAME,

Applied, thanks.

-- 
BR
Szymon Janc
