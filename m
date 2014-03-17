Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Mar 2014 10:38:39 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 01/12] android/avrcp-lib: Change API to register
 callbacks instead of PDU handlers
Message-ID: <20140317083837.GA16561@aemeltch-MOBL1>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 17, 2014 at 10:08:46AM +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds avrcp_register_player function to register callbacks for
> requests and responses, the fundamental difference is that the
> callbacks are called after the original PDU is parsed and the parameter
> are converted to host byte order making us able to unit test the
> parsing itself.
> ---
>  android/avrcp-lib.c | 27 +++++++++++++++++++++++++++
>  android/avrcp-lib.h | 11 +++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> index 7b043ce..ca01b50 100644
> --- a/android/avrcp-lib.c
> +++ b/android/avrcp-lib.c
> @@ -73,6 +73,7 @@ struct avrcp_header {
>  
>  struct avrcp {
>  	struct avctp *conn;
> +	struct avrcp_player *player;
>  
>  	size_t tx_mtu;
>  	uint8_t *tx_buf;
> @@ -89,6 +90,13 @@ struct avrcp {
>  	void *destroy_data;
>  };
>  
> +struct avrcp_player {
> +	const struct avrcp_control_ind *ind;
> +	const struct avrcp_control_cfm *cfm;
> +
> +	void *user_data;
> +};
> +
>  void avrcp_shutdown(struct avrcp *session)
>  {
>  	if (session->conn) {
> @@ -107,6 +115,7 @@ void avrcp_shutdown(struct avrcp *session)
>  	if (session->destroy)
>  		session->destroy(session->destroy_data);
>  
> +	g_free(session->player);

The player seems not allocated by default, so it should not be clean here.
I would also make player_unregister() to make it consistent with
player_register()

Best regards 
Andrei Emeltchenko 

>  	g_free(session->tx_buf);
>  	g_free(session);
>  }
> @@ -162,6 +171,9 @@ static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
>  		switch (ret) {
>  		case -EAGAIN:
>  			return ret;
> +		case -ENOSYS:
> +			pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
> +			goto reject;
>  		case -EINVAL:
>  			pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
>  			goto reject;
> @@ -249,6 +261,21 @@ void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
>  	session->destroy_data = user_data;
>  }
>  
> +void avrcp_register_player(struct avrcp *session,
> +				const struct avrcp_control_ind *ind,
> +				const struct avrcp_control_cfm *cfm,
> +				void *user_data)
> +{
> +	struct avrcp_player *player;
> +
> +	player = g_new0(struct avrcp_player, 1);
> +	player->ind = ind;
> +	player->cfm = cfm;
> +	player->user_data = user_data;
> +
> +	session->player = player;
> +}
> +
>  void avrcp_set_control_handlers(struct avrcp *session,
>  				const struct avrcp_control_handler *handlers,
>  				void *user_data)
> diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
> index 4adf4bf..6e33a75 100644
> --- a/android/avrcp-lib.h
> +++ b/android/avrcp-lib.h
> @@ -100,6 +100,12 @@ struct avrcp_control_handler {
>  			uint16_t params_len, uint8_t *params, void *user_data);
>  };
>  
> +struct avrcp_control_ind {
> +};
> +
> +struct avrcp_control_cfm {
> +};
> +
>  struct avrcp_passthrough_handler {
>  	uint8_t op;
>  	bool (*func) (struct avrcp *session, bool pressed, void *user_data);
> @@ -123,6 +129,11 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
>  void avrcp_shutdown(struct avrcp *session);
>  void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
>  							void *user_data);
> +
> +void avrcp_register_player(struct avrcp *session,
> +				const struct avrcp_control_ind *ind,
> +				const struct avrcp_control_cfm *cfm,
> +				void *user_data);
>  void avrcp_set_control_handlers(struct avrcp *session,
>  				const struct avrcp_control_handler *handlers,
>  				void *user_data);
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
