Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 17:58:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] client: Fix not propagating GError in session
 API functions
Message-ID: <20120426145842.GA8697@x220.P-661HNU-F1>
References: <1335451079-11868-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335451079-11868-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Apr 26, 2012, Luiz Augusto von Dentz wrote:
> +gboolean obc_session_put(struct obc_session *session, const char *contents,
> +				size_t size, const char *name, GError **err)
>  {
>  	struct obc_transfer *transfer;
>  	const char *agent;
> @@ -1052,11 +1057,11 @@ int obc_session_put(struct obc_session *session, const char *contents,
>  	agent = obc_agent_get_name(session->agent);
>  
>  	transfer = obc_transfer_put(session->conn, agent, NULL, name, NULL,
> -							contents, size, NULL);
> +						contents, size, NULL, err);
>  	if (transfer == NULL)
>  		return -EIO;

This doesn't seem right. You're changing the function to return gboolean
instead of int but yet it returns -EIO upon error?

Johan
