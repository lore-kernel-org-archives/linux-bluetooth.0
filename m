Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43093D47AA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405014; cv=none; b=dZ8/EU/y7gELS1Buc9u/CJT2oUsNDX2HhLG7c2FTuZBxWQB6KAXVlW3Cji70WXP04PMc4N1GUhCa7LbwP3kluYALMgHYwOXJoLLHSXdXBSdQBnjlY4ibIN8hYZvLz/iBpyHwuz3qG+g2tpp48yutkNhYadpZpHUeNkSeIcq7Nvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405014; c=relaxed/simple;
	bh=bwb4FlRpxOxWw2QhgW+xkq1jkc1aJ2NN8n2FsCq6QE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8oL3bmofos8/H8VI3SPTlMtY7mPSm2JtvecXpcDRVgJDlslVeOgNt7cMju2I83s7dMtxmjPiLQWSK3vDPw7SBWnORoR8HhdEViOCFjI4EXKTX1sut7B8MVXfldn4wFZ5FVBXqa7/1BdPuPzhKjedynPb+19igzixcEuDry0nz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=FzF4JK7+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6KIjSZb; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="FzF4JK7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6KIjSZb"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2BAFD7A00D0;
	Tue,  2 Jun 2026 08:56:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 02 Jun 2026 08:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780405012; x=
	1780491412; bh=IUBkcdCU+mFmlcvxUzmRBdVw73410RZ0dEPhLmFfg0M=; b=F
	zF4JK7+Jcv5pdoEjwd1co6sumODaNiXBVXG8+tYbFTBy3JpyWTuRbhgQfIHAp5Bx
	y5zb3vF5eC9k67Xx7FIC8oFflMMjnGVkuv2dvtYGSc0e+catyntDD0fnW0I53gIE
	ZJkykInC0Dwaldt2tfA78j8AZCmVtdqqOhp4yVm21Qf2J2EGFDv2FSb8x2Ie2deS
	zFU5Sn794wLioErkBaTNw0wLpVY7fDGqzp3riYyFoyYMxOKKqGuE7xeuKUhDRy6L
	DfInLE7NY2breaE8x485nbIb1cUqnCcdmAe4TUNxqfIVPb7H9F83BgTSxktYfKUw
	/vACpy2uMXH70GS8pHPhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780405012; x=1780491412; bh=I
	UBkcdCU+mFmlcvxUzmRBdVw73410RZ0dEPhLmFfg0M=; b=K6KIjSZbGwfmqsEIY
	E65iWeCoXgJDVluKEbWLI8naBLQ3gGscYXnA5vOJJTPcJ1El+x3yg8JLmOsw/gJl
	30D+uenhkyUf2fb8tdYdpUCtcnnnLOyueg/fw11WfMDwDPrxYTJndEZvjJdC2yZG
	tMod7btSG5f/sckydL9lYPp/2zvIjT3E9k7nMaNMJ3da+55j6TDIPi0GM+aEA66r
	sBvm6cxmI1y+YXNFvOf/om/omFVaR0xDghOpgnhBRDu8jNwozN69hcxZeqgbOFCC
	I7pSxrBzcxL9yIy3qqhF9oRhNbya8XwvaWXemT8ofCynQ2ySEUL7/ZOUzXP3DaFH
	39vxw==
X-ME-Sender: <xms:E9Mear8quioi8B52KUr1dwiHvp02SYCJdKqSiHCwAoDFrtcJrbjidw>
    <xme:E9MeauuN7uB7PuQsCLUGAMT-y1xy3uiJ1O5B9K5OdNXDB1n-XnvhRlNGcutFmLBg9
    _gKBvbqBEKsDRS2BUvNlwgzRPM-usIL2-YkLkVG3QhqYx5kvdIMNvo>
X-ME-Received: <xmr:E9MeauCcoSWbaQNnpOG61pM2Xu8L-TsCt2khHLz_1ZQLWGSqdtyfUqBLc_UU1u96E5PW1ao>
X-ME-Proxy-Cause: dmFkZTF/OPXQPKjIQxSNCKPX/5sjWVFy+O/8wAWhDQLxEVCJUWvPIXwwbwFWeKYOFXIvFC
    6DF5Su/WhW84m7aVDogI/1P4qr7rJCavq6X6+TNXyKdct80sdMK9Bp+xCcZ7FOr5unTcwF
    Iu6L8PAr7ASB8/WOuhQ+6NBGaV8h6/6SWECn/2UiYTb70n+YNRblv6Ap8U4ZTDXBkezzQv
    bUOKda27mdopeMjWGtfdsnhO2s4cm/T7ogos/6h/xV/xF/LOmr9i6sWqjNQXVuyYU+/Dc/
    oNTWcqY7Oe7yEitjxbjUQA0CaUAfqjUrq2+tdn1v/YDw7SI3JTL9dBGMsj2ZHZUY38nwDt
    dTuqvCLXk2JzIkmL7v9zD1UdpxzJUjZhcoybK7a0AQmAh2Rrdi2RDBaQS21h1VZnkkc9rm
    UpyzXmtVm5xjwgL72h3TSsrn/jcuU8Rnqz7Yju1byAIrx6WLIW2Upr5PyljtQKcNjt7ImS
    sqtTDURd+gTAWxkNJMFqOLrQh2ZoyHCG2xx65lzGAFU8BWKf8K8yanDeD8zG3JbxXsODZm
    8fY91plbP4rHEzwvNsYSRwhZigz7Bl0Ve5IsrmmEohx+3NRSJ9b6wq72CuqLwM1oFyb8ZS
    UvQK82H9jN0r9fAJVK1ebLmIJLrhPsCFoYOMMnDjEvqvE0o38fZoACC8Hckg
X-ME-Proxy: <xmx:E9MeamUZYfDACESVgmDE1jTfUaVHRc8eOyHkw1IRUOULMbfoYP2EdA>
    <xmx:E9MeasDDhUIydfUnFi26Ky6lIFl-WkZgxeBQDMzpMAbJ5iIRRh7j5Q>
    <xmx:E9Meap8macSF0ZIufTNTFTdmMTpISUNNfhTNPL-X_lhitnxSU6foUA>
    <xmx:E9MeajFf9x1YCsP15Qz44u0GWUuqwUf0SXq_rburxh0OmcfC7eA-vQ>
    <xmx:FNMeahzuRqHneQbsGKmGCEUfpczWwnxRvt9_HDPeIHhXgk8d68I_hEGM>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 08:56:51 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v8 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Tue,  2 Jun 2026 08:55:43 -0400
Message-ID: <20260602125618.2520506-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602125618.2520506-1-oss@fourdim.xyz>
References: <20260602125618.2520506-1-oss@fourdim.xyz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
release_sock(parent). Once the parent lock is released, the child
socket sk can be freed by another task.

Allocate the channel outside the func to prevent this.

Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2cap_core.c")
Cc: stable@kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 include/net/bluetooth/l2cap.h |  8 ++--
 net/bluetooth/6lowpan.c       | 32 +++++++++------
 net/bluetooth/l2cap_core.c    | 60 ++++++++++++++++++++-------
 net/bluetooth/l2cap_sock.c    | 76 ++++++++++++++++++++++-------------
 net/bluetooth/smp.c           | 18 ++++-----
 5 files changed, 126 insertions(+), 68 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e0a1f2293679..ffd006187324 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -620,7 +620,8 @@ struct l2cap_chan {
 struct l2cap_ops {
 	char			*name;
 
-	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
+	int			(*new_connection)(struct l2cap_chan *chan,
+						  struct l2cap_chan *new_chan);
 	int			(*recv) (struct l2cap_chan * chan,
 					 struct sk_buff *skb);
 	void			(*teardown) (struct l2cap_chan *chan, int err);
@@ -884,9 +885,10 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
 	return (seq + 1) % (chan->tx_win_max + 1);
 }
 
-static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2cap_chan *chan)
+static inline int l2cap_chan_no_new_connection(struct l2cap_chan *chan,
+					       struct l2cap_chan *new_chan)
 {
-	return NULL;
+	return -EOPNOTSUPP;
 }
 
 static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct sk_buff *skb)
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cb1e329d66fd..40f118168015 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_conn *hcon)
 	return true;
 }
 
+static void chan_init(struct l2cap_chan *chan)
+{
+	l2cap_chan_set_defaults(chan);
+
+	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
+	chan->mode = L2CAP_MODE_LE_FLOWCTL;
+	chan->imtu = 1280;
+}
+
 static struct l2cap_chan *chan_create(void)
 {
 	struct l2cap_chan *chan;
@@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(void)
 	if (!chan)
 		return NULL;
 
-	l2cap_chan_set_defaults(chan);
-
-	chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
-	chan->mode = L2CAP_MODE_LE_FLOWCTL;
-	chan->imtu = 1280;
+	chan_init(chan);
 
 	return chan;
 }
@@ -745,19 +750,20 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
 	ifup(dev->netdev);
 }
 
-static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
+static inline int chan_new_conn_cb(struct l2cap_chan *pchan,
+				   struct l2cap_chan *chan)
 {
-	struct l2cap_chan *chan;
-
-	chan = chan_create();
-	if (!chan)
-		return NULL;
-
+	chan_init(chan);
 	chan->ops = pchan->ops;
 
+	/* Take a reference to match the put in chan_close_cb(). The caller
+	 * drops its own local reference after __l2cap_chan_add().
+	 */
+	l2cap_chan_hold(chan);
+
 	BT_DBG("chan %p pchan %p", chan, pchan);
 
-	return chan;
+	return 0;
 }
 
 static void unregister_dev(struct lowpan_btle_dev *dev)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4ccfbda9d78..31fb715fd830 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4007,6 +4007,36 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
 	return 0;
 }
 
+/* Allocate and initialise a channel for an incoming connection. The returned
+ * channel carries the caller's local reference, which must be dropped once
+ * __l2cap_chan_add() has pinned it via the conn list.
+ */
+static struct l2cap_chan *l2cap_new_connection(struct l2cap_chan *pchan)
+{
+	struct l2cap_chan *chan;
+
+	chan = l2cap_chan_create();
+	if (!chan)
+		return NULL;
+
+	if (pchan->ops->new_connection(pchan, chan) < 0) {
+		l2cap_chan_put(chan);
+		return NULL;
+	}
+
+	return chan;
+}
+
+/* Link a channel from l2cap_new_connection() into conn and release the local
+ * reference it carried. __l2cap_chan_add() pins the channel via the conn list,
+ * so it remains valid after this returns.
+ */
+static void l2cap_chan_add_new(struct l2cap_conn *conn, struct l2cap_chan *chan)
+{
+	__l2cap_chan_add(conn, chan);
+	l2cap_chan_put(chan);
+}
+
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 			  u8 *data, u8 rsp_code)
 {
@@ -4053,7 +4083,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		goto response;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(pchan);
 	if (!chan)
 		goto response;
 
@@ -4071,7 +4101,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	chan->psm  = psm;
 	chan->dcid = scid;
 
-	__l2cap_chan_add(conn, chan);
+	l2cap_chan_add_new(conn, chan);
 
 	dcid = chan->scid;
 
@@ -4883,6 +4913,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	struct l2cap_le_conn_rsp rsp;
 	struct l2cap_chan *chan, *pchan;
 	u16 dcid, scid, credits, mtu, mps;
+	u16 rsp_mtu, rsp_mps;
 	__le16 psm;
 	u8 result;
 
@@ -4895,6 +4926,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	psm  = req->psm;
 	dcid = 0;
 	credits = 0;
+	rsp_mtu = 0;
+	rsp_mps = 0;
 
 	if (mtu < 23 || mps < 23)
 		return -EPROTO;
@@ -4955,7 +4988,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
-	chan = pchan->ops->new_connection(pchan);
+	chan = l2cap_new_connection(pchan);
 	if (!chan) {
 		result = L2CAP_CR_LE_NO_MEM;
 		goto response_unlock;
@@ -4970,12 +5003,14 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	chan->omtu = mtu;
 	chan->remote_mps = mps;
 
-	__l2cap_chan_add(conn, chan);
+	l2cap_chan_add_new(conn, chan);
 
 	l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
 
 	dcid = chan->scid;
 	credits = chan->rx_credits;
+	rsp_mtu = chan->imtu;
+	rsp_mps = chan->mps;
 
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
@@ -5003,13 +5038,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		return 0;
 
 response:
-	if (chan) {
-		rsp.mtu = cpu_to_le16(chan->imtu);
-		rsp.mps = cpu_to_le16(chan->mps);
-	} else {
-		rsp.mtu = 0;
-		rsp.mps = 0;
-	}
+	rsp.mtu = cpu_to_le16(rsp_mtu);
+	rsp.mps = cpu_to_le16(rsp_mps);
 
 	rsp.dcid    = cpu_to_le16(dcid);
 	rsp.credits = cpu_to_le16(credits);
@@ -5179,7 +5209,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			continue;
 		}
 
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(pchan);
 		if (!chan) {
 			result = L2CAP_CR_LE_NO_MEM;
 			continue;
@@ -5194,7 +5224,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		chan->omtu = mtu;
 		chan->remote_mps = mps;
 
-		__l2cap_chan_add(conn, chan);
+		l2cap_chan_add_new(conn, chan);
 
 		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
 
@@ -7470,14 +7500,14 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 			goto next;
 
 		l2cap_chan_lock(pchan);
-		chan = pchan->ops->new_connection(pchan);
+		chan = l2cap_new_connection(pchan);
 		if (chan) {
 			bacpy(&chan->src, &hcon->src);
 			bacpy(&chan->dst, &hcon->dst);
 			chan->src_type = bdaddr_src_type(hcon);
 			chan->dst_type = dst_type;
 
-			__l2cap_chan_add(conn, chan);
+			l2cap_chan_add_new(conn, chan);
 		}
 
 		l2cap_chan_unlock(pchan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 025329636353..745b012890ee 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list = {
 static const struct proto_ops l2cap_sock_ops;
 static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern);
+				     int proto, gfp_t prio, int kern,
+				     struct l2cap_chan *chan);
 static void l2cap_sock_cleanup_listen(struct sock *parent);
 
 bool l2cap_is_socket(struct socket *sock)
@@ -1292,18 +1293,25 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
  */
 static void l2cap_sock_kill(struct sock *sk)
 {
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
 	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
 		return;
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
-	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
-	 * sock pointer.
+	/* Release the sock's ref on chan and clear the pointer so that
+	 * l2cap_sock_destruct() does not drop it a second time. Setting
+	 * chan->data to NULL first stops any other task from dereferencing
+	 * the now-dead sock pointer.
 	 */
-	l2cap_pi(sk)->chan->data = NULL;
-	/* Kill poor orphan */
+	if (chan) {
+		chan->data = NULL;
+		l2cap_pi(sk)->chan = NULL;
+		l2cap_chan_put(chan);
+	}
 
-	l2cap_chan_put(l2cap_pi(sk)->chan);
+	/* Kill poor orphan */
 	sock_set_flag(sk, SOCK_DEAD);
 	sock_put(sk);
 }
@@ -1383,7 +1391,9 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	sock_hold(sk);
 
 	/* prevent chan structure from being freed whilst unlocked */
-	chan = l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
+	chan = l2cap_pi(sk)->chan;
+	if (chan)
+		chan = l2cap_chan_hold_unless_zero(chan);
 	if (!chan)
 		goto shutdown_already;
 
@@ -1546,12 +1556,13 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	}
 }
 
-static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
+static int l2cap_sock_new_connection_cb(struct l2cap_chan *chan,
+					struct l2cap_chan *new_chan)
 {
 	struct sock *sk, *parent = chan->data;
 
 	if (!parent)
-		return NULL;
+		return -EINVAL;
 
 	lock_sock(parent);
 
@@ -1559,15 +1570,15 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
 		release_sock(parent);
-		return NULL;
+		return -ENOBUFS;
 	}
 
 	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
-			      GFP_ATOMIC, 0);
+			      GFP_ATOMIC, 0, new_chan);
 	if (!sk) {
 		release_sock(parent);
-		return NULL;
-        }
+		return -ENOMEM;
+	}
 
 	bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
 
@@ -1577,7 +1588,7 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	release_sock(parent);
 
-	return l2cap_pi(sk)->chan;
+	return 0;
 }
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
@@ -1875,8 +1886,11 @@ static void l2cap_sock_destruct(struct sock *sk)
 	BT_DBG("sk %p", sk);
 
 	if (l2cap_pi(sk)->chan) {
-		l2cap_pi(sk)->chan->data = NULL;
-		l2cap_chan_put(l2cap_pi(sk)->chan);
+		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+		chan->data = NULL;
+		l2cap_pi(sk)->chan = NULL;
+		l2cap_chan_put(chan);
 	}
 
 	list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, list) {
@@ -1978,10 +1992,10 @@ static struct proto l2cap_proto = {
 };
 
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
-				     int proto, gfp_t prio, int kern)
+				     int proto, gfp_t prio, int kern,
+				     struct l2cap_chan *chan)
 {
 	struct sock *sk;
-	struct l2cap_chan *chan;
 
 	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
 	if (!sk)
@@ -1992,14 +2006,11 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
 
-	chan = l2cap_chan_create();
-	if (!chan) {
-		sk_free(sk);
-		if (sock)
-			sock->sk = NULL;
-		return NULL;
-	}
-
+	/* The sock owns a single ref on chan. It is released by whichever of
+	 * l2cap_sock_kill() or l2cap_sock_destruct() runs first; that path
+	 * clears l2cap_pi(sk)->chan so the ref is dropped exactly once. The
+	 * caller keeps its own ref independent of this one.
+	 */
 	l2cap_chan_hold(chan);
 
 	l2cap_pi(sk)->chan = chan;
@@ -2011,6 +2022,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 			     int kern)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("sock %p", sock);
 
@@ -2025,9 +2037,17 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &l2cap_sock_ops;
 
-	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
-	if (!sk)
+	chan = l2cap_chan_create();
+	if (!chan)
+		return -ENOMEM;
+
+	sk = l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, chan);
+	if (!sk) {
+		l2cap_chan_put(chan);
 		return -ENOMEM;
+	}
+	/* Sock has taken its own refs on chan; drop the chan_create() ref. */
+	l2cap_chan_put(chan);
 
 	l2cap_sock_init(sk, NULL);
 	bt_sock_link(&l2cap_sk_list, sk);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1739c1989dbd..887a2fc34391 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3204,16 +3204,11 @@ static const struct l2cap_ops smp_chan_ops = {
 	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
 };
 
-static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
+static inline int smp_new_conn_cb(struct l2cap_chan *pchan,
+				  struct l2cap_chan *chan)
 {
-	struct l2cap_chan *chan;
-
 	BT_DBG("pchan %p", pchan);
 
-	chan = l2cap_chan_create();
-	if (!chan)
-		return NULL;
-
 	chan->chan_type	= pchan->chan_type;
 	chan->ops	= &smp_chan_ops;
 	chan->scid	= pchan->scid;
@@ -3229,9 +3224,14 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 	 */
 	atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
 
-	BT_DBG("created chan %p", chan);
+	/* Take a reference to match the put in smp_teardown_cb(). The caller
+	 * drops its own local reference after __l2cap_chan_add().
+	 */
+	l2cap_chan_hold(chan);
 
-	return chan;
+	BT_DBG("initialised chan %p", chan);
+
+	return 0;
 }
 
 static const struct l2cap_ops smp_root_chan_ops = {
-- 
2.54.0

