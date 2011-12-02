Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 16:37:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 obexd 3/4] Add response handling for MAP client
Message-ID: <20111202143713.GA24812@x220>
References: <1322829142-7855-1-git-send-email-bulislaw@linux.com>
 <1322829142-7855-3-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322829142-7855-3-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Fri, Dec 02, 2011, Bartosz Szatkowski wrote:
> +static struct error_code {
> +	const char *name;
> +	guint8 code;
> +} map_errors[] = {
> +	{"Success", G_OBEX_RSP_SUCCESS},
> +	{"Bad Request", G_OBEX_RSP_BAD_REQUEST},
> +	{"Not Implemented", G_OBEX_RSP_NOT_IMPLEMENTED},
> +	{"Service Unavailable", G_OBEX_RSP_SERVICE_UNAVAILABLE},
> +	{"Forbidden", G_OBEX_RSP_FORBIDDEN},
> +	{"Unauthorized", G_OBEX_RSP_UNAUTHORIZED},
> +	{"Precondition Failed", G_OBEX_RSP_PRECONDITION_FAILED},
> +	{"Not Acceptable", G_OBEX_RSP_NOT_ACCEPTABLE},
> +	{"Not Found", G_OBEX_RSP_NOT_FOUND},
> +	{ }

The table is missing spaces on each line after { and before }

> +static const char *get_error_string(guint8 err_code)
> +{
> +	struct error_code *error;
> +
> +	for (error = map_errors; error != NULL; error++)
> +		if (error->code == err_code)
> +			return error->name;
> +
> +	return NULL;
> +}

It'd probably make sense to make this kind of function more widely
available, maybe through gobex. However instead of a NULL return I'd
return "<unknown>" to avoid passing NULL pointers to %s format
specifiers like you're doing below (I know this will typically just work
and add a "(null)" to the string, but it's still not a very good
practice and can cause misleading logs:

> +		reply = g_dbus_create_error(map->msg,
> +					"org.openobex.Error.Response",
> +					"%s(0x%X)", get_error_string(err_code),
> +					err_code);

You're also missing a space between %s and ( and please use 0x%02x for
single byte values.

Johan
