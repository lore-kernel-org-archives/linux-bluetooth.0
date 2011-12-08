Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 13:07:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/6] gobex: Add translating error codes to strings
Message-ID: <20111208110710.GD30533@x220>
References: <1323085309-23094-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323085309-23094-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Mon, Dec 05, 2011, Bartosz Szatkowski wrote:
> +struct error_code {
> +	guint8 code;
> +	const char *name;
> +} obex_errors[] = {
> +	{ G_OBEX_RSP_CONTINUE, "Continue" },
> +	{ G_OBEX_RSP_SUCCESS, "Success" },
> +	{ G_OBEX_RSP_CREATED, "Created" },
> +	{ G_OBEX_RSP_ACCEPTED, "Accepted" },
> +	{ G_OBEX_RSP_NON_AUTHORITATIVE, "Non Authoritative" },
> +	{ G_OBEX_RSP_NO_CONTENT, "No Content" },
> +	{ G_OBEX_RSP_RESET_CONTENT, "Reset Content" },
> +	{ G_OBEX_RSP_PARTIAL_CONTENT, "Partial Content" },
> +	{ G_OBEX_RSP_MULTIPLE_CHOICES, "Multiple Choices" },
> +	{ G_OBEX_RSP_MOVED_PERMANENTLY, "Moved Permanently" },
> +	{ G_OBEX_RSP_MOVED_TEMPORARILY, "Moved Temporarily" },
> +	{ G_OBEX_RSP_SEE_OTHER, "See Other" },
> +	{ G_OBEX_RSP_NOT_MODIFIED, "Not Modified" },
> +	{ G_OBEX_RSP_USE_PROXY, "Use Proxy" },
> +	{ G_OBEX_RSP_BAD_REQUEST, "Bad Request" },
> +	{ G_OBEX_RSP_UNAUTHORIZED, "Unauthorized" },
> +	{ G_OBEX_RSP_PAYMENT_REQUIRED, "Payment Required" },
> +	{ G_OBEX_RSP_FORBIDDEN, "Forbidden" },
> +	{ G_OBEX_RSP_NOT_FOUND, "Not Found" },
> +	{ G_OBEX_RSP_METHOD_NOT_ALLOWED, "Method Not Allowed" },
> +	{ G_OBEX_RSP_NOT_ACCEPTABLE, "Not Acceptable" },
> +	{ G_OBEX_RSP_PROXY_AUTH_REQUIRED, "Proxy Auth Required" },
> +	{ G_OBEX_RSP_REQUEST_TIME_OUT, "Request Time Out" },
> +	{ G_OBEX_RSP_CONFLICT, "Conflict" },
> +	{ G_OBEX_RSP_GONE, "Gone" },
> +	{ G_OBEX_RSP_LENGTH_REQUIRED, "Length Required" },
> +	{ G_OBEX_RSP_PRECONDITION_FAILED, "Precondition Failed" },
> +	{ G_OBEX_RSP_REQ_ENTITY_TOO_LARGE, "Req Entity Too Large" },
> +	{ G_OBEX_RSP_REQ_URL_TOO_LARGE, "Req Url Too Large" },
> +	{ G_OBEX_RSP_UNSUPPORTED_MEDIA_TYPE, "Unsupported Media Type" },
> +	{ G_OBEX_RSP_INTERNAL_SERVER_ERROR, "Internal Server Error" },
> +	{ G_OBEX_RSP_NOT_IMPLEMENTED, "Not Implemented" },
> +	{ G_OBEX_RSP_BAD_GATEWAY, "Bad Gateway" },
> +	{ G_OBEX_RSP_SERVICE_UNAVAILABLE, "Service Unavailable" },
> +	{ G_OBEX_RSP_GATEWAY_TIMEOUT, "Gateway Timeout" },
> +	{ G_OBEX_RSP_VERSION_NOT_SUPPORTED, "Version Not Supported" },
> +	{ G_OBEX_RSP_DATABASE_FULL, "Database Full" },
> +	{ G_OBEX_RSP_DATABASE_LOCKED, "Database Locked" },
> +	{ }
> +};

Could you indent the strings (with tabs) so that they all start at the
same column? That'd make it easier to read the table.

> +const char *g_obex_strerror(guint8 err_code)
> +{
> +	struct error_code *error;
> +
> +	for (error = obex_errors; error != NULL; error++)
> +		if (error->code == err_code)
> +			return error->name;
> +
> +	return "<unknown>";
> +}

I guess you never tested this function with a code that's not in the
table? The loop will go past the end in such a case. You're assigning a
pointer to the table in the beginning and then just incrementing the
pointer. What makes you think that the pointer would magically become
NULL suddenly? What would work is if you make the last entry
{ 0x00, NULL }, and then check for error->name != NULL in the for-loop.

Johan
