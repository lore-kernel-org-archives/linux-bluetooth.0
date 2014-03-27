Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 01/12] android/avrcp-lib: Add support for parsing GetCapabilities response
Date: Thu, 27 Mar 2014 15:55:14 +0100
Message-ID: <8729773.jmhokHIpsk@uw000953>
In-Reply-To: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
References: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wednesday 26 of March 2014 16:13:41 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  android/avrcp-lib.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++------
>  android/avrcp-lib.h |   6 ++-
>  android/avrcp.c     |  40 ++++++++--------
>  unit/test-avrcp.c   |   3 +-
>  4 files changed, 138 insertions(+), 39 deletions(-)
> 
> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> index c7b8b6a..2128835 100644
> --- a/android/avrcp-lib.c
> +++ b/android/avrcp-lib.c
> @@ -135,6 +135,27 @@ void avrcp_shutdown(struct avrcp *session)
>  	g_free(session);
>  }
>  
> +static struct avrcp_header *parse_pdu(uint8_t *operands, size_t operand_count)
> +{
> +	struct avrcp_header *pdu;
> +
> +	if (operands == NULL || operand_count < sizeof(*pdu)) {

Use ! instead of '== NULL'

> +		error("AVRCP: packet too smal (%zu bytes)", operand_count);

typo: smal -> small

> +		return NULL;
> +	}
> +
> +	pdu = (void *) operands;
> +	pdu->params_len = ntohs(pdu->params_len);
> +
> +	if (operand_count != pdu->params_len + sizeof(*pdu)) {
> +		error("AVRCP: invalid parameter length (%u bytes)",
> +							pdu->params_len);
> +		return NULL;
> +	}
> +
> +	return pdu;
> +}
> +
>  static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
>  					uint8_t *code, uint8_t *subunit,
>  					uint8_t *operands, size_t operand_count,
> @@ -142,26 +163,27 @@ static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
>  {
>  	struct avrcp *session = user_data;
>  	const struct avrcp_control_handler *handler;
> -	struct avrcp_header *pdu = (void *) operands;
> -	uint32_t company_id = ntoh24(pdu->company_id);
> -	uint16_t params_len = ntohs(pdu->params_len);
> +	struct avrcp_header *pdu;
> +	uint32_t company_id;
>  	ssize_t ret;
>  
> +	pdu = parse_pdu(operands, operand_count);
> +	if (!pdu) {
> +		pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
> +		goto reject;
> +	}
> +
> +	company_id = ntoh24(pdu->company_id);
>  	if (company_id != IEEEID_BTSIG) {
>  		*code = AVC_CTYPE_NOT_IMPLEMENTED;
>  		return 0;
>  	}
>  
> -	DBG("AVRCP PDU 0x%02X, len 0x%04X", pdu->pdu_id, params_len);
> +	DBG("AVRCP PDU 0x%02X, len 0x%04X", pdu->pdu_id, pdu->params_len);
>  
>  	pdu->packet_type = 0;
>  	pdu->rsvd = 0;
>  
> -	if (operand_count < AVRCP_HEADER_LENGTH) {
> -		pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
> -		goto reject;
> -	}
> -
>  	if (!session->control_handlers)
>  		goto reject;
>  
> @@ -180,7 +202,7 @@ static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
>  		goto reject;
>  	}
>  
> -	ret = handler->func(session, transaction, params_len, pdu->params,
> +	ret = handler->func(session, transaction, pdu->params_len, pdu->params,
>  							session->control_data);
>  	if (ret < 0) {
>  		switch (ret) {
> @@ -670,6 +692,31 @@ int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
>  							session->tx_buf, len);
>  }
>  
> +static int parse_status(struct avrcp_header *pdu)
> +{
> +	if (pdu->params_len < 1)
> +		return -EPROTO;
> +
> +	switch (pdu->params[0]) {
> +	case AVRCP_STATUS_INVALID_COMMAND:
> +		return -ENOSYS;
> +	case AVRCP_STATUS_INVALID_PARAM:
> +		return -EINVAL;
> +	case AVRCP_STATUS_SUCCESS:
> +		return 0;
> +	case AVRCP_STATUS_OUT_OF_BOUNDS:
> +		return -EOVERFLOW;
> +	case AVRCP_STATUS_INTERNAL_ERROR:
> +	case AVRCP_STATUS_INVALID_PLAYER_ID:
> +	case AVRCP_STATUS_PLAYER_NOT_BROWSABLE:
> +	case AVRCP_STATUS_NO_AVAILABLE_PLAYERS:
> +	case AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED:
> +		return -EPERM;
> +	default:
> +		return -EPROTO;
> +	}
> +}
> +
>  static int avrcp_send_req(struct avrcp *session, uint8_t code, uint8_t subunit,
>  					uint8_t pdu_id, uint8_t *params,
>  					size_t params_len, avctp_rsp_cb func,
> @@ -698,12 +745,67 @@ static int avrcp_send_req(struct avrcp *session, uint8_t code, uint8_t subunit,
>  					session->tx_buf, len, func, user_data);
>  }
>  
> -int avrcp_get_capabilities(struct avrcp *session, uint8_t param,
> -					avctp_rsp_cb func, void *user_data)
> +static gboolean get_capabilities_rsp(struct avctp *conn,
> +					uint8_t code, uint8_t subunit,
> +					uint8_t *operands, size_t operand_count,
> +					void *user_data)
> +{
> +	struct avrcp *session = user_data;
> +	struct avrcp_player *player = session->player;
> +	struct avrcp_header *pdu;
> +	uint8_t number = 0;
> +	uint8_t *params = NULL;
> +	int err;
> +
> +	DBG("");
> +
> +	if (!player || !player->cfm || !player->cfm->get_capabilities)
> +		return FALSE;
> +
> +	pdu = parse_pdu(operands, operand_count);
> +	if (!pdu) {
> +		err = -EPROTO;
> +		goto done;
> +	}
> +
> +	if (code == AVC_CTYPE_REJECTED) {
> +		err = parse_status(pdu);
> +		goto done;
> +	}
> +
> +	if (pdu->params_len < 2) {
> +		err = -EPROTO;
> +		goto done;
> +	}
> +
> +	switch (pdu->params[0]) {
> +	case CAP_COMPANY_ID:
> +	case CAP_EVENTS_SUPPORTED:
> +		break;
> +	default:
> +		err = -EPROTO;
> +		goto done;
> +	}
> +
> +	number = pdu->params[1];
> +
> +	if (number > 0)
> +		params = &pdu->params[2];
> +
> +	err = 0;
> +
> +done:
> +	player->cfm->get_capabilities(session, err, number, params,
> +							player->user_data);
> +
> +	return FALSE;
> +}
> +
> +int avrcp_get_capabilities(struct avrcp *session, uint8_t param)
>  {
>  	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
>  				AVRCP_GET_CAPABILITIES, &param, sizeof(param),
> -				func, user_data);
> +				get_capabilities_rsp, session);
>  }
>  
>  int avrcp_register_notification(struct avrcp *session, uint8_t event,
> diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
> index d9acb7d..ab110cb 100644
> --- a/android/avrcp-lib.h
> +++ b/android/avrcp-lib.h
> @@ -164,6 +164,9 @@ struct avrcp_control_ind {
>  };
>  
>  struct avrcp_control_cfm {
> +	void (*get_capabilities) (struct avrcp *session, int err,
> +					uint8_t number, uint8_t *params,
> +					void *user_data);
>  };
>  
>  struct avrcp_passthrough_handler {
> @@ -190,8 +193,7 @@ int avrcp_init_uinput(struct avrcp *session, const char *name,
>  int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
>  					uint8_t subunit, uint8_t pdu_id,
>  					uint8_t *params, size_t params_len);
> -int avrcp_get_capabilities(struct avrcp *session, uint8_t param,
> -					avctp_rsp_cb func, void *user_data);
> +int avrcp_get_capabilities(struct avrcp *session, uint8_t param);
>  int avrcp_register_notification(struct avrcp *session, uint8_t event,
>  					uint32_t interval, avctp_rsp_cb func,
>  					void *user_data);
> diff --git a/android/avrcp.c b/android/avrcp.c
> index ec98139..0995a06 100644
> --- a/android/avrcp.c
> +++ b/android/avrcp.c
> @@ -759,38 +759,35 @@ static gboolean register_notification_rsp(struct avctp *conn,
>  	return FALSE;
>  }
>  
> -static gboolean get_capabilities_rsp(struct avctp *conn,
> -					uint8_t code, uint8_t subunit,
> -					uint8_t *operands, size_t operand_count,
> +static void handle_get_capabilities_rsp(struct avrcp *session, int err,
> +					uint8_t number, uint8_t *events,
>  					void *user_data)
>  {
>  	struct avrcp_device *dev = user_data;
> -	uint8_t *params;
> -	uint8_t count;
> -
> -	if (operands == NULL || operand_count < 7)
> -		return FALSE;
> -
> -	params = &operands[7];
> -
> -	if (params == NULL || params[0] != CAP_EVENTS_SUPPORTED)
> -		return FALSE;
> +	int i;
>  
> -	for (count = params[1]; count > 0; count--) {
> -		uint8_t event = params[1 + count];
> +	if (err < 0) {
> +		error("AVRCP: %s", strerror(-err));
> +		return;
> +	}
>  
> -		if (event != AVRCP_EVENT_VOLUME_CHANGED)
> +	for (i = 0; i < number; i++) {
> +		if (events[i] != AVRCP_EVENT_VOLUME_CHANGED)
>  			continue;
>  
> -		avrcp_register_notification(dev->session, event, 0,
> +		avrcp_register_notification(dev->session, events[i], 0,
>  						register_notification_rsp,
>  						dev);
> -		return FALSE;
> +		break;
>  	}
>  
> -	return FALSE;
> +	return;
>  }
>  
> +static const struct avrcp_control_cfm control_cfm = {
> +	.get_capabilities = handle_get_capabilities_rsp,
> +};
> +
>  static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
>  						uint16_t imtu, uint16_t omtu)
>  {
> @@ -804,7 +801,7 @@ static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
>  	avrcp_set_destroy_cb(dev->session, disconnect_cb, dev);
>  	avrcp_set_passthrough_handlers(dev->session, passthrough_handlers,
>  									dev);
> -	avrcp_register_player(dev->session, &control_ind, NULL, dev);
> +	avrcp_register_player(dev->session, &control_ind, &control_cfm, dev);
>  
>  	dev->queue = g_queue_new();
>  
> @@ -828,8 +825,7 @@ static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
>  
>  	ev.features |= HAL_AVRCP_FEATURE_ABSOLUTE_VOLUME;
>  
> -	avrcp_get_capabilities(dev->session, CAP_EVENTS_SUPPORTED,
> -						get_capabilities_rsp, dev);
> +	avrcp_get_capabilities(dev->session, CAP_EVENTS_SUPPORTED);
>  
>  done:
>  	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index eb00238..d6be6a6 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -491,8 +491,7 @@ static void test_client(gconstpointer data)
>  									NULL);
>  
>  	if (g_str_equal(context->data->test_name, "/TP/CFG/BV-01-C"))
> -		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED,
> -								NULL, NULL);
> +		avrcp_get_capabilities(context->session, CAP_EVENTS_SUPPORTED);
>  
>  	if (g_str_equal(context->data->test_name, "/TP/PAS/BV-01-C"))
>  		avrcp_list_player_attributes(context->session, NULL, NULL);
> 

-- 
Best regards, 
Szymon Janc
