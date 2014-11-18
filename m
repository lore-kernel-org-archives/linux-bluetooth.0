Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 14/14] android/handsfree-client: Implement codec negotiations
Date: Tue, 18 Nov 2014 22:58:52 +0100
Message-ID: <3758767.CHCAAQ9We3@leonov>
In-Reply-To: <1415789377-20458-15-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com> <1415789377-20458-15-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 12 of November 2014 11:49:37 Lukasz Rymanowski wrote:
> ---
>  android/handsfree-client.c | 62
> ++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 62
> insertions(+)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index 4338c11..74d1547 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -116,6 +116,7 @@ struct device {
>  	struct hfp_hf *hf;
>  	uint8_t state;
> 
> +	uint8_t negotiated_codec;
>  	uint32_t features;
>  	struct hfp_codec codecs[2];
> 
> @@ -1034,6 +1035,66 @@ static void binp_cb(struct hfp_context *context, void
> *user_data) sizeof(*ev) + ev->number_len, ev);
>  }
> 
> +static bool is_codec_supported_localy(struct device *dev, uint8_t codec)
> +{
> +	int i;
> +
> +	for (i = 0; i < CODECS_COUNT; i++) {
> +		if (dev->codecs[i].type != codec)
> +			continue;
> +
> +		return dev->codecs[i].local_supported;
> +	}
> +
> +	return false;
> +}
> +
> +static void bcs_resp(enum hfp_result result, enum hfp_error cme_err,
> +							void *user_data)
> +{
> +	DBG("%d", result);

Shouldn't we handle error response?

> +}
> +
> +static void bcs_cb(struct hfp_context *context, void *user_data)
> +{
> +	struct device *dev = user_data;
> +	uint32_t codec;

unsigned int

> +	char codecs_string[2 * CODECS_COUNT + 1];
> +	char cmd[sizeof(codecs_string) + 7];

Those really deserve some comment.

> +
> +	DBG("");
> +
> +	if (!context) {
> +		error("hf-client: incorrect BCS response");
> +		return;
> +	}

Not needed.

> +
> +	memset(cmd, 0, sizeof(cmd));
> +
> +	if (!hfp_context_get_number(context, &codec))
> +		goto failed;
> +
> +	if (!is_codec_supported_localy(dev, codec))
> +		goto failed;
> +
> +	sprintf(cmd, "AT+BCS=%d", codec);
> +
> +	dev->negotiated_codec = codec;
> +
> +	goto done;
> +
> +failed:

I'd avoid this mixed labels jump, those make code hard to read.
I'd make failed label handle only fail case. Just call hfp_hf_send_command 
instead of those sprintfs. This will also make cmd not needed.

> +	error("hf-client: Could not get codec");
> +
> +	strcpy(cmd, "AT+BCS=");
> +
> +	get_local_codecs_string(dev, codecs_string, sizeof(codecs_string));
> +	strcat(cmd, codecs_string);

maybe this is not really needed since hfp_hf_send_command accepts format 
string?

hfp_hf_send_command(dev->hf, bcs_resp, dev, "AT+BCS=%s", codecs_string);

> +
> +done:
> +	hfp_hf_send_command(dev->hf, bcs_resp, dev, cmd);
> +}
> +
>  static void slc_completed(struct device *dev)
>  {
>  	int i;
> @@ -1064,6 +1125,7 @@ static void slc_completed(struct device *dev)
>  	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
>  	hfp_hf_register(dev->hf, cnum_cb, "+CNUM", dev, NULL);
>  	hfp_hf_register(dev->hf, binp_cb, "+BINP", dev, NULL);
> +	hfp_hf_register(dev->hf, bcs_cb, "+BCS", dev, NULL);
> 
>  	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS=3,0"))
>  		info("hf-client: Could not send AT+COPS=3,0");

-- 
BR
Szymon Janc
