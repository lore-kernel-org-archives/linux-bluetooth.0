Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DC30595B
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466182; cv=none; b=Fn7GnzUXc6sMtkHvZnnG7hJgbNeUHKAV/8hCXvrtYlBPdwIoZ9Oltg1RSzfzmqYO7HLqSnAZk23KK7HP7YztcXYzaUJXOArEBi2H0HI3LOCOlcGXwdb5bCQOxgY+0cujVVY9pm2/E1yqaKyBpNDeEi7vFGioPc7jdYSXHA506FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466182; c=relaxed/simple;
	bh=InTWlHe77Y8cK3+sfhIsH4T7/5kvv4yAqnD16RYRCAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=TCrjxTAbyj9nhL7dw0Nmmc4ue/y7MFFZunT9RvXXqbMzMnFIbTJaMl/mUlzY1hJ42KLySmIjnhXaGjCGHedRSGJoFt+jrzqhA3cT8iXgjuquYnTYBEJyk0W2b9aTyNz1YElz1KZUwT020G6NRazbNzrnm3vnaHAziB5BqglLbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af744.dynamic.kabel-deutschland.de [95.90.247.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 43A5B4C44300B5;
	Mon, 26 Jan 2026 23:22:53 +0100 (CET)
Message-ID: <a6de61dc-5b9b-4b40-a39f-fcc2a68eeffc@molgen.mpg.de>
Date: Mon, 26 Jan 2026 23:22:52 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix not tracking outstanding TX
 ident
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20260126175340.3576865-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260126175340.3576865-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 26.01.26 um 18:53 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to proper track outstanding request by using struct ida

proper*ly*

> and allocating from it in l2cap_get_ident using ida_alloc_range which
> would reuse ids as they are free, then upon completion release
> the id using ida_free.
> 
> This fixes the qualification test case L2CAP/COS/CED/BI-29-C which
> attempts to check if the host stack is able to work after 256 attempts
> to connect which would for Ident field to use the full range.

The last sentence seems incomplete.

> Link: https://github.com/bluez/bluez/issues/1829
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   include/net/bluetooth/l2cap.h |  3 +--
>   net/bluetooth/l2cap_core.c    | 46 ++++++++++++++++++++++++-----------
>   2 files changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 00e182a22720..ec3af01e4db9 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -655,8 +655,7 @@ struct l2cap_conn {
>   
>   	struct sk_buff		*rx_skb;
>   	__u32			rx_len;
> -	__u8			tx_ident;
> -	struct mutex		ident_lock;
> +	struct ida		tx_ida;
>   
>   	struct sk_buff_head	pending_rx;
>   	struct work_struct	pending_rx_work;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 07b493331fd7..b628b0fa39b2 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -924,26 +924,18 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
>   				 initiator);
>   }
>   
> -static u8 l2cap_get_ident(struct l2cap_conn *conn)
> +static int l2cap_get_ident(struct l2cap_conn *conn)
>   {
> -	u8 id;
> +	/* LE link does not support tools like l2ping so use the full range */
> +	if (conn->hcon->type == LE_LINK)
> +		return ida_alloc_range(&conn->tx_ida, 1, 255, GFP_ATOMIC);
>   
>   	/* Get next available identificator.
>   	 *    1 - 128 are used by kernel.
>   	 *  129 - 199 are reserved.
>   	 *  200 - 254 are used by utilities like l2ping, etc.
>   	 */
> -
> -	mutex_lock(&conn->ident_lock);
> -
> -	if (++conn->tx_ident > 128)
> -		conn->tx_ident = 1;
> -
> -	id = conn->tx_ident;
> -
> -	mutex_unlock(&conn->ident_lock);
> -
> -	return id;
> +	return ida_alloc_range(&conn->tx_ida, 1, 128, GFP_ATOMIC);
>   }
>   
>   static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
> @@ -1773,6 +1765,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
>   	if (work_pending(&conn->pending_rx_work))
>   		cancel_work_sync(&conn->pending_rx_work);
>   
> +	ida_destroy(&conn->tx_ida);
> +
>   	cancel_delayed_work_sync(&conn->id_addr_timer);
>   
>   	l2cap_unregister_all_users(conn);
> @@ -4782,12 +4776,34 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
>   	return err;
>   }
>   
> +static void l2cap_put_ident(struct l2cap_conn *conn, u8 code, u8 id)
> +{
> +	switch (code) {
> +	case L2CAP_COMMAND_REJ:
> +	case L2CAP_CONN_RSP:
> +	case L2CAP_CONF_RSP:
> +	case L2CAP_DISCONN_RSP:
> +	case L2CAP_ECHO_RSP:
> +	case L2CAP_INFO_RSP:
> +	case L2CAP_CONN_PARAM_UPDATE_RSP:
> +	case L2CAP_ECRED_CONN_RSP:
> +	case L2CAP_ECRED_RECONF_RSP:
> +		/* First do a lookup since the remote may send bogus ids that
> +		 * would make ida_free to generate warnings.
> +		 */
> +		if (ida_find_first_range(&conn->tx_ida, id, id) >= 0)
> +			ida_free(&conn->tx_ida, id);
> +	}
> +}
> +
>   static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
>   				      struct l2cap_cmd_hdr *cmd, u16 cmd_len,
>   				      u8 *data)
>   {
>   	int err = 0;
>   
> +	l2cap_put_ident(conn, cmd->code, cmd->ident);
> +
>   	switch (cmd->code) {
>   	case L2CAP_COMMAND_REJ:
>   		l2cap_command_rej(conn, cmd, cmd_len, data);
> @@ -5419,6 +5435,8 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
>   {
>   	int err = 0;
>   
> +	l2cap_put_ident(conn, cmd->code, cmd->ident);
> +
>   	switch (cmd->code) {
>   	case L2CAP_COMMAND_REJ:
>   		l2cap_le_command_rej(conn, cmd, cmd_len, data);
> @@ -6907,13 +6925,13 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
>   	     hci_dev_test_flag(hcon->hdev, HCI_FORCE_BREDR_SMP)))
>   		conn->local_fixed_chan |= L2CAP_FC_SMP_BREDR;
>   
> -	mutex_init(&conn->ident_lock);
>   	mutex_init(&conn->lock);
>   
>   	INIT_LIST_HEAD(&conn->chan_l);
>   	INIT_LIST_HEAD(&conn->users);
>   
>   	INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
> +	ida_init(&conn->tx_ida);
>   
>   	skb_queue_head_init(&conn->pending_rx);
>   	INIT_WORK(&conn->pending_rx_work, process_pending_rx);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
