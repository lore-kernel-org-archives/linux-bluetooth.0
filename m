Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Mar 2014 10:42:11 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 02/12] android/avrcp-lib: Add support for parsing
 GetCapabilities PDU
Message-ID: <20140317084210.GB16561@aemeltch-MOBL1>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
 <1395043737-8905-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395043737-8905-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 17, 2014 at 10:08:47AM +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  android/avrcp-lib.c | 32 ++++++++++++++++++++++++++++++++
>  android/avrcp-lib.h |  2 ++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> index ca01b50..9c19092 100644
> --- a/android/avrcp-lib.c
> +++ b/android/avrcp-lib.c
> @@ -261,6 +261,37 @@ void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
>  	session->destroy_data = user_data;
>  }
>  
> +static ssize_t get_capabilities(struct avrcp *session, uint8_t transaction,

Should it be handle_get_capabilities() to make it consistent with the
other code.

Best regards 
Andrei Emeltchenko 

> +				uint16_t params_len, uint8_t *params,
> +				void *user_data)
> +{
> +	struct avrcp_player *player = user_data;
> +
> +	if (!params || params_len != 1)
> +		return -EINVAL;
> +
> +	switch (params[0]) {
> +	case CAP_COMPANY_ID:
> +		params[1] = 1;
> +		hton24(&params[2], IEEEID_BTSIG);
> +		return 5;
> +	case CAP_EVENTS_SUPPORTED:
> +		if (!player->ind || !player->ind->get_capabilities)
> +			return -ENOSYS;
> +		return player->ind->get_capabilities(session, transaction,
> +							player->user_data);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct avrcp_control_handler player_handlers[] = {
> +		{ AVRCP_GET_CAPABILITIES,
> +					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> +					get_capabilities },
> +		{ },
> +};
> +
>  void avrcp_register_player(struct avrcp *session,
>  				const struct avrcp_control_ind *ind,
>  				const struct avrcp_control_cfm *cfm,
> @@ -273,6 +304,7 @@ void avrcp_register_player(struct avrcp *session,
>  	player->cfm = cfm;
>  	player->user_data = user_data;
>  
> +	avrcp_set_control_handlers(session, player_handlers, player);
>  	session->player = player;
>  }
>  
> diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
> index 6e33a75..34c88c5 100644
> --- a/android/avrcp-lib.h
> +++ b/android/avrcp-lib.h
> @@ -101,6 +101,8 @@ struct avrcp_control_handler {
>  };
>  
>  struct avrcp_control_ind {
> +	int (*get_capabilities) (struct avrcp *session, uint8_t transaction,
> +							void *user_data);
>  };
>  
>  struct avrcp_control_cfm {
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
