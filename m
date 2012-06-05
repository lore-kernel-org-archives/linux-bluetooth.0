Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] gattrib: Fix command timeout handling
Date: Tue, 5 Jun 2012 12:25:57 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B547BF1@DNCE05.ent.ti.com>
References: <1338898622-18408-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1338898622-18408-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,
 
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Johan Hedberg
> Sent: Tuesday, June 05, 2012 3:17 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: [PATCH] gattrib: Fix command timeout handling
> 
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch fixes command timeout handling. Previously attrib_destroy
> was
> explicitly called which ignored any reference holders. This patch fixes
> the issue by first passing errors to command callbacks and after that
> marking the GAttrib object as stale so no further operations can be
> done.
> ---
> This is an untested patch which should hopefully fix bluetoothd crashes
> when we fail to receive a response to a command. I'm sending it to
> linux-bluetooth in case someone can spot some obvious problem with it.
> If there are no objections I'll complete testing of it during the next
> 24 hours and then apply it upstream.
> 
>  attrib/att.c     |    4 ++++
>  attrib/att.h     |    2 ++
>  attrib/gattrib.c |   29 ++++++++++++++++++++++++++++-
>  3 files changed, 34 insertions(+), 1 deletions(-)
> 
> diff --git a/attrib/att.c b/attrib/att.c
> index a3a8947..c8e2e1d 100644
> --- a/attrib/att.c
> +++ b/attrib/att.c
> @@ -72,6 +72,10 @@ const char *att_ecode2str(uint8_t status)
>  		return "Insufficient Resources to complete the request";
>  	case ATT_ECODE_IO:
>  		return "Internal application error: I/O";
> +	case ATT_ECODE_TIMEOUT:
> +		return "A timeout occured";
> +	case ATT_ECODE_ABORTED:
> +		return "The operation was aborted";
>  	default:
>  		return "Unexpected error code";
>  	}
> diff --git a/attrib/att.h b/attrib/att.h
> index d12a7f2..8979c95 100644
> --- a/attrib/att.h
> +++ b/attrib/att.h
> @@ -72,6 +72,8 @@
>  #define ATT_ECODE_INSUFF_RESOURCES		0x11
>  /* Application error */
>  #define ATT_ECODE_IO				0xFF
> +#define ATT_ECODE_TIMEOUT			0xFE
> +#define ATT_ECODE_ABORTED			0xFD
> 
>  /* Characteristic Property bit field */
>  #define ATT_CHAR_PROPER_BROADCAST		0x01
> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
> index 9886a92..29c3585 100644
> --- a/attrib/gattrib.c
> +++ b/attrib/gattrib.c
> @@ -53,6 +53,7 @@ struct _GAttrib {
>  	guint next_evt_id;
>  	GDestroyNotify destroy;
>  	gpointer destroy_user_data;
> +	gboolean stale;
>  };
> 
>  struct command {
> @@ -252,8 +253,25 @@ gboolean g_attrib_set_destroy_function(GAttrib
> *attrib,
>  static gboolean disconnect_timeout(gpointer data)
>  {
>  	struct _GAttrib *attrib = data;
> +	struct command *c;
> 
> -	attrib_destroy(attrib);
> +	c = g_queue_pop_head(attrib->requests);
> +	if (c == NULL)
> +		goto done;
> +
> +	if (c->func)
> +		c->func(ATT_ECODE_TIMEOUT, NULL, 0, c->user_data);
> +
> +	command_destroy(c);
> +
> +	while ((c = g_queue_pop_head(attrib->requests))) {
> +		if (c->func)
> +			c->func(ATT_ECODE_ABORTED, NULL, 0, c->user_data);
> +		command_destroy(c);
> +	}
> +
> +done:
> +	attrib->stale = TRUE;
> 
>  	return FALSE;
>  }
> @@ -268,6 +286,9 @@ static gboolean can_write_data(GIOChannel *io,
> GIOCondition cond,
>  	GIOStatus iostat;
>  	GQueue *queue;
> 
> +	if (attrib->stale)
> +		return FALSE;
> +
>  	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
>  		return FALSE;
> 
> @@ -337,6 +358,9 @@ static gboolean received_data(GIOChannel *io,
> GIOCondition cond, gpointer data)
>  	GIOStatus iostat;
>  	gboolean norequests, noresponses;
> 
> +	if (attrib->stale)
> +		return FALSE;
> +
>  	if (attrib->timeout_watch > 0) {
>  		g_source_remove(attrib->timeout_watch);
>  		attrib->timeout_watch = 0;
> @@ -447,6 +471,9 @@ guint g_attrib_send(GAttrib *attrib, guint id,
> guint8 opcode,
>  	struct command *c;
>  	GQueue *queue;
> 
> +	if (attrib->stale)
> +		return 0;
> +
>  	c = g_try_new0(struct command, 1);
>  	if (c == NULL)
>  		return 0;
> --
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Looks ok to me.

Chen Ganir.
