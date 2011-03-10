Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 16:28:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 3/4] Sim Access Profile Server
Message-ID: <20110310142810.GB22537@jh-x301>
References: <1298549606-16594-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1298549606-16594-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298549606-16594-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

Some coding-style issues here. In general please refer to the kernel
CodingStyle document. In addition to that the ofono project has quite a
good document to complement the kernel guidelines:

http://git.kernel.org/?p=network/ofono/ofono.git;a=blob_plain;f=doc/coding-style.txt;hb=HEAD

On Thu, Feb 24, 2011, Waldemar Rymarkiewicz wrote:
> +/* Connection Status - SAP v1.1 section 5.2.2 */
> +typedef enum {
> +	SAP_STATUS_OK				= 0x00,
> +	SAP_STATUS_CONNECTION_FAILED		= 0x01,
> +	SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED	= 0x02,
> +	SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL	= 0x03,
> +	SAP_STATUS_OK_ONGOING_CALL		= 0x04
> +} sap_status_t;
...
> +enum sap_protocol {
> +	SAP_CONNECT_REQ		= 0x00,

Why do you have typedef for the first, but not for the second? In
general the tendency in the source tree is to avoid typedefs where ever
possible (since they make it more difficult to discover the real types
of variables) so I'd lean towards removing the typedefs where you've
used them now.

> +/* Parameters Ids - SAP 1.1 section 5.2 */
> +#define SAP_PARAM_ID_MAX_MSG_SIZE		0x00
> +#define SAP_PARAM_ID_MAX_MSG_SIZE_LEN		0x02

And here you've got defines instead of enums. What rule have you used to
make the choice regarding when to use what?

> +static int send_message(struct sap_connection *conn, void *buf, gssize size)
> +{
> +	gsize written = 0;
> +	GError *gerr = NULL;
> +	GIOStatus gstatus;
> +
> +	if (!conn || !buf)
> +		return -1;
> +
> +	DBG("size = %d",(unsigned int)size);

Firstly, there's a space missing after the typecast. Secondly, you
should need the typecast here. AFAIK gsize is the same as size_t which
maps to the %zu format specifier. Actually, if possible please avoid
using GLib types for which libc already provides good alternatives. I.e.
size_t in your own code might actually work fine.

> +	gstatus = g_io_channel_write_chars(conn->io, buf, size, &written,
> +							&gerr);
> +
> +	if (gstatus != G_IO_STATUS_NORMAL) {

No empty line needed before the if-statement (check the ofono guidelines
about this).

> +	if (written != (gsize)size)

Missing space before after the typecast.

> +		error("write error.(written %d size %d)", written, size);

Seems like the format specifiers might be wrong here. %zu for size_t and
%zd for ssize_t.

> +	if (!conn)
> +		return -1;

In general, try to avoid -1 as a return code and use more specific POSIX
codes instead, e.g. -EINVAL here. That makes it easier to add more
fine-grained error handling later.

> +	if (conn->state != SAP_STATE_GRACEFUL_DISCONNECT &&
> +			conn->state != SAP_STATE_IMMEDIATE_DISCONNECT) {
> +		error("Processing error (state %.2X pr %.2X param)",
> +			conn->state, conn->processing_req);
> +		return -EPERM;
> +	}

Ah, I see here you do it. So you're actually being inconsistent with
yourself in the first case.

> +	if (!param)
> +		goto error_rsp;
> +
> +	if (conn->state != SAP_STATE_DISCONNECTED) {
> +		goto error_rsp;
> +	}

No {} for one-line scopes (and you're inconsistent with yourself even
within the same function here since the first if-statement doesn't have
{}.

> +static int disconnect_req(struct sap_connection *conn
> +				, sap_disconnection_type_t disc_type)

What's up with the stray "," in the beginning of the second line?

> +{
> +
> +	DBG("conn %p type 0x%.2X state %d", conn, disc_type, conn->state);

No empty line after the {

> +		}
> +		/* Disconnection is ongoing - do nothing. */
> +		return 0;

Empty line after the }

> +	error("Processing error (state %.2X pr %.2X param)", conn->state,
> +			conn->processing_req);

I think the convention for printing byte values is 0x%02x. Also, seems
like the second line might be too little indented (it should be as much
as possible as long as the line remains under 80 columns.

> +
> +	return FALSE;
> +}
> +
> +
> +int sap_connect_rsp(void *sap_device, sap_status_t status, uint16_t maxmsgsize)

Never two consecutive empty lines anywhere.

> +	DBG("state %x pr %x status %x", conn->state, conn->processing_req,
> +			status);

You seem to be quite inconsistent with printing byte values in hex
format. I suppose 0x%02x should be used for req and status while for
state %d might make most sense.

> +	DBG("state %x pr %x", conn->state, conn->processing_req);

Same here.

> +	switch (conn->state) {
> +	case SAP_STATE_CLIENT_DISCONNECT:
> +		memset(&msg, 0, sizeof(msg));
> +		msg.id = SAP_DISCONNECT_RESP;
> +
> +		conn->state = SAP_STATE_DISCONNECTED;
> +		conn->processing_req = SAP_NO_REQ;
> +
> +		/* Timer will close channel if client doesn't do it.*/
> +		start_guard_timer(conn, SAP_TIMER_NO_ACTIVITY);
> +
> +		return send_message(sap_device, &msg, sizeof(msg));
> +
> +	case SAP_STATE_IMMEDIATE_DISCONNECT:
> +		conn->state = SAP_STATE_DISCONNECTED;
> +		conn->processing_req = SAP_NO_REQ;
> +
> +		if (conn->io) {
> +			g_io_channel_shutdown(conn->io, TRUE, NULL);
> +			g_io_channel_unref(conn->io);
> +		}
> +		return 0;
> +	default:

You're being inconsistent with yourself here. In the first case branch
you've got an empty line after the return statement. In the second
branch you don't. To me the one with the empty line if more readable.
Also, please add an empty line after the closing } of the if-statement.

> +	if (!conn)
> +		return -1;

Probably -EINVAL?

> +
> +	conn->processing_req = SAP_NO_REQ;
> +	return send_message(sap_device, buf, size);
> +}

Add an empty line before the return.

I'm running out of time here, so I'll need to get back to this patch
later (it is quite huge btw, so if at all possible try splitting it up
into smaller patches).

Johan
