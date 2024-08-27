Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C141946B5
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746802; cv=none; b=lFRVhqvrKNFPWFHmTUKhtDZrHd3Dh/PCj+B4YDEcpY7e1k6a3xH60YN8/cksgi+5Nnsh1hbW87ysCAF5SACaHcIIQvv9lDMqOUr3q9Ock4thcN9sTCe9FzR0pSpZdTll7FjJOOLFVIWeEz8PiS2apURe2RMmisxeHbron+M1jGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746802; c=relaxed/simple;
	bh=Q1MnWK+q2Ki8FDU55KqjuAzBVyrb6/UX+23k89pyXMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=r96lM6PP1FM7UzTejVTgY/ElSLExZEoSUmJbWOmeNJnX2rtjGMwE6aZiS8d4BOVNQj9kUE0Uml5/uX0ggHZI3dZmCOvZ4XVqxk1SQcrSGgyATy+rB5LXfuGLDFCw7wKL2pLxbK24DMCIyO7nWA27/oMzqXIjnb3cSwdzr5bd578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.14.122] (v122.vpnx.molgen.mpg.de [141.14.14.122])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AA41561E5FE05;
	Tue, 27 Aug 2024 10:19:46 +0200 (CEST)
Message-ID: <cf6d8d94-2bdf-4b60-95cd-18d67e8d4b96@molgen.mpg.de>
Date: Tue, 27 Aug 2024 10:19:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: MGMT: Fix not generating command
 complete for MGMT_OP_DISCONNECT
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20240826202518.524007-1-luiz.dentz@gmail.com>
 <20240826202518.524007-2-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240826202518.524007-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Thank you for the patch. Two minor comments.

Am 26.08.24 um 22:25 schrieb Luiz Augusto von Dentz:
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
>   net/bluetooth/hci_conn.c |  6 +++-
>   net/bluetooth/mgmt.c     | 72 +++++++++++++++++++++++-----------------
>   2 files changed, 47 insertions(+), 31 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 8f0c9322eadb..6225f13177c3 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -2951,5 +2951,9 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
>   		return 0;
>   	}
>   
> -	return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NULL);
> +	/* Run immediately if on cmd_sync_work since it maybe called from
> +	 * as a result to MGMT_OP_DISCONNECT and MGMT_OP_UNPAIR which does

I am unable to parse it from “since …”.

> +	 * already queue its callback on cmd_sync_work.
> +	 */
> +	return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
>   }
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 25979f4283a6..54dc9976abcf 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2921,7 +2921,12 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
>   	if (!conn)
>   		return 0;
>   
> -	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
> +	/* Disregard any possible error since the likes of hci_abort_conn_sync
> +	 * will cleanup the connection no matter the error.

The verb *clean up* is spelled with a space.


Kind regards,

Paul


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
> @@ -9744,8 +9761,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
>   	if (link_type != ACL_LINK && link_type != LE_LINK)
>   		return;
>   
> -	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
> -
>   	bacpy(&ev.addr.bdaddr, bdaddr);
>   	ev.addr.type = link_to_bdaddr(link_type, addr_type);
>   	ev.reason = reason;
> @@ -9758,9 +9773,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
>   
>   	if (sk)
>   		sock_put(sk);
> -
> -	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
> -			     hdev);
>   }
>   
>   void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,

