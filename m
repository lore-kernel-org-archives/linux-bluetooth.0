Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 3/9] shared/hfp_at: Add skeleton of hfp_at_process_data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393320227-10931-4-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 25 Feb 2014 10:56:14 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <B8AE4DD9-3CD7-4CAE-9763-2734496D9BD7@holtmann.org>
References: <1393320227-10931-1-git-send-email-marcin.kraglak@tieto.com> <1393320227-10931-4-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> It will handle AT frames and recognize their commands. It will also
> call proper callback. If no callback was found, default handler
> will be called.
> ---
> src/shared/hfp_at.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> src/shared/hfp_at.h |   3 +
> 2 files changed, 178 insertions(+)
> 
> diff --git a/src/shared/hfp_at.c b/src/shared/hfp_at.c
> index bd1899b..eff0a38 100644
> --- a/src/shared/hfp_at.c
> +++ b/src/shared/hfp_at.c
> @@ -29,8 +29,183 @@
> 
> struct hfp_at {
> 	const struct hfp_at_handler *cmd_handlers;
> +	int offset;
> };
> 
> +/* Last cmd handler should have prefix NULL and will be returned if no other
> + * will be found
> + */
> +static const struct hfp_at_handler *hfp_at_find_cb(struct hfp_at *hfp_at,
> +						char *pref, uint8_t len)
> +{
> +	const struct hfp_at_handler *handler = hfp_at->cmd_handlers;
> +
> +	while (handler->prefix) {
> +		if (strlen(handler->prefix) == len)
> +			if (!memcmp(handler->prefix, pref, len))
> +				break;
> +
> +		handler++;
> +	}
> +
> +	return handler;
> +}
> +
> +static void hfp_at_call_handler(struct hfp_at *hfp_at, char *prefix, int len,
> +					const char *data, void *user_data,
> +					enum hfp_cmd_type type)
> +{
> +	const struct hfp_at_handler *handler;
> +
> +	handler = hfp_at_find_cb(hfp_at, prefix, len);
> +
> +	if (handler->prefix) {
> +		handler->cb(hfp_at, type, data, user_data);
> +		return;
> +	}
> +
> +	/* We set offset to 0 because it is unknown command */
> +	hfp_at->offset = 0;
> +	handler->cb(hfp_at, HFP_AT_UNKNOWN, data, user_data);
> +}
> +
> +static bool hfp_at_process_basic(struct hfp_at *hfp_at, const char *data,
> +								void *user_data)
> +{
> +	const char *prefix = data + hfp_at->offset;
> +	enum hfp_cmd_type type;
> +	char lookup_prefix[4];
> +	uint8_t pref_len = 0;
> +	bool equal = false;
> +	int i;
> +
> +	/* Check if first sign is character */
> +	if (isalpha(prefix[pref_len])) {
> +		/* Handle S-parameter prefix */
> +		if (toupper(prefix[pref_len]) == 'S') {
> +			do {
> +				pref_len++;
> +			} while (isdigit(prefix[pref_len]));
> +			/*S-parameter must be followed with number*/
> +			if (pref_len == 1)
> +				pref_len--;
> +		} else {
> +			/* It's just one-character prefix */
> +			pref_len++;
> +		}
> +	} else if (prefix[pref_len] == '&' && isalpha(prefix[pref_len + 1])) {
> +		/* Two-signed prefix starting with & */
> +		pref_len = 2;
> +	}

I am not sure we actually need this. HFP is pretty much only a subset. I am fine with not bothering with any of the details of V250 if we do not have to. Let Java deal with it if they want to.

> +
> +	if (pref_len == 0 || pref_len > sizeof(lookup_prefix))
> +		return false;
> +
> +	for (i = 0; i < pref_len; i++)
> +		lookup_prefix[i] = toupper(prefix[i]);
> +
> +	hfp_at->offset += pref_len;
> +
> +	if (lookup_prefix[0] == 'D') {
> +		type = HFP_AT_SET;
> +
> +		goto done;
> +	}
> +
> +	if (data[hfp_at->offset] == '=') {
> +		hfp_at->offset++;
> +		equal = true;
> +	}
> +
> +	if (data[hfp_at->offset] == '?') {
> +		hfp_at->offset++;
> +
> +		if (equal)
> +			type = HFP_AT_TEST;
> +		else
> +			type = HFP_AT_READ;
> +	} else if (equal) {
> +		type = HFP_AT_SET;
> +	} else {
> +		type = HFP_AT_COMMAND;
> +	}
> +
> +done:
> +	hfp_at_call_handler(hfp_at, lookup_prefix, pref_len, data, user_data,
> +									type);
> +
> +	return true;
> +}
> +
> +static bool hfp_at_process_extended(struct hfp_at *hfp_at, const char *data,
> +								void *user_data)
> +{
> +	const char *prefix = data + hfp_at->offset;
> +	const char *separators = ";?=";
> +	enum hfp_cmd_type type;
> +	char lookup_prefix[18];
> +	bool equal = false;
> +	uint8_t pref_len;
> +	int i;
> +
> +	/* Lookup for first separator */
> +	pref_len = strcspn(prefix, separators);
> +
> +	if (pref_len > 17 || pref_len < 2)
> +		return false;
> +
> +	for (i = 0; i < pref_len; i++)
> +		lookup_prefix[i] = toupper(prefix[i]);
> +
> +	hfp_at->offset += pref_len;
> +
> +	if (data[hfp_at->offset] == '=') {
> +		hfp_at->offset++;
> +		equal = true;
> +	}
> +
> +	if (data[hfp_at->offset] == '?') {
> +		hfp_at->offset++;
> +
> +		if (equal)
> +			type = HFP_AT_TEST;
> +		else
> +			type = HFP_AT_READ;
> +	} else if (equal) {
> +		type = HFP_AT_SET;
> +	} else {
> +		type = HFP_AT_COMMAND;
> +	}

Still trying to figure out why we need a variable equal here. Might want to restructure the code a little bit. 

Also do not forget to check the length of your string. Remote devices can send you garbage.

I also fail to see what difference between basic and extended is. Seems like a lot of the basic code is shared.

> +
> +	hfp_at_call_handler(hfp_at, lookup_prefix, pref_len, data, user_data,
> +									type);
> +
> +	return true;
> +}
> +
> +static bool hfp_at_is_extended_cmd(struct hfp_at *hfp_at, const char *data)
> +{
> +	/* Extended commands names always begin with character "+" V250 5.4.1*/
> +	return data[hfp_at->offset] == '+';
> +}

Lets not go overboard with functions that serve only a single purpose. Do that inline in the code.

> +
> +bool hfp_at_process_data(struct hfp_at *hfp_at, const char *data,
> +								void *user_data)
> +{
> +	if (strlen(data) < 3)
> +		return false;
> +
> +	if (strncmp(data, "AT", 2))
> +		return false;

actually they way I read is that AT and at are valid. However not At and not aT. We would also need to strip any leading whitespaces. This should be done on level down if I have not already implemented it.

> +
> +	hfp_at->offset = 2;
> +
> +	if (hfp_at_is_extended_cmd(hfp_at, data))
> +		return hfp_at_process_extended(hfp_at, data, user_data);
> +	else
> +		return hfp_at_process_basic(hfp_at, data, user_data);
> +}
> +
> struct hfp_at *hfp_at_new(const struct hfp_at_handler *handlers)
> {
> 	struct hfp_at *hfp_at;
> diff --git a/src/shared/hfp_at.h b/src/shared/hfp_at.h
> index fe074f2..0b628b5 100644
> --- a/src/shared/hfp_at.h
> +++ b/src/shared/hfp_at.h
> @@ -39,5 +39,8 @@ struct hfp_at_handler {
> 	hfp_at_cmd_cb cb;
> };
> 
> +bool hfp_at_process_data(struct hfp_at *hfp_at, const char *data,
> +							void *user_data);
> +
> struct hfp_at *hfp_at_new(const struct hfp_at_handler *handlers);
> void hfp_at_free(struct hfp_at *hfp_at);
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

