Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Jul 2010 20:54:52 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 12/60] Managing connection of Data Channels
Message-ID: <20100722235452.GG2620@vigoh>
References: <1279788733-2324-4-git-send-email-sancane@gmail.com>
 <1279788733-2324-5-git-send-email-sancane@gmail.com>
 <1279788733-2324-6-git-send-email-sancane@gmail.com>
 <1279788733-2324-7-git-send-email-sancane@gmail.com>
 <1279788733-2324-8-git-send-email-sancane@gmail.com>
 <1279788733-2324-9-git-send-email-sancane@gmail.com>
 <1279788733-2324-10-git-send-email-sancane@gmail.com>
 <1279788733-2324-11-git-send-email-sancane@gmail.com>
 <1279788733-2324-12-git-send-email-sancane@gmail.com>
 <1279788733-2324-13-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279788733-2324-13-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

* Santiago Carot-Nemesio <sancane@gmail.com> [2010-07-22 10:52:07 +0200]:

> ---
>  mcap/mcap.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 70 insertions(+), 1 deletions(-)
> 
> diff --git a/mcap/mcap.c b/mcap/mcap.c
> index cf44472..1d86c51 100644
> --- a/mcap/mcap.c
> +++ b/mcap/mcap.c
> @@ -754,6 +754,27 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
>  		proc_req[mcl->state](mcl, cmd, len);
>  }
>  
> +static gboolean mdl_event_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
> +{
> +
> +	struct mcap_mdl *mdl = data;
> +	gboolean notify;
> +
> +	DBG("Close MDL %d", mdl->mdlid);
> +
> +	notify = (mdl->state == MDL_CONNECTED);

You actually don't need 'notify', just put the comparison in the if
below.

> +	shutdown_mdl(mdl);
> +
> +	update_mcl_state(mdl->mcl);
> +
> +	if (notify) {
> +		/*Callback to upper layer */
> +		mdl->mcl->cb->mdl_closed(mdl, mdl->mcl->cb->user_data);
> +	}
> +
> +	return FALSE;
> +}
> +
>  static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
>  								gpointer data)
>  {
> @@ -779,9 +800,57 @@ fail:
>  	return FALSE;
>  }
>  
> +static void connect_dc_event_cb(GIOChannel *chan, GError *err,
> +							gpointer user_data)
> +{
> +	struct mcap_mdl *mdl = user_data;
> +	struct mcap_mcl *mcl = mdl->mcl;
> +
> +	mdl->state = MDL_CONNECTED;
> +	mdl->dc = g_io_channel_ref(chan);
> +	mdl->wid = g_io_add_watch(mdl->dc, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
> +						(GIOFunc) mdl_event_cb, mdl);
> +
> +	mcl->state = MCL_ACTIVE;
> +	mcl->cb->mdl_connected(mdl, mcl->cb->user_data);
> +}
> +
>  static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
>  {
> -	/* TODO */
> +	struct mcap_instance *ms = user_data;
> +	struct mcap_mcl *mcl;
> +	struct mcap_mdl *mdl;
> +	GError *err = NULL;
> +	bdaddr_t dst;
> +	GSList *l;
> +
> +	bt_io_get(chan, BT_IO_L2CAP, &err,
> +			BT_IO_OPT_DEST_BDADDR, &dst,
> +			BT_IO_OPT_INVALID);
> +	if (err) {
> +		error("%s", err->message);
> +		g_error_free(err);
> +		goto drop;
> +	}
> +
> +	mcl = find_mcl(ms->mcls, &dst);
> +	if (!mcl || (mcl->state != MCL_PENDING))

No need for () in the '!=' comparison.

> +		goto drop;
> +
> +	for (l = mcl->mdls; l; l = l->next) {
> +		mdl = l->data;
> +		if (mdl->state == MDL_WAITING) {
> +			if (!bt_io_accept(chan, connect_dc_event_cb, mdl, NULL,
> +									&err)) {
> +				error("MDL accept error %s", err->message);
> +				g_error_free(err);
> +				goto drop;
> +			}
> +			return;
> +		}
> +	}
> +drop:
> +	g_io_channel_shutdown(chan, TRUE, NULL);
>  }
>  
>  static void connect_mcl_event_cb(GIOChannel *chan, GError *err,

-- 
Gustavo F. Padovan
http://padovan.org
