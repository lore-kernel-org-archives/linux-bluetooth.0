Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Mar 2014 16:02:02 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] android/avrcp-lib: Change API to register
 callbacks instead of PDU handlers
Message-ID: <20140312140200.GA28725@aemeltch-MOBL1>
References: <1394630342-32469-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394630342-32469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Mar 12, 2014 at 03:19:02PM +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds avrcp_register_player function to register callbacks for
> requests and responses, the fundamental difference is that the
> callbacks are called after the original PDU is parsed and the parameter
> are converted to host byte order making us able to unit test the
> parsing itself.
> ---
>  android/avrcp-lib.c | 23 +++++++++++++++++
>  android/avrcp-lib.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)
> 
> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> index befc404..953674b 100644
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
> @@ -249,6 +257,21 @@ void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
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

where do you free it?

Best regards 
Andrei Emeltchenko 

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
> index 91a7d47..62c989d 100644
> --- a/android/avrcp-lib.h
> +++ b/android/avrcp-lib.h
> @@ -99,6 +99,74 @@ struct avrcp_control_handler {
>  			uint16_t params_len, uint8_t *params, void *user_data);
>  };
>  
> +struct avrcp_control_ind {
> +	int (*get_capabilities) (struct avrcp *session,
> +					uint8_t transaction, void *user_data);
> +	int (*list_attributes) (struct avrcp *session,
> +					uint8_t transaction, void *user_data);
> +	int (*get_attribute_text) (struct avrcp *session, uint8_t transaction,
> +					uint16_t number, uint8_t *attrs,
> +					void *user_data);
> +	int (*list_values) (struct avrcp *session, uint8_t transaction,
> +					uint8_t attr, void *user_data);
> +	int (*get_value_text) (struct avrcp *session, uint8_t transaction,
> +					uint8_t attr, void *user_data);
> +	int (*get_value) (struct avrcp *session, uint8_t transaction,
> +					uint16_t number, uint8_t *attrs,
> +					void *user_data);
> +	int (*set_value) (struct avrcp *session, uint8_t transaction,
> +					uint16_t number, uint8_t *attrs,
> +					void *user_data);
> +	int (*get_play_status) (struct avrcp *session, uint8_t transaction,
> +					void *user_data);
> +	int (*get_element_attributes) (struct avrcp *session,
> +					uint8_t transaction, uint8_t number,
> +					uint32_t *attrs, void *user_data);
> +	int (*register_notification) (struct avrcp *session,
> +					uint8_t transaction, uint8_t event,
> +					uint32_t interval, void *user_data);
> +};
> +
> +struct avrcp_element {
> +	uint32_t attr;
> +	char *value;
> +};
> +
> +struct avrcp_control_cfm {
> +	void (*get_capabilities) (struct avrcp *session, int err,
> +					uint8_t *events, void *user_data);
> +	void (*list_attributes) (struct avrcp *session, int err,
> +					uint8_t number, uint8_t *attrs,
> +					void *user_data);
> +	void (*get_attribute_text) (struct avrcp *session, int err,
> +					uint16_t number, uint8_t *attrs,
> +					void *user_data);
> +	void (*list_values) (struct avrcp *session, int err,
> +					uint8_t number, uint8_t *values,
> +					void *user_data);
> +	void (*get_value_text) (struct avrcp *session, int err,
> +					const char *value, void *user_data);
> +	void (*get_value) (struct avrcp *session, int err,
> +					uint16_t number, uint8_t *attrs,
> +					void *user_data);
> +	void (*set_value) (struct avrcp *session, int err,
> +					uint16_t number, uint8_t *attrs,
> +					void *user_data);
> +	void (*get_play_status) (struct avrcp *session, int err,
> +					uint32_t position, uint32_t duration,
> +					void *user_data);
> +	void (*get_element_attributes) (struct avrcp *session, int err,
> +					const GSList *elements,
> +					void *user_data);
> +	void (*status_changed) (struct avrcp *session, int err,
> +					uint8_t status, void *user_data);
> +	void (*track_changed) (struct avrcp *session, int err,
> +					uint64_t uid, void *user_data);
> +	void (*settings_changed) (struct avrcp *session, int err,
> +					uint8_t number, uint8_t *attrs,
> +					void *user_data);
> +};
> +
>  struct avrcp_passthrough_handler {
>  	uint8_t op;
>  	bool (*func) (struct avrcp *session, bool pressed, void *user_data);
> @@ -122,6 +190,11 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
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
