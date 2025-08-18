Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18A21CFFD
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550673; cv=none; b=HpKOL0em7Y7iQ161o2zxv+gC9FNFEkvhQdEWjxrr2t81uRh4hU6pQlrAF9/dYW5qusETEiPrWLzn/pQGAgFBxWNezP1qkfBXWTLJf0DeURc9ommf6Cy2V2ugnsRmQWXi55Xk4yTypwNITlNRN1AnbRq4FiVfEFmf3BCXjUufbrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550673; c=relaxed/simple;
	bh=4IBQ4ueaEHOcEL70LmwtwXVVYCbcCXOvQPuTTtGUpt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=o4hOJTsQ0SmKSm4PmSoWpGtZ4CCn5s6zldrvR8vNKhMqhiHwVDeanFpFy14vjozFe6ypxaYHMLvL/mGr4Mnv6ndx7BYgsix/iXmqUZ6uaVUWkyO/ZKqLtTaHH5BHaK2LGcw8+1DDhW1DWu2ptGLsUx28O5/Cz0aPSrzxo3jsQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7b8.dynamic.kabel-deutschland.de [95.90.247.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 655F161E64844;
	Mon, 18 Aug 2025 22:57:46 +0200 (CEST)
Message-ID: <8ddd787f-c1ef-47ac-b53b-45956a2be007@molgen.mpg.de>
Date: Mon, 18 Aug 2025 22:57:43 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] Bluetooth: hci_conn: Convert instances of BT_DBG
 to bt_dev_dbg
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250818204753.1203949-1-luiz.dentz@gmail.com>
 <20250818204753.1203949-2-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250818204753.1203949-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Thank you for your patch.

Am 18.08.25 um 22:47 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This converts instances of BT_DBG to bt_dev_dbg when logging to a
> specific hci_dev this is preferable since it does prints the name by
> default.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_conn.c | 63 ++++++++++++++++++++++------------------
>   1 file changed, 34 insertions(+), 29 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 111f0e37b672..9b23865244b4 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -177,7 +177,7 @@ static void hci_conn_cleanup(struct hci_conn *conn)
>   
>   int hci_disconnect(struct hci_conn *conn, __u8 reason)
>   {
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(conn->hdev, "hcon %p", conn);
>   
>   	/* When we are central of an established connection and it enters
>   	 * the disconnect timeout, then go ahead and try to read the
> @@ -202,7 +202,7 @@ static void hci_add_sco(struct hci_conn *conn, __u16 handle)
>   	struct hci_dev *hdev = conn->hdev;
>   	struct hci_cp_add_sco cp;
>   
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(hdev, "hcon %p", conn);
>   
>   	conn->state = BT_CONNECT;
>   	conn->out = true;
> @@ -225,8 +225,9 @@ static bool find_next_esco_param(struct hci_conn *conn,
>   		if (lmp_esco_2m_capable(conn->parent) ||
>   		    (esco_param[conn->attempt - 1].pkt_type & ESCO_2EV3))
>   			break;
> -		BT_DBG("hcon %p skipped attempt %d, eSCO 2M not supported",
> -		       conn, conn->attempt);
> +		bt_dev_dbg(conn->hdev,
> +			   "hcon %p skipped attempt %d, eSCO 2M not supported",
> +			   conn, conn->attempt);
>   	}
>   
>   	return conn->attempt <= size;
> @@ -522,7 +523,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
>   	struct hci_dev *hdev = conn->hdev;
>   	struct hci_cp_le_start_enc cp;
>   
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(hdev, "hcon %p", conn);
>   
>   	memset(&cp, 0, sizeof(cp));
>   
> @@ -543,7 +544,7 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
>   	if (!link || !link->conn)
>   		return;
>   
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(conn->hdev, "hcon %p", conn);
>   
>   	if (!status) {
>   		if (lmp_esco_capable(conn->hdev))
> @@ -562,7 +563,8 @@ static void hci_conn_timeout(struct work_struct *work)
>   					     disc_work.work);
>   	int refcnt = atomic_read(&conn->refcnt);
>   
> -	BT_DBG("hcon %p state %s", conn, state_to_string(conn->state));
> +	bt_dev_dbg(conn->hdev, "hcon %p state %s", conn,
> +		   state_to_string(conn->state));
>   
>   	WARN_ON(refcnt < 0);
>   
> @@ -586,7 +588,7 @@ static void hci_conn_idle(struct work_struct *work)
>   					     idle_work.work);
>   	struct hci_dev *hdev = conn->hdev;
>   
> -	BT_DBG("hcon %p mode %d", conn, conn->mode);
> +	bt_dev_dbg(hdev, "hcon %p mode %d", conn, conn->mode);
>   
>   	if (!lmp_sniff_capable(hdev) || !lmp_sniff_capable(conn))
>   		return;
> @@ -646,7 +648,7 @@ static void le_conn_timeout(struct work_struct *work)
>   					     le_conn_timeout.work);
>   	struct hci_dev *hdev = conn->hdev;
>   
> -	BT_DBG("");
> +	bt_dev_dbg(hdev, "");
>   
>   	/* We could end up here due to having done directed advertising,
>   	 * so clean up the state if necessary. This should however only
> @@ -774,7 +776,8 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
>   	struct iso_list_data *d;
>   	int ret;
>   
> -	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, conn->sync_handle);
> +	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big,
> +		   conn->sync_handle);
>   
>   	d = kzalloc(sizeof(*d), GFP_KERNEL);
>   	if (!d)
> @@ -820,7 +823,7 @@ static void bis_cleanup(struct hci_conn *conn)
>   	struct hci_dev *hdev = conn->hdev;
>   	struct hci_conn *bis;
>   
> -	bt_dev_dbg(hdev, "conn %p", conn);
> +	bt_dev_dbg(hdev, "hcon %p", conn);

I’d leave out the two hunks above.

>   	if (conn->role == HCI_ROLE_MASTER) {
>   		if (!test_and_clear_bit(HCI_CONN_PER_ADV, &conn->flags))
> @@ -1141,7 +1144,7 @@ void hci_conn_del(struct hci_conn *conn)
>   {
>   	struct hci_dev *hdev = conn->hdev;
>   
> -	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
> +	bt_dev_dbg(hdev, "hcon %p handle %d", conn, conn->handle);
>   
>   	hci_conn_unlink(conn);
>   
> @@ -1466,8 +1469,8 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
>   
>   	params->explicit_connect = true;
>   
> -	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
> -	       params->auto_connect);
> +	bt_dev_dbg(hdev, "addr %pMR (type %u) auto_connect %u", addr, addr_type,
> +		   params->auto_connect);
>   
>   	return 0;
>   }
> @@ -1619,7 +1622,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
>   		goto done;
>   	}
>   
> -	BT_DBG("requesting refresh of dst_addr");
> +	bt_dev_dbg(hdev, "requesting refresh of dst_addr");
>   
>   	conn = hci_conn_add_unset(hdev, LE_LINK, dst, HCI_ROLE_MASTER);
>   	if (IS_ERR(conn))
> @@ -2167,7 +2170,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
>   {
>   	struct hci_conn *conn = data;
>   
> -	bt_dev_dbg(hdev, "conn %p", conn);
> +	bt_dev_dbg(hdev, "hcon %p", conn);
>   
>   	if (err) {
>   		bt_dev_err(hdev, "Unable to create BIG: %d", err);
> @@ -2349,7 +2352,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
>   /* Check link security requirement */
>   int hci_conn_check_link_mode(struct hci_conn *conn)
>   {
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(conn->hdev, "hcon %p", conn);
>   
>   	/* In Secure Connections Only mode, it is required that Secure
>   	 * Connections is used and the link is encrypted with AES-CCM
> @@ -2389,7 +2392,7 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
>   /* Authenticate remote device */
>   static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
>   {
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(conn->hdev, "hcon %p", conn);
>   
>   	if (conn->pending_sec_level > sec_level)
>   		sec_level = conn->pending_sec_level;
> @@ -2424,7 +2427,7 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
>   /* Encrypt the link */
>   static void hci_conn_encrypt(struct hci_conn *conn)
>   {
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(conn->hdev, "hcon %p", conn);
>   
>   	if (!test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags)) {
>   		struct hci_cp_set_conn_encrypt cp;
> @@ -2439,7 +2442,8 @@ static void hci_conn_encrypt(struct hci_conn *conn)
>   int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
>   		      bool initiator)
>   {
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(conn->hdev, "hcon %p sec_level %d auth_type %d initiator %d",
> +		   conn, sec_level, auth_type, initiator);
>   
>   	if (conn->type == LE_LINK)
>   		return smp_conn_security(conn, sec_level);
> @@ -2523,7 +2527,7 @@ EXPORT_SYMBOL(hci_conn_security);
>   /* Check secure link requirement */
>   int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level)
>   {
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(conn->hdev, "hcon %p sec_level %u", conn, sec_level);
>   
>   	/* Accept if non-secure or higher security level is required */
>   	if (sec_level != BT_SECURITY_HIGH && sec_level != BT_SECURITY_FIPS)
> @@ -2542,7 +2546,7 @@ EXPORT_SYMBOL(hci_conn_check_secure);
>   /* Switch role */
>   int hci_conn_switch_role(struct hci_conn *conn, __u8 role)
>   {
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(conn->hdev, "hcon %p role %u", conn, role);
>   
>   	if (role == conn->role)
>   		return 1;
> @@ -2563,7 +2567,7 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
>   {
>   	struct hci_dev *hdev = conn->hdev;
>   
> -	BT_DBG("hcon %p mode %d", conn, conn->mode);
> +	bt_dev_dbg(hdev, "hcon %p mode %d", conn, conn->mode);
>   
>   	if (conn->mode != HCI_CM_SNIFF)
>   		goto timer;
> @@ -2589,7 +2593,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
>   	struct list_head *head = &hdev->conn_hash.list;
>   	struct hci_conn *conn;
>   
> -	BT_DBG("hdev %s", hdev->name);
> +	bt_dev_dbg(hdev, "");
>   
>   	/* We should not traverse the list here, because hci_conn_del
>   	 * can remove extra links, which may cause the list traversal
> @@ -2732,10 +2736,10 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
>   	struct hci_dev *hdev = conn->hdev;
>   	struct hci_chan *chan;
>   
> -	BT_DBG("%s hcon %p", hdev->name, conn);
> +	bt_dev_dbg(hdev, "hcon %p", conn);
>   
>   	if (test_bit(HCI_CONN_DROP, &conn->flags)) {
> -		BT_DBG("Refusing to create new hci_chan");
> +		bt_dev_dbg(hdev, "Refusing to create new hci_chan");
>   		return NULL;
>   	}
>   
> @@ -2757,7 +2761,7 @@ void hci_chan_del(struct hci_chan *chan)
>   	struct hci_conn *conn = chan->conn;
>   	struct hci_dev *hdev = conn->hdev;
>   
> -	BT_DBG("%s hcon %p chan %p", hdev->name, conn, chan);
> +	bt_dev_dbg(hdev, "hcon %p chan %p", conn, chan);
>   
>   	list_del_rcu(&chan->list);
>   
> @@ -2776,7 +2780,7 @@ void hci_chan_list_flush(struct hci_conn *conn)
>   {
>   	struct hci_chan *chan, *n;
>   
> -	BT_DBG("hcon %p", conn);
> +	bt_dev_dbg(conn->hdev, "hcon %p", conn);
>   
>   	list_for_each_entry_safe(chan, n, &conn->chan_list, list)
>   		hci_chan_del(chan);
> @@ -2937,7 +2941,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
>   	if (conn->abort_reason)
>   		return 0;
>   
> -	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
> +	bt_dev_dbg(hdev, "hcon %p handle 0x%2.2x reason 0x%2.2x", conn,
> +		   conn->handle, reason);

Ditto.

>   
>   	conn->abort_reason = reason;
>   

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
