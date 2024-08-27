Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79CF1CDA1D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776843; cv=none; b=FX2x3NlBjyaUu4QoYXNM02htqQrjXpu02gf7O62TjsmrZTZMwrguSMAkM0h9XC96wCRmzc6pnZFK8Z5a5rk9vw0Gjj3jS6Wp/H3x9SHWFQL16aG81KDs70rg1kJ2VvjiFmE8a85RieHr7qivcSc4tivyfzbGnCTvys91utPtEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776843; c=relaxed/simple;
	bh=QWKegxBTcwv53Xz1SMWHSQ2mW8gaMNECq7tIHvYcjg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=lvvxpSRBn2aUJcmaby9HdhzukXiuGhCqlpWDLpQd+NPpWP8MWLXI1kTTVAQojp3W4F77u8BT1b1xTWeNDlL3ZRbn0MclxIgj8EZ+nbrCWIyn6wDF+zURBSaXAoP+pJMaJyuHcLcQenWHIdOOIZjhB5GzqbaVG3ClHvDYEJe6xB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af7d7.dynamic.kabel-deutschland.de [95.90.247.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7A47861E5FE05;
	Tue, 27 Aug 2024 18:40:33 +0200 (CEST)
Message-ID: <a4847d7a-d635-49c2-8fb9-24a2222785d7@molgen.mpg.de>
Date: Tue, 27 Aug 2024 18:40:32 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Bluetooth: MGMT: Fix not generating command
 complete for MGMT_OP_DISCONNECT
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20240827140529.635522-1-luiz.dentz@gmail.com>
 <20240827140529.635522-2-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240827140529.635522-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for posting version 3. I found one more nit.


Am 27.08.24 um 16:05 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> MGMT_OP_DISCONNECT can be called while mgmt_device_connected has not
> been called yet, which will cause the connection procedure to be
> aborted, so mgmt_device_disconnected shall still respond with command
> complete to MGMT_OP_DISCONNECT and just not emit
> MGMT_EV_DEVICE_DISCONNECTED since MGMT_EV_DEVICE_CONNECTED was never
> sent.
> 
> To fix this MGMT_OP_DISCONNECT is changed to work similarly to other
> command which do use hci_cmd_sync_queue and then use hci_conn_abort to
> disconnect and returns the result, in order for hci_conn_abort to be
> used from hci_cmd_sync context it now uses hci_cmd_sync_run_once.
> 
> Link: https://github.com/bluez/bluez/issues/932
> Fixes: 12d4a3b ("Bluetooth: Move check for MGMT_CONNECTED flag into mgmt.c")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_conn.c |  6 ++-
>   net/bluetooth/mgmt.c     | 84 ++++++++++++++++++++--------------------
>   2 files changed, 47 insertions(+), 43 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 8f0c9322eadb..d51d8dbea631 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2951,5 +2951,9 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
>   		return 0;
>   	}
>   
> -	return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NULL);
> +	/* Run immediately if on cmd_sync_work since this maybe called

s/maybe/may be/


Kind regards,

Paul


> +	 * as a result to MGMT_OP_DISCONNECT and MGMT_OP_UNPAIR which does
> +	 * already queue its callback on cmd_sync_work.
> +	 */
> +	return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
>   }
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 25979f4283a6..59f9d457ca31 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2921,7 +2921,12 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
>   	if (!conn)
>   		return 0;
>   
> -	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
> +	/* Disregard any possible error since the likes of hci_abort_conn_sync
> +	 * will cleanup the connection no matter the error.
> +	 */
> +	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> +
> +	return 0;
>   }
>   
>   static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
> @@ -3053,13 +3058,44 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>   	return err;
>   }
>   
> +static void disconnect_complete(struct hci_dev *hdev, void *data, int err)
> +{
> +	struct mgmt_pending_cmd *cmd = data;
> +
> +	cmd->cmd_complete(cmd, mgmt_status(err));
> +	mgmt_pending_free(cmd);
> +}
> +
> +static int disconnect_sync(struct hci_dev *hdev, void *data)
> +{
> +	struct mgmt_pending_cmd *cmd = data;
> +	struct mgmt_cp_disconnect *cp = cmd->param;
> +	struct hci_conn *conn;
> +
> +	if (cp->addr.type == BDADDR_BREDR)
> +		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> +					       &cp->addr.bdaddr);
> +	else
> +		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
> +					       le_addr_type(cp->addr.type));
> +
> +	if (!conn)
> +		return -ENOTCONN;
> +
> +	/* Disregard any possible error since the likes of hci_abort_conn_sync
> +	 * will cleanup the connection no matter the error.
> +	 */
> +	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> +
> +	return 0;
> +}
> +
>   static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
>   		      u16 len)
>   {
>   	struct mgmt_cp_disconnect *cp = data;
>   	struct mgmt_rp_disconnect rp;
>   	struct mgmt_pending_cmd *cmd;
> -	struct hci_conn *conn;
>   	int err;
>   
>   	bt_dev_dbg(hdev, "sock %p", sk);
> @@ -3082,27 +3118,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
>   		goto failed;
>   	}
>   
> -	if (pending_find(MGMT_OP_DISCONNECT, hdev)) {
> -		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
> -					MGMT_STATUS_BUSY, &rp, sizeof(rp));
> -		goto failed;
> -	}
> -
> -	if (cp->addr.type == BDADDR_BREDR)
> -		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> -					       &cp->addr.bdaddr);
> -	else
> -		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
> -					       le_addr_type(cp->addr.type));
> -
> -	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {
> -		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
> -					MGMT_STATUS_NOT_CONNECTED, &rp,
> -					sizeof(rp));
> -		goto failed;
> -	}
> -
> -	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, hdev, data, len);
> +	cmd = mgmt_pending_new(sk, MGMT_OP_DISCONNECT, hdev, data, len);
>   	if (!cmd) {
>   		err = -ENOMEM;
>   		goto failed;
> @@ -3110,9 +3126,10 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
>   
>   	cmd->cmd_complete = generic_cmd_complete;
>   
> -	err = hci_disconnect(conn, HCI_ERROR_REMOTE_USER_TERM);
> +	err = hci_cmd_sync_queue(hdev, disconnect_sync, cmd,
> +				 disconnect_complete);
>   	if (err < 0)
> -		mgmt_pending_remove(cmd);
> +		mgmt_pending_free(cmd);
>   
>   failed:
>   	hci_dev_unlock(hdev);
> @@ -9689,18 +9706,6 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
>   	mgmt_event_skb(skb, NULL);
>   }
>   
> -static void disconnect_rsp(struct mgmt_pending_cmd *cmd, void *data)
> -{
> -	struct sock **sk = data;
> -
> -	cmd->cmd_complete(cmd, 0);
> -
> -	*sk = cmd->sk;
> -	sock_hold(*sk);
> -
> -	mgmt_pending_remove(cmd);
> -}
> -
>   static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)
>   {
>   	struct hci_dev *hdev = data;
> @@ -9744,8 +9749,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
>   	if (link_type != ACL_LINK && link_type != LE_LINK)
>   		return;
>   
> -	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
> -
>   	bacpy(&ev.addr.bdaddr, bdaddr);
>   	ev.addr.type = link_to_bdaddr(link_type, addr_type);
>   	ev.reason = reason;
> @@ -9758,9 +9761,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
>   
>   	if (sk)
>   		sock_put(sk);
> -
> -	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
> -			     hdev);
>   }
>   
>   void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,

