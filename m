Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCHv3 3/6] shared/hfp: Add get_number implementation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393619636-23762-3-git-send-email-marcin.kraglak@tieto.com>
Date: Fri, 28 Feb 2014 19:27:10 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FBA29747-DEFB-4420-9010-A01792933120@holtmann.org>
References: <1393619636-23762-1-git-send-email-marcin.kraglak@tieto.com> <1393619636-23762-3-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> User can call this function with hfp_gw_result, which will
> be passed to prefix handler.
> ---
> src/shared/hfp.c | 33 +++++++++++++++++++++++++++++++++
> src/shared/hfp.h |  2 ++
> 2 files changed, 35 insertions(+)
> 
> diff --git a/src/shared/hfp.c b/src/shared/hfp.c
> index 8feaf16..d168ac4 100644
> --- a/src/shared/hfp.c
> +++ b/src/shared/hfp.c
> @@ -218,6 +218,39 @@ done:
> 	return true;
> }
> 
> +static void next_field(struct hfp_gw_result *result)
> +{
> +	if (result->data[result->offset] == ',')
> +		result->offset++;
> +}
> +
> +bool hfp_gw_result_get_number(struct hfp_gw_result *result, int *val)
> +{
> +	int temp = 0;
> +	int i;

	int i, tmp = 0;

> +
> +	skip_whitespace(result);
> +
> +	i = result->offset;
> +
> +	while (result->data[i] >= '0' && result->data[i] <= '9') {
> +		temp *= 10;
> +		temp += result->data[i++] - '0’;

	tmp = (tmp * 10) + (result->data[i++] - ‘0’;

This should be the cheaper operation since tmp does not need be reevaluated twice.

Are we going to support negative number? I do not even remember if they are valid in AT commands. Has been too long. Might also go straight to unsigned int *val in that case.

Regards

Marcel

