Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Jul 2010 20:50:21 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 10/60] Process md_abort_mdl_req in PENDING state
Message-ID: <20100722235021.GF2620@vigoh>
References: <1279788733-2324-2-git-send-email-sancane@gmail.com>
 <1279788733-2324-3-git-send-email-sancane@gmail.com>
 <1279788733-2324-4-git-send-email-sancane@gmail.com>
 <1279788733-2324-5-git-send-email-sancane@gmail.com>
 <1279788733-2324-6-git-send-email-sancane@gmail.com>
 <1279788733-2324-7-git-send-email-sancane@gmail.com>
 <1279788733-2324-8-git-send-email-sancane@gmail.com>
 <1279788733-2324-9-git-send-email-sancane@gmail.com>
 <1279788733-2324-10-git-send-email-sancane@gmail.com>
 <1279788733-2324-11-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279788733-2324-11-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

* Santiago Carot-Nemesio <sancane@gmail.com> [2010-07-22 10:52:05 +0200]:

> ---
>  mcap/mcap.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 49 insertions(+), 1 deletions(-)
> 
> diff --git a/mcap/mcap.c b/mcap/mcap.c
> index d6a9760..9f41c6b 100644
> --- a/mcap/mcap.c
> +++ b/mcap/mcap.c
> @@ -551,6 +551,51 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
>  	send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_SUCCESS, mdl_id);
>  }
>  
> +static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
> +								uint32_t len)
> +{
> +	mcap_md_req *req;
> +	GSList *l;
> +	struct mcap_mdl *mdl, *del;
> +	uint16_t mdl_id;
> +
> +	if (len != sizeof(mcap_md_req)) {
> +		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
> +				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);

I remenber about a Johan's comment on send4B_cmd(). It was basically,
wouldn't be better have function to send data of a arbritrary size. I
think I saw a send5B_cmd() in these patches as well.

> +		return;
> +	}
> +
> +	req = (mcap_md_req *)cmd;
> +	mdl_id = ntohs(req->mdl);
> +	mcl->state = MCL_CONNECTED;
> +	for (l = mcl->mdls; l; l = l->next) {
> +		mdl = l->data;
> +		if ((mdl_id == mdl->mdlid) && (mdl->state == MDL_WAITING)) {
> +			del = mdl;
> +			if (mcl->state != MCL_CONNECTED)
> +				break;
> +			continue;
> +		}
> +		if ((mdl->state == MDL_CONNECTED) && (mcl->state != MCL_ACTIVE))
> +			mcl->state = MCL_ACTIVE;
> +
> +		if ((del) && (mcl->state == MCL_ACTIVE))
> +			break;
> +	}
> +
> +	if (!del) {
> +		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_INVALID_MDL,
> +									mdl_id);
> +		return;
> +	}
> +
> +	mcl->cb->mdl_aborted(del, mcl->cb->user_data);
> +
> +	mcl->mdls = g_slist_remove(mcl->mdls, del);
> +	g_free(del);
> +	send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_SUCCESS, mdl_id);
> +}
> +
>  static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
>  								uint32_t len)
>  {
> @@ -626,7 +671,10 @@ static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
>  
>  static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
>  {
> -	/* TODO */
> +	if (cmd[0] == MCAP_MD_ABORT_MDL_REQ)
> +		process_md_abort_mdl_req(mcl, cmd, len);
> +	else
> +		error_cmd_rsp(mcl, cmd, len);
>  }
>  
>  static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)

-- 
Gustavo F. Padovan
http://padovan.org
