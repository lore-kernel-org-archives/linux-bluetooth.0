Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Santiago Carot Nemesio <scarot@libresoft.es>
Subject: Re: [PATCH] Added support for deleting all MDLS in MCAP
Date: Tue, 4 May 2010 10:20:32 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <1270562433.8428.40.camel@mosquito> <201004091344.41686.jcaden@libresoft.es>
In-Reply-To: <201004091344.41686.jcaden@libresoft.es>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005041020.33342.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

El Friday 09 April 2010 13:44:41 José Antonio Santos Cadenas escribió:
> Also fixed some bugs in mcl state transitions
> 
> Signed-off-by: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
> Reviewed-by: Santiago Carot Nemesio <sancane@gmail.com>
> ---
>  mcap/mcap.c     |  133
> +++++++++++++++++++++++++++++++++++++++---------------- mcap/mcap_lib.h | 
>   2 +
>  2 files changed, 97 insertions(+), 38 deletions(-)
> 
> diff --git a/mcap/mcap.c b/mcap/mcap.c
> index 28c586c..e76c565 100644
> --- a/mcap/mcap.c
> +++ b/mcap/mcap.c
> @@ -33,7 +33,6 @@
>  #include "mcap.h"
>  #include "mcap_lib.h"
> 
> -//#define STATE2STR(_mcl) state2str(_mcl->state)
>  #define MCAP_ERROR mcap_error_quark()
>  #define SET_DEFAULT_MCL_CB(__mcl) do {				\
>  	__mcl->cb->mdl_connected = default_mdl_connected_cb;	\
> @@ -71,7 +70,8 @@ typedef enum {
>  typedef enum {
>  	MDL_WAITING,
>  	MDL_CONNECTED,
> -	MDL_CLOSED
> +	MDL_DELETING,
> +	MDL_CLOSED,
>  } MDLState;
> 
>  struct mcap_mcl_cb {
> @@ -79,7 +79,7 @@ struct mcap_mcl_cb {
>  	mcap_mdl_event_cb 		mdl_closed;	/* Remote device has closed an 
mdl */
>  	mcap_mdl_event_cb 		mdl_deleted;	/* Remote device deleted an 
mdl */
>  	mcap_remote_mdl_conn_req_cb	mdl_conn_req;	/* Remote deive requested
> create an mdl */ -	mcap_remote_mdl_reconn_req_cb 	mdl_reconn_req;	/*
> Remote device requested reconnect previus mdl */
> +	mcap_remote_mdl_reconn_req_cb 	mdl_reconn_req;	/* Remote device
> requested reconnect previous mdl */ gpointer			user_data;	/* 
user data */
>  };
> 
> @@ -240,6 +240,9 @@ static void update_mcl_state(struct mcap_mcl *mcl)
>  	GSList *l;
>  	struct mcap_mdl *mdl;
> 
> +	if (mcl->state == MCL_PENDING)
> +		return;
> +
>  	for (l = mcl->mdls; l; l = l->next) {
>  		mdl = l->data;
> 
> @@ -280,6 +283,12 @@ static void mcap_send_std_opcode(struct mcap_mcl *mcl,
> const uint8_t *buf, return;
>  	}
> 
> +	if (mcl->state == MCL_PENDING) {
> +		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
> +			"Not Std Op. Codes can be sent in PENDING State");
> +		return;
> +	}
> +
>  	if (mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), buf, size) < 0)
>  		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
>  				    "Data can't be sent, write error");
> @@ -394,17 +403,10 @@ static gint compare_mdl(gconstpointer a,
> gconstpointer b) static gboolean wait_response_timer(gpointer data)
>  {
>  	struct mcap_mcl *mcl = data;
> -	struct mcap_mdl_op_cb *con = mcl->priv_data;
> -	struct mcap_mdl *mdl = con->mdl;
> 
>  	GError *gerr = NULL;
> 
>  	RELEASE_TIMER(mcl);
> -	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
> -	g_free(mdl);
> -
> -	mcl->req = MCL_AVAILABLE;
> -	update_mcl_state(mcl);
> 
>  	g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
>  					"Timeout waiting response");
> @@ -494,6 +496,26 @@ void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
>  	con->cb.op = reconnect_cb;
>  	con->user_data = user_data;
> 
> +	mcl->state = MCL_ACTIVE;
> +	mcl->lcmd = cmd;
> +	mcl->req = MCL_WAITING_RSP;
> +	mcl->priv_data = con;
> +
> +	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
> mcl); +}
> +
> +static void send_delete_req(GError **err, struct mcap_mcl *mcl,
> +				struct mcap_mdl_op_cb *con, uint16_t mdlid)
> +{
> +	uint8_t *cmd;
> +
> +	cmd = create_req(MCAP_MD_DELETE_MDL_REQ, mdlid);
> +	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
> +	if (*err) {
> +		g_free(cmd);
> +		return;
> +	}
> +
>  	mcl->lcmd = cmd;
>  	mcl->req = MCL_WAITING_RSP;
>  	mcl->priv_data = con;
> @@ -501,13 +523,43 @@ void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
>  	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
> mcl); }
> 
> +void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
> +			mcap_mdl_del_cb delete_cb, gpointer user_data)
> +{
> +	GSList *l;
> +	struct mcap_mdl *mdl;
> +	struct mcap_mdl_op_cb *con;
> +
> +	debug("MCL in state: %d", mcl->state);
> +	if (!mcl->mdls) {
> +		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
> +				"There are not MDLs created");
> +		return;
> +	}
> +
> +	for (l = mcl->mdls; l; l = l->next) {
> +		mdl = l->data;
> +		if (mdl->state != MDL_WAITING)
> +			mdl->state = MDL_DELETING;
> +	}
> +
> +	con = g_new0(struct mcap_mdl_op_cb, 1);
> +	con->mdl = NULL;
> +	con->cb.del = delete_cb;
> +	con->user_data = user_data;
> +
> +	send_delete_req(err, mcl, con, MCAP_ALL_MDLIDS);
> +	if (*err)
> +		g_free(con);
> +	debug("exiting MCL in state: %d", mcl->state);
> +}
> +
>  void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
>  			mcap_mdl_del_cb delete_cb, gpointer user_data)
>  {
>  	struct mcap_mcl *mcl= mdl->mcl;
>  	struct mcap_mdl_op_cb *con;
>  	GSList *l;
> -	uint8_t *cmd;
> 
>  	l = g_slist_find(mcl->mdls, mdl);
> 
> @@ -519,28 +571,19 @@ void mcap_req_mdl_deletion(struct mcap_mdl *mdl,
> GError **err,
> 
>  	if (mdl->state == MDL_WAITING) {
>  		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
> -					"Not valid petition in this mdl state");
> +							"Mdl is not created");
>  		return;
>  	}
> +	mdl->state = MDL_DELETING;
> 
>  	con = g_new0(struct mcap_mdl_op_cb, 1);
>  	con->mdl = mdl;
>  	con->cb.del = delete_cb;
>  	con->user_data = user_data;
> 
> -	cmd = create_req(MCAP_MD_DELETE_MDL_REQ, mdl->mdlid);
> -	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
> -	if (*err) {
> +	send_delete_req(err, mcl, con, mdl->mdlid);
> +	if (*err)
>  		g_free(con);
> -		g_free(cmd);
> -		return;
> -	}
> -
> -	mcl->lcmd = cmd;
> -	mcl->req = MCL_WAITING_RSP;
> -	mcl->priv_data = con;
> -
> -	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
> mcl); }
> 
>  void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
> @@ -688,7 +731,7 @@ static gboolean parse_set_opts(struct mcap_mcl_cb
> *mcl_cb, GError **err, cb = va_arg(args, int);
>  	}
> 
> -	/* Set new callbacks set */
> +	/* Set new callbacks */
>  	if (c->mdl_connected)
>  		mcl_cb->mdl_connected = c->mdl_connected;
>  	if (c->mdl_closed)
> @@ -825,7 +868,7 @@ static void process_md_create_mdl_req(struct mcap_mcl
> *mcl, uint8_t *cmd, int le if ((cfga != 0) && (cfga != conf)) {
>  		/* Remote device set default configuration but upper profile */
>  		/* has changed it. Protocol Error: force closing the MCL by */
> -		/* using remote device using UNESPECIFIED_ERROR response*/
> +		/* using remote device using UNESPECIFIED_ERROR response */
>  		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_UNESPECIFIED_ERROR,
>  								mdl_id);
>  		return;
> @@ -844,8 +887,8 @@ static void process_md_create_mdl_req(struct mcap_mcl
> *mcl, uint8_t *cmd, int le shutdown_mdl(mdl);
>  		mcl->cb->mdl_closed(mdl, mcl->cb->user_data);
>  	}
> -	mdl->state = MDL_WAITING;
>  	mdl->mdep_id = mdep_id;
> +	mdl->state = MDL_WAITING;
>  	mcl->mdls = g_slist_insert_sorted(mcl->mdls, mdl, compare_mdl);
> 
>  	mcl->state = MCL_PENDING;
> @@ -934,7 +977,7 @@ static void process_md_abort_mdl_req(struct mcap_mcl
> *mcl, uint8_t *cmd, int len g_free(del);
>  	send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_SUCCESS, mdl_id);
>  }
> -/* Functions used to process responses */
> +
>  static gboolean check_err_rsp(uint16_t rmdl, uint16_t smdl, uint8_t rc,
>  					int rlen, int len, GError **gerr)
>  {
> @@ -1089,15 +1132,26 @@ static void mcap_delete_mdl(gpointer elem, gpointer
> user_data) {
>  	struct mcap_mdl *mdl = elem;
>  	gboolean notify = *(gboolean *)user_data;
> -	if (mdl->state == MDL_CONNECTED) {
> -		debug("MDL %d already connected, closing it", mdl->mdlid);
> -		shutdown_mdl(mdl);
> -	}
> +
> +	shutdown_mdl(mdl);
>  	if (notify)
>  		mdl->mcl->cb->mdl_deleted(mdl, mdl->mcl->cb->user_data);
>  	g_free(mdl);
>  }
> 
> +static void restore_mdl(gpointer elem, gpointer data)
> +{
> +	struct mcap_mdl *mdl = elem;
> +
> +	if (mdl->state == MDL_DELETING) {
> +		if (mdl->dc)
> +			mdl->state = MDL_CONNECTED;
> +		else
> +			mdl->state = MDL_CLOSED;
> +	} else if (mdl->state == MDL_CLOSED)
> +		mdl->mcl->cb->mdl_closed(mdl, mdl->mcl->cb->user_data);
> +}
> +
>  static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t
> *cmd, int len)
>  {
> @@ -1124,6 +1178,10 @@ static gboolean process_md_delete_mdl_rsp(struct
> mcap_mcl *mcl, uint8_t *cmd, mcl->lcmd = NULL;
>  	mcl->req = MCL_AVAILABLE;
>  	if (gerr) {
> +		if (mdl)
> +			restore_mdl(mdl, NULL);
> +		else
> +			g_slist_foreach(mcl->mdls, restore_mdl, NULL);
>  		deleted_cb(gerr, user_data);
>  		g_error_free(gerr);
>  		return close;
> @@ -1158,8 +1216,8 @@ static void process_md_delete_mdl_req(struct mcap_mcl
> *mcl, mcap_md_req *req) notify = FALSE;
>  		g_slist_foreach(mcl->mdls, mcap_delete_mdl, &notify);
>  		g_slist_free(mcl->mdls);
> -		mcl->state = MCL_CONNECTED;
>  		mcl->mdls = NULL;
> +		mcl->state = MCL_CONNECTED;
>  		/* NULL mdl means ALL_MDLS */
>  		mcl->cb->mdl_deleted(NULL, mcl->cb->user_data);
>  		goto resp;
> @@ -1178,11 +1236,10 @@ static void process_md_delete_mdl_req(struct
> mcap_mcl *mcl, mcap_md_req *req) }
>  	}
> 
> -	if (!mdl) {
> +	if (!mdl || (mdl->state == MDL_WAITING)) {
>  		send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_INVALID_MDL, mdlid);
>  		return;
>  	}
> -
>  	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
>  	update_mcl_state(mcl);
>  	notify = TRUE;
> @@ -1400,16 +1457,16 @@ static gboolean mdl_closing_cb(GIOChannel *chan,
> GIOCondition cond, gpointer dat {
> 
>  	struct mcap_mdl *mdl = data;
> -	gboolean open;
> +	gboolean notify;
> 
>  	debug("Close MDL %d", mdl->mdlid);
> 
> -	open = (mdl->state == MDL_CONNECTED);
> +	notify = (mdl->state == MDL_CONNECTED);
>  	shutdown_mdl(mdl);
> 
>  	update_mcl_state(mdl->mcl);
> 
> -	if (open)
> +	if (notify)
>  		/*Callback to upper layer */
>  		mdl->mcl->cb->mdl_closed(mdl, mdl->mcl->cb->user_data);
> 
> diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
> index 530f03a..867a53d 100644
> --- a/mcap/mcap_lib.h
> +++ b/mcap/mcap_lib.h
> @@ -92,6 +92,8 @@ void mcap_req_mdl_creation(struct mcap_mcl *mcl,
>  void mcap_req_mdl_reconnect(struct mcap_mdl *mdl, GError **err,
>  				mcap_mdl_operation_cb reconnect_cb,
>  				gpointer user_data);
> +void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
> +			mcap_mdl_del_cb delete_cb, gpointer user_data);
>  void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
>  			mcap_mdl_del_cb delete_cb, gpointer user_data);
>  void mcap_mdl_connect(struct mcap_mdl *mdl,


Please, dismiss this patches we are sending new ones shortly.

Regards
