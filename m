Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 18:05:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] client: Fix not propagating GError in session
 API functions
Message-ID: <20120426150530.GB8697@x220.P-661HNU-F1>
References: <1335451079-11868-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335451079-11868-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Apr 26, 2012, Luiz Augusto von Dentz wrote:
> -int obc_session_get(struct obc_session *session, const char *type,
> -		const char *name, const char *targetfile,
> -		const guint8 *apparam, gint apparam_size,
> -		session_callback_t func, void *user_data)
> +gboolean obc_session_get(struct obc_session *session, const char *type,
> +				const char *name, const char *targetfile,
> +				const guint8 *apparam, gint apparam_size,
> +				session_callback_t func, void *user_data,
> +				GError **err)
>  {
>  	struct obc_transfer *transfer;
>  	struct obc_transfer_params *params = NULL;
>  	const char *agent;
>  
> -	if (session->obex == NULL)
> -		return -ENOTCONN;
> +	if (session->obex == NULL) {
> +		g_set_error(err, OBEX_IO_ERROR, -ENOTCONN,
> +						"Session not connected");
> +		return 0;
> +	}
>  
>  	if (apparam != NULL) {
>  		params = g_new0(struct obc_transfer_params, 1);
> @@ -971,20 +975,20 @@ int obc_session_get(struct obc_session *session, const char *type,
>  		agent = NULL;
>  
>  	transfer = obc_transfer_get(session->conn, agent, targetfile, name,
> -								type, params);
> +							type, params, err);
>  	if (transfer == NULL) {
>  		if (params != NULL) {
>  			g_free(params->data);
>  			g_free(params);
>  		}
> -		return -EIO;
> +		return 0;
>  	}

Here's another (similar) strange thing: you're changing the function to
return gboolean yet you're returning values such as 0 in it.

Johan
