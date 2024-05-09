Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07F016F287
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715270771; cv=none; b=ancooZ1B5utp7yc5LWLuPZDn/yMrYTCPgeI/+ruF7mpfAxl8CC7VAl3VNzBG7nYOemfXgBPM3YIBW2MtVZdQa/PHUuk+Vs9XD483MI003hoGO3rmb5bPIp120tp87mChLym9AYsPnJhVC9bQbRgqjtrUMU5uH0Y8LFvChkIeb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715270771; c=relaxed/simple;
	bh=ZoNURM1KfaWa3vN33k6pGmMvBwE4o8rautSlYxhMbuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra20vnRn7FTUjYzk7xY+AiHSOX/+n94plS6zYJh/cyMvHyQnq58/3A3EyX8knrt8pOoUpBOKR4WFkYB9cqdM5YPJPskrluTdSS5xb8nzjUPYTkFt7R+BKx4jiup0Z2Pi5CmssX0rl+b2O7lEd+6VSqIF+kMGcu27SEodP0Y0+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=JJb9Npw0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IupJhIBS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="JJb9Npw0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IupJhIBS"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0107F13815C2;
	Thu,  9 May 2024 12:06:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 09 May 2024 12:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715270765; x=1715357165; bh=2VvgaDT/bg
	cCkx66iQUObQrPXHeDSXsgjz2wBn+QvO0=; b=JJb9Npw0jr8sg17SMdvD+sl8R8
	haijewn9IKoGAVZVyy7YUDQsa5UGPiLbFyzLRV5UfgbsxYC/T64JLxv9JLjUPrkM
	DpUCWR35jG3pT2M5wyO/6A+/X4HvhTkHxGXUEbR5cqJgG/jD/u0xKrFquzwT4+0o
	uYOyJNjjM1ESSCVLBFVsBLksv9n5tiSa49QqmNaVvkYZmRx4Y6E6ajPYPCuvpRxZ
	rYotd1XiKOFTtvMgyj6CobxLgag+2/cXFk8i3OnD+Uh9TmNPFcZZS1dZ3cCbW7+i
	R+Bezk8Ej+3T8YuI1rdhxuEWrBNQbqcbNJv3JO4QdLNluvFsVvpoyDKNk/Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715270765; x=1715357165; bh=2VvgaDT/bgcCkx66iQUObQrPXHeD
	SXsgjz2wBn+QvO0=; b=IupJhIBS+MaLMwbVnnctty1uhB6z8TGsq/cOx9cBbIsD
	clK41cDDRBM9ITLXr7Ur7Df/1n5KJZLAGRtostJLRGF0zezf2wh9IK+BcFwYOoFh
	RoLY5PuF17UQkfpDwzEogSjiR6fTZJ24VnchpQtYwOe5tKGqn4WYMK0lxEixMyZW
	XFv3eWleJmqR5MnVpNf+79OWrPD3fpgCYtu4KKLfnTScmCsReeAIOmjVjHqGQURy
	Zz5r7L9xspN0eoBfSAthpJWftiakMzXPdtPrLsSNx6cCecbTS22Ng6Y2x9t/+L32
	/SSynkHL23REwWbsO3G0+xurJdsXHMZ6mFIWpOnLEA==
X-ME-Sender: <xms:bfQ8Zq__tqOi4FpczZlsQjaLsy1YePCX0gysNgcRM9_ZlIGvGWOFIg>
    <xme:bfQ8Zqsz7N1F66rNHvzfOH-IRCu7yIu5vxMPAoMbgr2iX95jmMJImRHVtVwP6kgDd
    qGGmn-EXZ_WzVI9BN4>
X-ME-Received: <xmr:bfQ8ZgD6AZelrhVXsYFg8D1XgmJ_7WLmiyun0UIr1OpTlYjf8rcFxO4YqzYQsEYgXl4ombu3Gmv4y2xA-MP5u5s8Vc9AixuFLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefvddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhn
    vgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgvdffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnh
    gruhdrnhgvth
X-ME-Proxy: <xmx:bfQ8ZifeVs-42U-p0k3bzj5PTGlumv6pxaYs2Prh-H34KS2iAnkd2w>
    <xmx:bfQ8ZvNkyy2gbivW7V8KHr-X25WwFyXPp8kaI9dGb8bi1CLNN7j6Ew>
    <xmx:bfQ8ZsnpNofM35jynNjYDUyOy99zIjMkINlaXOpBTPbz60ck1C7XgA>
    <xmx:bfQ8ZhuyVS61n0YxMmmVMizf1_qnOsXlLJURXuZtMrWEyC9oX0p8hA>
    <xmx:bfQ8ZkpJgwp7lwUmOitpAXSqgnCrVOWASvTVqrpUyI0FeN-U7pyEsUKv>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 May 2024 12:06:05 -0400 (EDT)
Date: Thu, 9 May 2024 18:06:02 +0200
From: Janne Grunau <j@jannau.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
	asahi@lists.linux.dev
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Use advertised PHYs on
 hci_le_ext_create_conn_sync
Message-ID: <Zjz0atzRhFykROM9@robin>
References: <20240405204037.3451091-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405204037.3451091-1-luiz.dentz@gmail.com>

Hej,

On Fri, Apr 05, 2024 at 04:40:33PM -0400, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The extended advertising reports do report the PHYs so this store then
> in hci_conn so it can be later used in hci_le_ext_create_conn_sync to
> narrow the PHYs to be scanned since the controller will also perform a
> scan having a smaller set of PHYs shall reduce the time it takes to
> find and connect peers.
> 
> Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")

This commit in v6.8.9 apparently has regressed connecting to LE devices
like Logitech mices with Apple/Broadcom BCM4388 devices. Those devices
carry HCI_QUIRK_BROKEN_LE_CODED which became necessary after 288c90224eec
("Bluetooth: Enable all supported LE PHY by default").
Tested so far only by reverting aaf06285498861d6caaff5b26d30af70dd2b819f
on top of v6.8.9. Looking at the change I don't see anything obvious
which would explain the breakage.
I would assume v6.9-rc6 is affected as well but I haven't tested this
yet.

If you have an idea what could be responsible for the regression I'll
happily test patches/changes.

thanks,
Janne

#regzbot introduced: v6.8.9

> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |  4 +++-
>  net/bluetooth/hci_conn.c         |  6 ++++--
>  net/bluetooth/hci_event.c        | 20 ++++++++++++--------
>  net/bluetooth/hci_sync.c         |  9 ++++++---
>  net/bluetooth/l2cap_core.c       |  2 +-
>  5 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index fd6fd4029452..f0e1f1ae39c5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -744,6 +744,8 @@ struct hci_conn {
>  	__u8		le_per_adv_data[HCI_MAX_PER_AD_TOT_LEN];
>  	__u16		le_per_adv_data_len;
>  	__u16		le_per_adv_data_offset;
> +	__u8		le_adv_phy;
> +	__u8		le_adv_sec_phy;
>  	__u8		le_tx_phy;
>  	__u8		le_rx_phy;
>  	__s8		rssi;
> @@ -1519,7 +1521,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
>  				     enum conn_reasons conn_reason);
>  struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>  				u8 dst_type, bool dst_resolved, u8 sec_level,
> -				u16 conn_timeout, u8 role);
> +				u16 conn_timeout, u8 role, u8 phy, u8 sec_phy);
>  void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status);
>  struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
>  				 u8 sec_level, u8 auth_type,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index ce94ffaf06d4..a3b226255eb9 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1266,7 +1266,7 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
>  
>  struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>  				u8 dst_type, bool dst_resolved, u8 sec_level,
> -				u16 conn_timeout, u8 role)
> +				u16 conn_timeout, u8 role, u8 phy, u8 sec_phy)
>  {
>  	struct hci_conn *conn;
>  	struct smp_irk *irk;
> @@ -1329,6 +1329,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>  	conn->dst_type = dst_type;
>  	conn->sec_level = BT_SECURITY_LOW;
>  	conn->conn_timeout = conn_timeout;
> +	conn->le_adv_phy = phy;
> +	conn->le_adv_sec_phy = sec_phy;
>  
>  	err = hci_connect_le_sync(hdev, conn);
>  	if (err) {
> @@ -2276,7 +2278,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
>  		le = hci_connect_le(hdev, dst, dst_type, false,
>  				    BT_SECURITY_LOW,
>  				    HCI_LE_CONN_TIMEOUT,
> -				    HCI_ROLE_SLAVE);
> +				    HCI_ROLE_SLAVE, 0, 0);
>  	else
>  		le = hci_connect_le_scan(hdev, dst, dst_type,
>  					 BT_SECURITY_LOW,
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 868ffccff773..539bbbe26176 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6046,7 +6046,7 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev, void *data,
>  static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
>  					      bdaddr_t *addr,
>  					      u8 addr_type, bool addr_resolved,
> -					      u8 adv_type)
> +					      u8 adv_type, u8 phy, u8 sec_phy)
>  {
>  	struct hci_conn *conn;
>  	struct hci_conn_params *params;
> @@ -6101,7 +6101,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
>  
>  	conn = hci_connect_le(hdev, addr, addr_type, addr_resolved,
>  			      BT_SECURITY_LOW, hdev->def_le_autoconnect_timeout,
> -			      HCI_ROLE_MASTER);
> +			      HCI_ROLE_MASTER, phy, sec_phy);
>  	if (!IS_ERR(conn)) {
>  		/* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owned
>  		 * by higher layer that tried to connect, if no then
> @@ -6136,8 +6136,9 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
>  
>  static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
>  			       u8 bdaddr_type, bdaddr_t *direct_addr,
> -			       u8 direct_addr_type, s8 rssi, u8 *data, u8 len,
> -			       bool ext_adv, bool ctl_time, u64 instant)
> +			       u8 direct_addr_type, u8 phy, u8 sec_phy, s8 rssi,
> +			       u8 *data, u8 len, bool ext_adv, bool ctl_time,
> +			       u64 instant)
>  {
>  	struct discovery_state *d = &hdev->discovery;
>  	struct smp_irk *irk;
> @@ -6225,7 +6226,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
>  	 * for advertising reports) and is already verified to be RPA above.
>  	 */
>  	conn = check_pending_le_conn(hdev, bdaddr, bdaddr_type, bdaddr_resolved,
> -				     type);
> +				     type, phy, sec_phy);
>  	if (!ext_adv && conn && type == LE_ADV_IND &&
>  	    len <= max_adv_len(hdev)) {
>  		/* Store report for later inclusion by
> @@ -6371,7 +6372,8 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
>  		if (info->length <= max_adv_len(hdev)) {
>  			rssi = info->data[info->length];
>  			process_adv_report(hdev, info->type, &info->bdaddr,
> -					   info->bdaddr_type, NULL, 0, rssi,
> +					   info->bdaddr_type, NULL, 0,
> +					   HCI_ADV_PHY_1M, 0, rssi,
>  					   info->data, info->length, false,
>  					   false, instant);
>  		} else {
> @@ -6456,6 +6458,8 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
>  		if (legacy_evt_type != LE_ADV_INVALID) {
>  			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
>  					   info->bdaddr_type, NULL, 0,
> +					   info->primary_phy,
> +					   info->secondary_phy,
>  					   info->rssi, info->data, info->length,
>  					   !(evt_type & LE_EXT_ADV_LEGACY_PDU),
>  					   false, instant);
> @@ -6761,8 +6765,8 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
>  
>  		process_adv_report(hdev, info->type, &info->bdaddr,
>  				   info->bdaddr_type, &info->direct_addr,
> -				   info->direct_addr_type, info->rssi, NULL, 0,
> -				   false, false, instant);
> +				   info->direct_addr_type, HCI_ADV_PHY_1M, 0,
> +				   info->rssi, NULL, 0, false, false, instant);
>  	}
>  
>  	hci_dev_unlock(hdev);
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c5d8799046cc..4c707eb64e6f 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6346,7 +6346,8 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
>  
>  	plen = sizeof(*cp);
>  
> -	if (scan_1m(hdev)) {
> +	if (scan_1m(hdev) && (conn->le_adv_phy == HCI_ADV_PHY_1M ||
> +			      conn->le_adv_sec_phy == HCI_ADV_PHY_1M)) {
>  		cp->phys |= LE_SCAN_PHY_1M;
>  		set_ext_conn_params(conn, p);
>  
> @@ -6354,7 +6355,8 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
>  		plen += sizeof(*p);
>  	}
>  
> -	if (scan_2m(hdev)) {
> +	if (scan_2m(hdev) && (conn->le_adv_phy == HCI_ADV_PHY_2M ||
> +			      conn->le_adv_sec_phy == HCI_ADV_PHY_2M)) {
>  		cp->phys |= LE_SCAN_PHY_2M;
>  		set_ext_conn_params(conn, p);
>  
> @@ -6362,7 +6364,8 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
>  		plen += sizeof(*p);
>  	}
>  
> -	if (scan_coded(hdev)) {
> +	if (scan_coded(hdev) && (conn->le_adv_phy == HCI_ADV_PHY_CODED ||
> +				 conn->le_adv_sec_phy == HCI_ADV_PHY_CODED)) {
>  		cp->phys |= LE_SCAN_PHY_CODED;
>  		set_ext_conn_params(conn, p);
>  
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index cf3b8e9b7b3b..3e5d2d8a2a66 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -7028,7 +7028,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
>  		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
>  			hcon = hci_connect_le(hdev, dst, dst_type, false,
>  					      chan->sec_level, timeout,
> -					      HCI_ROLE_SLAVE);
> +					      HCI_ROLE_SLAVE, 0, 0);
>  		else
>  			hcon = hci_connect_le_scan(hdev, dst, dst_type,
>  						   chan->sec_level, timeout,
> -- 
> 2.44.0
> 
