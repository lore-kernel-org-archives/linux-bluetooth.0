Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <1439193043-16574-1-git-send-email-luiz.dentz@gmail.com>
In-reply-to: <1439193043-16574-1-git-send-email-luiz.dentz@gmail.com>
Subject: RE: [PATCH BlueZ] audio/avrcp: Fix not handling Addressed Player
 Changed error
Date: Mon, 10 Aug 2015 16:51:48 +0530
Message-id: <021301d0d35e$cc06ab00$64140100$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Monday, August 10, 2015 1:21 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: [PATCH BlueZ] audio/avrcp: Fix not handling Addressed Player
> Changed error
> 
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Some notification are completed in case the addressed player changes:
> 
>   'On completion of the Addressed Player Changed notification the TG
>   shall complete all player specific notifications with AV/C C-Type
>   REJECTED with error code Addressed Player Changed.'
> 
> Because reject only has the error code not the event it is necessary to
lookup
> by transaction to find out which event was completed thus the transaction
> needs to be added to the avctp_rsp_cb callback.
> ---
>  profiles/audio/avctp.c | 20 ++++++++++--------  profiles/audio/avctp.h |
5
> +++--  profiles/audio/avrcp.c | 56
> +++++++++++++++++++++++++++++++++++---------------
>  3 files changed, 53 insertions(+), 28 deletions(-)
> 
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c index
> 22bf35b..2a43d32 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -293,8 +293,9 @@ static GSList *servers = NULL;  static void
> auth_cb(DBusError *derr, void *user_data);  static gboolean
> process_queue(gpointer user_data);  static gboolean
> avctp_passthrough_rsp(struct avctp *session, uint8_t code,
> -					uint8_t subunit, uint8_t *operands,
> -					size_t operand_count, void
> *user_data);
> +					uint8_t subunit, uint8_t
transaction,
> +					uint8_t *operands, size_t
> operand_count,
> +					void *user_data);
> 
>  static int send_event(int fd, uint16_t type, uint16_t code, int32_t
value)  {
> @@ -706,8 +707,8 @@ static void control_req_destroy(void *data)
>  	if (p->err == 0 || req->func == NULL)
>  		goto done;
> 
> -	req->func(session, AVC_CTYPE_REJECTED, req->subunit, NULL, 0,
> -							req->user_data);
> +	req->func(session, AVC_CTYPE_REJECTED, req->subunit, p-
> >transaction,
> +						NULL, 0, req->user_data);
> 
>  done:
>  	g_free(req->operands);
> @@ -829,9 +830,9 @@ static void control_response(struct avctp_channel
> *control,
>  			continue;
> 
>  		if (req->func && req->func(control->session, avc->code,
> -						avc->subunit_type,
> -						operands, operand_count,
> -						req->user_data))
> +					avc->subunit_type, p->transaction,
> +					operands, operand_count,
> +					req->user_data))
>  			return;
> 
>  		control->processed = g_slist_remove(control->processed,
> p); @@ -1724,8 +1725,9 @@ static bool set_pressed(struct avctp *session,
> uint8_t op)  }
> 
>  static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t
code,
> -					uint8_t subunit, uint8_t *operands,
> -					size_t operand_count, void
> *user_data)
> +					uint8_t subunit, uint8_t
transaction,
> +					uint8_t *operands, size_t
> operand_count,
> +					void *user_data)
>  {
>  	if (code != AVC_CTYPE_ACCEPTED)
>  		return FALSE;
> diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h index
> 6c19ce4..68a2735 100644
> --- a/profiles/audio/avctp.h
> +++ b/profiles/audio/avctp.h
> @@ -132,8 +132,9 @@ typedef size_t (*avctp_control_pdu_cb) (struct avctp
> *session,
>  					uint8_t *subunit, uint8_t *operands,
>  					size_t operand_count, void
> *user_data);  typedef gboolean (*avctp_rsp_cb) (struct avctp *session,
> uint8_t code,
> -					uint8_t subunit, uint8_t *operands,
> -					size_t operand_count, void
> *user_data);
> +					uint8_t subunit, uint8_t
transaction,
> +					uint8_t *operands, size_t
> operand_count,
> +					void *user_data);
>  typedef gboolean (*avctp_browsing_rsp_cb) (struct avctp *session,
>  					uint8_t *operands, size_t
> operand_count,
>  					void *user_data);
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c index
> d66f670..f24cb91 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -1802,8 +1802,8 @@ static const char *status_to_string(uint8_t status)
>  	}
>  }
> 
> -static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
> -					uint8_t code, uint8_t subunit,
> +static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t
> code,
> +					uint8_t subunit, uint8_t
transaction,
>  					uint8_t *operands, size_t
> operand_count,
>  					void *user_data)
>  {
> @@ -1866,8 +1866,8 @@ static const char *status_to_str(uint8_t status)
>  	}
>  }
> 
> -static gboolean avrcp_player_value_rsp(struct avctp *conn,
> -					uint8_t code, uint8_t subunit,
> +static gboolean avrcp_player_value_rsp(struct avctp *conn, uint8_t code,
> +					uint8_t subunit, uint8_t
transaction,
>  					uint8_t *operands, size_t
> operand_count,
>  					void *user_data)
>  {
> @@ -1936,8 +1936,8 @@ static void avrcp_get_current_player_value(struct
> avrcp *session,
> 
>  static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
>  					uint8_t code, uint8_t subunit,
> -					uint8_t *operands, size_t
> operand_count,
> -					void *user_data)
> +					uint8_t transaction, uint8_t
> *operands,
> +					size_t operand_count, void
> *user_data)
>  {
>  	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
>  	struct avrcp *session = user_data;
> @@ -2023,6 +2023,7 @@ static void avrcp_parse_attribute_list(struct
> avrcp_player *player,
> 
>  static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
>  						uint8_t code, uint8_t
subunit,
> +						uint8_t transaction,
>  						uint8_t *operands,
>  						size_t operand_count,
>  						void *user_data)
> @@ -3237,8 +3238,8 @@ static void avrcp_uids_changed(struct avrcp
> *session, struct avrcp_header *pdu)
>  	player->uid_counter = get_be16(&pdu->params[1]);  }
> 
> -static gboolean avrcp_handle_event(struct avctp *conn,
> -					uint8_t code, uint8_t subunit,
> +static gboolean avrcp_handle_event(struct avctp *conn, uint8_t code,
> +					uint8_t subunit, uint8_t
transaction,
>  					uint8_t *operands, size_t
> operand_count,
>  					void *user_data)
>  {
> @@ -3246,16 +3247,30 @@ static gboolean avrcp_handle_event(struct avctp
> *conn,
>  	struct avrcp_header *pdu = (void *) operands;
>  	uint8_t event;
> 
> -	if ((code != AVC_CTYPE_INTERIM && code !=
> AVC_CTYPE_CHANGED) ||
> -								pdu == NULL)
> +	if (!pdu)
> +		return FALSE;
> +
> +	if ((code != AVC_CTYPE_INTERIM && code !=
> AVC_CTYPE_CHANGED)) {
> +		if (pdu->params[0] ==
> AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED &&
> +				code == AVC_CTYPE_REJECTED) {
> +			int i;
> +
> +			/* Lookup event by transaction */
Here it should look for only player specific events, instead all supported
events, as mentioned in addressed player changed procedure.
> +			for (i = 0; i <= AVRCP_EVENT_LAST; i++) {
> +				if (session->transaction_events[i] ==
> +								transaction)
{
> +					event = i;
> +					goto changed;
> +				}
> +			}
> +		}
>  		return FALSE;
> +	}
> 
>  	event = pdu->params[0];
> 
>  	if (code == AVC_CTYPE_CHANGED) {
> -		session->registered_events ^= (1 << event);
> -		avrcp_register_notification(session, event);
> -		return FALSE;
> +		goto changed;
>  	}
> 
>  	switch (event) {
> @@ -3286,8 +3301,15 @@ static gboolean avrcp_handle_event(struct avctp
> *conn,
>  	}
> 
>  	session->registered_events |= (1 << event);
> +	session->transaction_events[event] = transaction;
> 
>  	return TRUE;
> +
> +changed:
> +	session->registered_events ^= (1 << event);
> +	session->transaction_events[event] = 0;
> +	avrcp_register_notification(session, event);
> +	return FALSE;
>  }
> 
>  static void avrcp_register_notification(struct avrcp *session, uint8_t
event)
> @@ -3319,8 +3341,8 @@ static void avrcp_register_notification(struct avrcp
> *session, uint8_t event)
>  					avrcp_handle_event, session);
>  }
> 
> -static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
> -					uint8_t code, uint8_t subunit,
> +static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t
> code,
> +					uint8_t subunit, uint8_t
transaction,
>  					uint8_t *operands, size_t
> operand_count,
>  					void *user_data)
>  {
> @@ -3832,8 +3854,8 @@ void avrcp_unregister_player(struct avrcp_player
> *player)
> 
> 	AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);  }
> 
> -static gboolean avrcp_handle_set_volume(struct avctp *conn,
> -					uint8_t code, uint8_t subunit,
> +static gboolean avrcp_handle_set_volume(struct avctp *conn, uint8_t
> code,
> +					uint8_t subunit, uint8_t
transaction,
>  					uint8_t *operands, size_t
> operand_count,
>  					void *user_data)
>  {
> -- 
--
Best Regards,
Bharat

