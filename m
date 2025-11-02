Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78F34D396
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Nov 2025 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125756; cv=none; b=beSCxGg7HOHVIzXMZBpUYVXIiYUfyxbDdfx8Y/6MWar7XKhSsmOHGQlbKl+nMO46w+KLsRA9U6rj+22+IDLoG8Hxii/1q/rvhYK9bGrEhHyqOTGUhvNgVBot/uLrPT9duoZe+VXvblEgP9K7M7AnJHPAVgOgQ3O49iD81kVjeWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125756; c=relaxed/simple;
	bh=rqQUGPXe8jmOyTGXreI182XfIVUQErPlF35SpWKUxHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/C+T+JJ8HYaI99GKsvmjcPFEoUkjRCKKTLZAr1XXgSM9uWYlfiBG/iQ/fn3m3u4NTkY3F+RyC00d+a1LRaNWq5vhTqK+j+Lc0aJQ9SnkdjaHPkzqVFlTNrIALJHOVqkDLZAIZ6Qv4mI0bu0tHbjrBQCTNd1M4jph31dfNX4UlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=LwzMaTTr; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="LwzMaTTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762125748;
	bh=q2tM2vbGQB0CDtDNhNTWUgm7ZGDOUmfPYMZJ7yzUNsU=;
	h=From:Subject:Date:Message-ID;
	b=LwzMaTTrhoPUV14hHD5jwJ2r4QMnR12M9O9GCahfixAfYHTm+Smoipk8lC6eRXL14
	 s4c9MW9OvNnv6p+BSS1w5hCy+Gp6mDdq0PIdgQQnobz5iwHYDjdclvpFTtmPEQGTp8
	 mISt2JbxriYrhezzGIqFiAg7gQNg44rS0ZS1Lrro=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6907E78A00004ACF; Sun, 3 Nov 2025 07:21:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8089414456639
X-SMAIL-UIID: 0436A542D9734FE786A5BB7580623449-20251103-072148-1
From: Hillf Danton <hdanton@sina.com>
To: Pauli Virtanen <pav@iki.fi>
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] Bluetooth: mgmt: take lock and hold reference when handling hci_conn
Date: Mon,  3 Nov 2025 07:21:35 +0800
Message-ID: <20251102232137.8830-1-hdanton@sina.com>
In-Reply-To: <1ac16b2d328ccef42d09e875c09232bd7f0e32da.1762100290.git.pav@iki.fi>
References: <cover.1762100290.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  2 Nov 2025 18:19:35 +0200 Pauli Virtanen wrote:
> Take hdev/rcu lock to prevent concurrent deletion of the hci_conn we are
> handling.
> 
> When using hci_conn* pointers across critical sections, always take
> refcount to keep the pointer valid.
> 
> For hci_abort_conn() only hold refcount, as the function takes
> hdev->lock itself.
> 
> Fixes: 227a0cdf4a028 ("Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>     v2:
>     - no change
> 
>  net/bluetooth/mgmt.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 78b7af8bf45f..535c475c2d25 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3081,6 +3081,8 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
>  	struct mgmt_cp_unpair_device *cp = cmd->param;
>  	struct hci_conn *conn;
>  
> +	rcu_read_lock();
> +
>  	if (cp->addr.type == BDADDR_BREDR)
>  		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>  					       &cp->addr.bdaddr);
> @@ -3088,6 +3090,11 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
>  		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
>  					       le_addr_type(cp->addr.type));
>  
> +	if (conn)
> +		hci_conn_get(conn);
> +
> +	rcu_read_unlock();
> +
Given RCU in the lookup helpers, nested RCU makes no sense.
Feel free to add the lookup_and_get helper instead to bump the refcnt up
for the conn found.

Another simpler option is -- add conn to hash with refcnt increased and
correspondingly put conn after deleting it from hash.

>  	if (!conn)
>  		return 0;
>  
> @@ -3095,6 +3102,7 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
>  	 * will clean up the connection no matter the error.
>  	 */
>  	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> +	hci_conn_put(conn);
>  
>  	return 0;
>  }
> @@ -3242,6 +3250,8 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
>  	struct mgmt_cp_disconnect *cp = cmd->param;
>  	struct hci_conn *conn;
>  
> +	rcu_read_lock();
> +
>  	if (cp->addr.type == BDADDR_BREDR)
>  		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>  					       &cp->addr.bdaddr);
> @@ -3249,6 +3259,11 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
>  		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
>  					       le_addr_type(cp->addr.type));
>  
> +	if (conn)
> +		hci_conn_get(conn);
> +
> +	rcu_read_unlock();
> +
>  	if (!conn)
>  		return -ENOTCONN;
>  
> @@ -3256,6 +3271,7 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
>  	 * will clean up the connection no matter the error.
>  	 */
>  	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> +	hci_conn_put(conn);
>  
>  	return 0;
>  }
> @@ -7372,6 +7388,9 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
>  		rp.max_tx_power = HCI_TX_POWER_INVALID;
>  	}
>  
> +	if (conn)
> +		hci_conn_put(conn);
> +
>  	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, MGMT_OP_GET_CONN_INFO, status,
>  			  &rp, sizeof(rp));
>  
> @@ -7386,6 +7405,8 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
>  	int err;
>  	__le16   handle;
>  
> +	hci_dev_lock(hdev);
> +
>  	/* Make sure we are still connected */
>  	if (cp->addr.type == BDADDR_BREDR)
>  		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
> @@ -7393,12 +7414,16 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
>  	else
>  		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
>  
> -	if (!conn || conn->state != BT_CONNECTED)
> +	if (!conn || conn->state != BT_CONNECTED) {
> +		hci_dev_unlock(hdev);
>  		return MGMT_STATUS_NOT_CONNECTED;
> +	}
>  
> -	cmd->user_data = conn;
> +	cmd->user_data = hci_conn_get(conn);
>  	handle = cpu_to_le16(conn->handle);
>  
> +	hci_dev_unlock(hdev);
> +
>  	/* Refresh RSSI each time */
>  	err = hci_read_rssi_sync(hdev, handle);
>  
> @@ -7532,6 +7557,9 @@ static void get_clock_info_complete(struct hci_dev *hdev, void *data, int err)
>  	}
>  
>  complete:
> +	if (conn)
> +		hci_conn_put(conn);
> +
>  	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status, &rp,
>  			  sizeof(rp));
>  
> @@ -7548,15 +7576,21 @@ static int get_clock_info_sync(struct hci_dev *hdev, void *data)
>  	memset(&hci_cp, 0, sizeof(hci_cp));
>  	hci_read_clock_sync(hdev, &hci_cp);
>  
> +	hci_dev_lock(hdev);
> +
>  	/* Make sure connection still exists */
>  	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
> -	if (!conn || conn->state != BT_CONNECTED)
> +	if (!conn || conn->state != BT_CONNECTED) {
> +		hci_dev_unlock(hdev);
>  		return MGMT_STATUS_NOT_CONNECTED;
> +	}
>  
> -	cmd->user_data = conn;
> +	cmd->user_data = hci_conn_get(conn);
>  	hci_cp.handle = cpu_to_le16(conn->handle);
>  	hci_cp.which = 0x01; /* Piconet clock */
>  
> +	hci_dev_unlock(hdev);
> +
>  	return hci_read_clock_sync(hdev, &hci_cp);
>  }
>  
> -- 
> 2.51.1
