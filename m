Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCHv2 3/8] shared/hfp: Add initial implementiation of processing commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393494006-20363-4-git-send-email-marcin.kraglak@tieto.com>
Date: Thu, 27 Feb 2014 23:05:13 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BA9EB144-665E-4A51-81EF-EEEFAB18C822@holtmann.org>
References: <1393494006-20363-1-git-send-email-marcin.kraglak@tieto.com> <1393494006-20363-4-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> ---
> src/shared/hfp.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index e164dd6..cf54a8f 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -69,6 +69,11 @@ struct prefix_handler_data {
> 	hfp_result_func_t callback;
> };
> 
> +struct hfp_gw_result {
> +	const char *data;
> +	int offset;
> +};
> +
> static void destroy_prefix_handler_data(void *data)
> {
> 	struct prefix_handler_data *handler = data;
> @@ -130,6 +135,46 @@ static void wakeup_writer(struct hfp_gw *hfp)
> 	hfp->writer_active = true;
> }
> 
> +static bool process_basic(struct hfp_gw *hfp, struct hfp_gw_result *result)
> +{
> +	return false;
> +}
> +
> +static bool process_extended(struct hfp_gw *hfp, struct hfp_gw_result *result)
> +{
> +	return false;
> +}
> +
> +static void skip_whitespace(struct hfp_gw_result *result)
> +{
> +	while (result->data[result->offset] == ' ')
> +		result->offset++;
> +}
> +
> +static bool call_prefix_handler(struct hfp_gw *hfp, const char *data)
> +{
> +	struct hfp_gw_result result;
> +
> +	result.offset = 0;
> +	result.data = data;
> +
> +	skip_whitespace(&result);

I would just do the skip leading whitespace here without bothering putting it into a separate function. There is really no point.

> +
> +	if (strlen(data + result.offset) < 3)
> +		return false;
> +
> +	if (strncmp(data + result.offset, "AT", 2))
> +		if (strncmp(data + result.offset, "at", 2))
> +			return false;
> +
> +	result.offset += 2;
> +
> +	if (data[result.offset] == '+')
> +		return process_extended(hfp, &result);
> +	else
> +		return process_basic(hfp, &result);

Please do not do this. I mentioned this before, this basic vs extended is pointless.

Command matching should be either based on commands like “D” or “+BRSF” and not bother trying to treat the + any special. See how src/emulator.c in oFono registers all the handlers.

Regards

Marcel

