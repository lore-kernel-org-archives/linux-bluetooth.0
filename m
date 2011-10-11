Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Oct 2011 16:41:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Support for encoding UTF-8 characters in vCard's
 fields
Message-ID: <20111011134110.GB19276@fusion.localdomain>
References: <1318239417-26769-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318239417-26769-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Mon, Oct 10, 2011, Rafal Michalski wrote:
> +static gboolean utf8_select(char *field)
> +{
> +	char *pos;
> +	gunichar utf;
> +
> +	if (g_utf8_validate(field, -1, NULL) == FALSE)
> +		return FALSE;
> +
> +	for (pos = field; (utf = g_utf8_get_char(pos)) != 0; ) {
> +		/* Test for non-standard UTF-8 character (out of range
> +		 * standard ASCII set), composed of more than single byte
> +		 * and represented by 32-bit value greater than 0x7F */
> +		if (utf > ASCII_LIMIT)
> +			return TRUE;
> +
> +		pos = g_utf8_next_char(pos);
> +	}
> +
> +	return FALSE;
> +}

Could we try to simplify the for-loop here a little bit. Would something
like the following work:

for (pos = field; *pos != '\0'; pos = g_utf8_next_char(pos)) {
	if (g_utf8_get_char(pos) > ASCII_LIMIT)
		return TRUE;
}

As you see a separate gunichar variable isn't necessarily needed at all.

>  static void vcard_qp_print_encoded(GString *vcards, const char *desc, ...)
>  {
> -	char *field;
> +	char *field, *charset = "";
>  	va_list ap;
>  
> -	vcard_printf(vcards, "%s;ENCODING=QUOTED-PRINTABLE:", desc);
> +	va_start(ap, desc);
> +
> +	for (field = va_arg(ap, char *); field; field = va_arg(ap, char *)) {
> +		if (utf8_select(field) == TRUE) {
> +			charset = ";CHARSET=UTF-8";
> +			break;
> +		}
> +	}

Due to the way that you use charset it should be declared const char *.
Maybe the same for field too?

Johan
