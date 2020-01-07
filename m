Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A8AC33C99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED3B206DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 07:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+NmgsvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgAGHlE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:41:04 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:54417 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbgAGHlE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 02:41:04 -0500
Received: by mail-pj1-f43.google.com with SMTP id kx11so8654183pjb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 23:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/FtiuNzSNY9DzNrUovYk/r2WBz0N+yP0vYuHJdhYjAc=;
        b=d+NmgsvJYZligzYb2ziQ38QlN7SevbfF+KF7RkQcyBMceGAmelZzoWUrMPwb5urVo7
         zczDlXvbuTOnj0BRjx8C/DDL+f9/Q/IitoWxBdBarYgRM1qgF3sar1E/5ojwkYBpK3wN
         gmd7Z0AJNrr67nMJodNpH6eMbFstCO7x7KBGdmEcscuN4PNIYT7sfIUYiFDAp4Fu+CjU
         2ZOqa0+8EmRBuZo7HaBx/CuOpGR22FzLOxRtYF/hLEcs5SwiL29dEN7Jam3ga0evdcJJ
         kcrXeU+mEN9Tgv/gw52qc++lJ834aoehZOl3zCYcHmSt/CL1my9OQajSVQ0HCO4BcM62
         laDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FtiuNzSNY9DzNrUovYk/r2WBz0N+yP0vYuHJdhYjAc=;
        b=Lf2wy3sJwb8Hod0Rw+yvZGQZiWjYnORXY/217HIlGuWKbEJg+n8qgmBfKwkrxPXECz
         Ysn8HIOjnMOibR/0EVFQoVjqW9aRblB+aKp4Ag31Sj6Lv/cYZlkO4up+Kf4bthueHBdR
         eE7DRBKcqmbuvCEP3ySweaf34b9nrcoPaBDM032cczz861PTT1hIOaFk+dItiDscs31g
         co13n1RSYL1/p5/CwxEWhyiF7uiXSjM0pxNHPV4ATizy7EOObHNemixOsIXHmvLLpb+e
         IrptH2v8a1Gpp2dyxEoQ6XUEXaspGdHLTaut4DVIfoMxpvDhA9ZVJDrbFN41NVMdJ8gx
         Bqfg==
X-Gm-Message-State: APjAAAUqfCEJRvNXSBLX+lk7ZyB4MTPoHbswMrxww77rzs+/ObJvri0c
        wtFKg25Z5Qm+DY8h5qSBLVTuMi9vv5g=
X-Google-Smtp-Source: APXvYqzwFkaEf7j3teqa2HaYinwJjxHMwOpEe4mVBd39p4VUhxmlUNQJbjjkbTvNrE4pa8bv4ZH68Q==
X-Received: by 2002:a17:90a:2467:: with SMTP id h94mr47033239pje.79.1578382862532;
        Mon, 06 Jan 2020 23:41:02 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id k21sm67725388pfa.63.2020.01.06.23.41.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 23:41:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode
Date:   Mon,  6 Jan 2020 23:40:50 -0800
Message-Id: <20200107074056.25453-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200107074056.25453-1-luiz.dentz@gmail.com>
References: <20200107074056.25453-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the initial code for Enhanced Credit Based Mode which
introduces a new socket mode called L2CAP_MODE_ECRED, which for the most
part work the same as L2CAP_MODE_LE_FLOWCTL but uses different PDUs to
setup the connections and also works over BR/EDR.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |   3 +
 net/bluetooth/l2cap_core.c    | 498 +++++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c    |  39 +--
 3 files changed, 508 insertions(+), 32 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5646a40c793c..9da1d9c510e9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -295,6 +295,8 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_LE_ENCRYPTION		0x0008
 #define L2CAP_CR_LE_INVALID_SCID	0x0009
 #define L2CAP_CR_LE_SCID_IN_USE		0X000A
+#define L2CAP_CR_LE_UNACCEPT_PARAMS	0X000B
+#define L2CAP_CR_LE_INVALID_PARAMS	0X000C
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
@@ -977,6 +979,7 @@ struct l2cap_chan *l2cap_chan_create(void);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type);
+int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1bca608e0170..9d7236255745 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -532,6 +532,17 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 	skb_queue_head_init(&chan->tx_q);
 }
 
+static void l2cap_ecred_init(struct l2cap_chan *chan, u16 tx_credits)
+{
+	l2cap_le_flowctl_init(chan, tx_credits);
+
+	/* L2CAP implementations shall support a minimum MPS of 64 octets */
+	if (chan->mps < L2CAP_ECRED_MIN_MPS) {
+		chan->mps = L2CAP_ECRED_MIN_MPS;
+		chan->rx_credits = (chan->imtu / chan->mps) + 1;
+	}
+}
+
 void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
@@ -638,6 +649,7 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		break;
 
 	case L2CAP_MODE_LE_FLOWCTL:
+	case L2CAP_MODE_ECRED:
 		skb_queue_purge(&chan->tx_q);
 		break;
 
@@ -1273,7 +1285,7 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 	chan->conf_state = 0;
 	__clear_chan_timer(chan);
 
-	if (chan->mode == L2CAP_MODE_LE_FLOWCTL && !chan->tx_credits)
+	if (chan->mode & L2CAP_MODE_ECRED_MASK && !chan->tx_credits)
 		chan->ops->suspend(chan);
 
 	chan->state = BT_CONNECTED;
@@ -1306,6 +1318,31 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
 		       sizeof(req), &req);
 }
 
+static void l2cap_ecred_connect(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct {
+		struct l2cap_ecred_conn_req req;
+		__le16 scid;
+	} __packed pdu;
+
+	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
+		return;
+
+	l2cap_ecred_init(chan, 0);
+
+	pdu.req.psm     = chan->psm;
+	pdu.req.mtu     = cpu_to_le16(chan->imtu);
+	pdu.req.mps     = cpu_to_le16(chan->mps);
+	pdu.req.credits = cpu_to_le16(chan->rx_credits);
+	pdu.scid        = cpu_to_le16(chan->scid);
+
+	chan->ident = l2cap_get_ident(conn);
+
+	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_CONN_REQ,
+		       sizeof(pdu), &pdu);
+}
+
 static void l2cap_le_start(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1318,8 +1355,12 @@ static void l2cap_le_start(struct l2cap_chan *chan)
 		return;
 	}
 
-	if (chan->state == BT_CONNECT)
-		l2cap_le_connect(chan);
+	if (chan->state == BT_CONNECT) {
+		if (chan->mode == L2CAP_MODE_ECRED)
+			l2cap_ecred_connect(chan);
+		else
+			l2cap_le_connect(chan);
+	}
 }
 
 static void l2cap_start_connection(struct l2cap_chan *chan)
@@ -2505,6 +2546,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 
 	switch (chan->mode) {
 	case L2CAP_MODE_LE_FLOWCTL:
+	case L2CAP_MODE_ECRED:
 		/* Check outgoing MTU */
 		if (len > chan->omtu)
 			return -EMSGSIZE;
@@ -3773,6 +3815,42 @@ void __l2cap_le_connect_rsp_defer(struct l2cap_chan *chan)
 		       &rsp);
 }
 
+void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
+{
+	struct l2cap_ecred_conn_rsp rsp;
+	struct l2cap_conn *conn = chan->conn;
+	u16 ident = chan->ident;
+	int i = 0;
+
+	if (!ident) {
+		return;
+	}
+
+	BT_DBG("chan %p ident %d", chan, ident);
+
+	rsp.mtu     = cpu_to_le16(chan->imtu);
+	rsp.mps     = cpu_to_le16(chan->mps);
+	rsp.credits = cpu_to_le16(chan->rx_credits);
+	rsp.result  = cpu_to_le16(L2CAP_CR_LE_SUCCESS);
+
+	mutex_lock(&conn->chan_lock);
+
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		if (chan->ident != ident)
+			continue;
+
+		/* Reset ident so only one response is sent */
+		chan->ident = 0;
+
+		/* Include all channels pending with the same ident */
+		rsp.dcid[i++] = cpu_to_le16(chan->scid);
+	}
+
+	mutex_unlock(&conn->chan_lock);
+
+	l2cap_send_cmd(conn, ident, L2CAP_ECRED_CONN_RSP, sizeof(rsp), &rsp);
+}
+
 void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
 {
 	struct l2cap_conn_rsp rsp;
@@ -5715,6 +5793,347 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 	return 0;
 }
 
+static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
+				       struct l2cap_cmd_hdr *cmd, u16 cmd_len,
+				       u8 *data)
+{
+	struct l2cap_ecred_conn_req *req = (void *) data;
+	struct {
+		struct l2cap_ecred_conn_rsp rsp;
+		__le16 dcid[5];
+	} __packed pdu;
+	struct l2cap_chan *chan, *pchan;
+	u16 credits, mtu, mps;
+	__le16 psm;
+	u8 result, len = 0;
+	int i;
+	bool defer = false;
+
+	if (cmd_len < sizeof(*req))
+		return -EPROTO;
+
+	mtu  = __le16_to_cpu(req->mtu);
+	mps  = __le16_to_cpu(req->mps);
+
+	if (mtu < L2CAP_ECRED_MIN_MTU || mps < L2CAP_ECRED_MIN_MPS) {
+		result = L2CAP_CR_LE_UNACCEPT_PARAMS;
+		goto response;
+	}
+
+	psm  = req->psm;
+	credits = 0;
+
+	BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), mtu, mps);
+
+	memset(&pdu, 0, sizeof(pdu));
+
+	/* Check if we have socket listening on psm */
+	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->src,
+					 &conn->hcon->dst, LE_LINK);
+	if (!pchan) {
+		result = L2CAP_CR_LE_BAD_PSM;
+		goto response;
+	}
+
+	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(pchan);
+
+	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
+				     SMP_ALLOW_STK)) {
+		result = L2CAP_CR_LE_AUTHENTICATION;
+		goto unlock;
+	}
+
+	result = L2CAP_CR_LE_SUCCESS;
+
+	for (i = 0, cmd_len -= sizeof(req); cmd_len >= sizeof(u16);
+	     i++, cmd_len -= sizeof(u16)) {
+		u16 scid = __le16_to_cpu(req->scid[i]);
+
+		BT_DBG("scid[%d] 0x%4.4x", i, scid);
+
+		pdu.dcid[i] = 0x0000;
+		len += sizeof(*pdu.dcid);
+
+		/* Check for valid dynamic CID range */
+		if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
+			result = L2CAP_CR_LE_INVALID_SCID;
+			continue;
+		}
+
+		/* Check if we already have channel with that dcid */
+		if (__l2cap_get_chan_by_dcid(conn, scid)) {
+			result = L2CAP_CR_LE_SCID_IN_USE;
+			continue;
+		}
+
+		chan = pchan->ops->new_connection(pchan);
+		if (!chan) {
+			result = L2CAP_CR_LE_NO_MEM;
+			continue;
+		}
+
+		bacpy(&chan->src, &conn->hcon->src);
+		bacpy(&chan->dst, &conn->hcon->dst);
+		chan->src_type = bdaddr_src_type(conn->hcon);
+		chan->dst_type = bdaddr_dst_type(conn->hcon);
+		chan->psm  = psm;
+		chan->dcid = scid;
+		chan->omtu = mtu;
+		chan->remote_mps = mps;
+
+		__l2cap_chan_add(conn, chan);
+
+		l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
+
+		/* Init response */
+		if (!pdu.rsp.credits) {
+			pdu.rsp.mtu = cpu_to_le16(chan->imtu);
+			pdu.rsp.mps = cpu_to_le16(chan->mps);
+			pdu.rsp.credits = cpu_to_le16(chan->rx_credits);
+		}
+
+		pdu.dcid[i] = cpu_to_le16(chan->scid);
+
+		__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
+
+		chan->ident = cmd->ident;
+
+		if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
+			l2cap_state_change(chan, BT_CONNECT2);
+			defer = true;
+			chan->ops->defer(chan);
+		} else {
+			l2cap_chan_ready(chan);
+		}
+	}
+
+unlock:
+	l2cap_chan_unlock(pchan);
+	mutex_unlock(&conn->chan_lock);
+	l2cap_chan_put(pchan);
+
+response:
+	pdu.rsp.result = cpu_to_le16(result);
+
+	if (defer)
+		return 0;
+
+	l2cap_send_cmd(conn, cmd->ident, L2CAP_ECRED_CONN_RSP,
+		       sizeof(pdu.rsp) + len, &pdu);
+
+	return 0;
+}
+
+static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
+				       struct l2cap_cmd_hdr *cmd, u16 cmd_len,
+				       u8 *data)
+{
+	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
+	struct hci_conn *hcon = conn->hcon;
+	u16 mtu, mps, credits, result;
+	struct l2cap_chan *chan;
+	int err = 0, sec_level;
+	int i = 0;
+
+	if (cmd_len < sizeof(*rsp))
+		return -EPROTO;
+
+	mtu     = __le16_to_cpu(rsp->mtu);
+	mps     = __le16_to_cpu(rsp->mps);
+	credits = __le16_to_cpu(rsp->credits);
+	result  = __le16_to_cpu(rsp->result);
+
+	BT_DBG("mtu %u mps %u credits %u result 0x%4.4x", mtu, mps, credits,
+	       result);
+
+	mutex_lock(&conn->chan_lock);
+
+	cmd_len -= sizeof(*rsp);
+
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		u16 dcid;
+
+		if (chan->ident != cmd->ident ||
+		    chan->mode != L2CAP_MODE_ECRED ||
+		    chan->state == BT_CONNECTED)
+			continue;
+
+		l2cap_chan_lock(chan);
+
+		/* Check that there is a dcid for each pending channel */
+		if (cmd_len < sizeof(dcid)) {
+			l2cap_chan_del(chan, ECONNREFUSED);
+			l2cap_chan_unlock(chan);
+			continue;
+		}
+
+		dcid = __le16_to_cpu(rsp->dcid[i++]);
+		cmd_len -= sizeof(u16);
+
+		BT_DBG("dcid[%d] 0x%4.4x", i, dcid);
+
+		/* Check if dcid is already in use */
+		if (dcid && __l2cap_get_chan_by_dcid(conn, dcid)) {
+			/* If a device receives a
+			 * L2CAP_CREDIT_BASED_CONNECTION_RSP packet with an
+			 * already-assigned Destination CID, then both the
+			 * original channel and the new channel shall be
+			 * immediately discarded and not used.
+			 */
+			l2cap_chan_del(chan, ECONNREFUSED);
+			l2cap_chan_unlock(chan);
+			chan = __l2cap_get_chan_by_dcid(conn, dcid);
+			l2cap_chan_lock(chan);
+			l2cap_chan_del(chan, ECONNRESET);
+			l2cap_chan_unlock(chan);
+			continue;
+		}
+
+		switch (result) {
+		case L2CAP_CR_LE_AUTHENTICATION:
+		case L2CAP_CR_LE_ENCRYPTION:
+			/* If we already have MITM protection we can't do
+			 * anything.
+			 */
+			if (hcon->sec_level > BT_SECURITY_MEDIUM) {
+				l2cap_chan_del(chan, ECONNREFUSED);
+				break;
+			}
+
+			sec_level = hcon->sec_level + 1;
+			if (chan->sec_level < sec_level)
+				chan->sec_level = sec_level;
+
+			/* We'll need to send a new Connect Request */
+			clear_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags);
+
+			smp_conn_security(hcon, chan->sec_level);
+			break;
+
+		case L2CAP_CR_LE_BAD_PSM:
+			l2cap_chan_del(chan, ECONNREFUSED);
+			break;
+
+		default:
+			/* If dcid was not set it means channels was refused */
+			if (!dcid) {
+				l2cap_chan_del(chan, ECONNREFUSED);
+				break;
+			}
+
+			chan->ident = 0;
+			chan->dcid = dcid;
+			chan->omtu = mtu;
+			chan->remote_mps = mps;
+			chan->tx_credits = credits;
+			l2cap_chan_ready(chan);
+			break;
+		}
+
+		l2cap_chan_unlock(chan);
+	}
+
+	mutex_unlock(&conn->chan_lock);
+
+	return err;
+}
+
+static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
+					 struct l2cap_cmd_hdr *cmd, u16 cmd_len,
+					 u8 *data)
+{
+	struct l2cap_ecred_reconf_req *req = (void *) data;
+	struct l2cap_ecred_reconf_rsp rsp;
+	u16 mtu, mps, result;
+	struct l2cap_chan *chan;
+	int i;
+
+	if (cmd_len < sizeof(*req)) {
+		result = L2CAP_CR_LE_INVALID_PARAMS;
+		goto respond;
+	}
+
+	mtu = __le16_to_cpu(req->mtu);
+	mps = __le16_to_cpu(req->mps);
+
+	BT_DBG("mtu %u mps %u", mtu, mps);
+
+	if (mtu < L2CAP_ECRED_MIN_MTU) {
+		result = L2CAP_RECONF_INVALID_MTU;
+		goto respond;
+	}
+
+	if (mps < L2CAP_ECRED_MIN_MPS) {
+		result = L2CAP_RECONF_INVALID_MPS;
+		goto respond;
+	}
+
+	result = L2CAP_RECONF_SUCCESS;
+
+	for (i = 0, cmd_len -= sizeof(*req); cmd_len < sizeof(u16);
+	     i++, cmd_len -= sizeof(u16)) {
+		u16 scid;
+
+		scid = __le16_to_cpu(req->scid[i]);
+		if (!scid)
+			return -EPROTO;
+
+		chan = __l2cap_get_chan_by_dcid(conn, scid);
+		if (!chan)
+			continue;
+
+		/* If the MTU value is decreased for any of the included
+		 * channels, then the receiver shall disconnect all
+		 * included channels.
+		 */
+		if (chan->omtu > mtu) {
+			BT_ERR("chan %p decreased MTU %u -> %u", chan,
+			       chan->omtu, mtu);
+			result = L2CAP_RECONF_INVALID_MTU;
+		}
+
+		chan->omtu = mtu;
+		chan->remote_mps = mps;
+	}
+
+respond:
+	rsp.result = cpu_to_le16(result);
+
+	l2cap_send_cmd(conn, cmd->ident, L2CAP_ECRED_RECONF_RSP, sizeof(rsp),
+		       &rsp);
+
+	return 0;
+}
+
+static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
+					 struct l2cap_cmd_hdr *cmd, u16 cmd_len,
+					 u8 *data)
+{
+	struct l2cap_chan *chan;
+	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
+	u16 result;
+
+	if (cmd_len < sizeof(*rsp))
+		return -EPROTO;
+
+	result = __le16_to_cpu(rsp->result);
+
+	BT_DBG("result 0x%4.4x", rsp->result);
+
+	if (!result)
+		return 0;
+
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		if (chan->ident != cmd->ident)
+			continue;
+
+		l2cap_chan_del(chan, ECONNRESET);
+	}
+
+	return 0;
+}
+
 static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 				       struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				       u8 *data)
@@ -5770,6 +6189,22 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 		err = l2cap_le_credits(conn, cmd, cmd_len, data);
 		break;
 
+	case L2CAP_ECRED_CONN_REQ:
+		err = l2cap_ecred_conn_req(conn, cmd, cmd_len, data);
+		break;
+
+	case L2CAP_ECRED_CONN_RSP:
+		err = l2cap_ecred_conn_rsp(conn, cmd, cmd_len, data);
+		break;
+
+	case L2CAP_ECRED_RECONF_REQ:
+		err = l2cap_ecred_reconf_req(conn, cmd, cmd_len, data);
+		break;
+
+	case L2CAP_ECRED_RECONF_RSP:
+		err = l2cap_ecred_reconf_rsp(conn, cmd, cmd_len, data);
+		break;
+
 	case L2CAP_DISCONN_REQ:
 		err = l2cap_disconnect_req(conn, cmd, cmd_len, data);
 		break;
@@ -6815,11 +7250,13 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	struct l2cap_le_credits pkt;
 	u16 return_credits;
 
-	return_credits = ((chan->imtu / chan->mps) + 1) - chan->rx_credits;
+	return_credits = (chan->imtu / chan->mps) + 1;
 
-	if (!return_credits)
+	if (chan->rx_credits >= return_credits)
 		return;
 
+	return_credits -= chan->rx_credits;
+
 	BT_DBG("chan %p returning %u credits to sender", chan, return_credits);
 
 	chan->rx_credits += return_credits;
@@ -6832,7 +7269,7 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
 }
 
-static int l2cap_le_recv(struct l2cap_chan *chan, struct sk_buff *skb)
+static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
 
@@ -6847,7 +7284,7 @@ static int l2cap_le_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 	return err;
 }
 
-static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
+static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
 
@@ -6895,7 +7332,7 @@ static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		}
 
 		if (skb->len == sdu_len)
-			return l2cap_le_recv(chan, skb);
+			return l2cap_ecred_recv(chan, skb);
 
 		chan->sdu = skb;
 		chan->sdu_len = sdu_len;
@@ -6927,7 +7364,7 @@ static int l2cap_le_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 	skb = NULL;
 
 	if (chan->sdu->len == chan->sdu_len) {
-		err = l2cap_le_recv(chan, chan->sdu);
+		err = l2cap_ecred_recv(chan, chan->sdu);
 		if (!err) {
 			chan->sdu = NULL;
 			chan->sdu_last_frag = NULL;
@@ -6988,7 +7425,8 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
 
 	switch (chan->mode) {
 	case L2CAP_MODE_LE_FLOWCTL:
-		if (l2cap_le_data_rcv(chan, skb) < 0)
+	case L2CAP_MODE_ECRED:
+		if (l2cap_ecred_data_rcv(chan, skb) < 0)
 			goto drop;
 
 		goto done;
@@ -7215,8 +7653,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	struct hci_dev *hdev;
 	int err;
 
-	BT_DBG("%pMR -> %pMR (type %u) psm 0x%2.2x", &chan->src, dst,
-	       dst_type, __le16_to_cpu(psm));
+	BT_DBG("%pMR -> %pMR (type %u) psm 0x%4.4x mode 0x%2.2x", &chan->src,
+	       dst, dst_type, __le16_to_cpu(psm), chan->mode);
 
 	hdev = hci_get_route(dst, &chan->src, chan->src_type);
 	if (!hdev)
@@ -7245,6 +7683,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		break;
 	case L2CAP_MODE_LE_FLOWCTL:
 		break;
+	case L2CAP_MODE_ECRED:
+		break;
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
 		if (!disable_ertm)
@@ -7369,6 +7809,38 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_connect);
 
+static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct {
+		struct l2cap_ecred_reconf_req req;
+		__le16 scid;
+	} pdu;
+
+	pdu.req.mtu = cpu_to_le16(chan->imtu);
+	pdu.req.mps = cpu_to_le16(chan->mps);
+	pdu.scid    = cpu_to_le16(chan->scid);
+
+	chan->ident = l2cap_get_ident(conn);
+
+	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
+		       sizeof(pdu), &pdu);
+}
+
+int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu)
+{
+	if (chan->imtu > mtu)
+		return -EINVAL;
+
+	BT_DBG("chan %p mtu 0x%4.4x", chan, mtu);
+
+	chan->imtu = mtu;
+
+	l2cap_ecred_reconfigure(chan);
+
+	return 0;
+}
+
 /* ---- L2CAP interface with lower layer (HCI) ---- */
 
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
@@ -7580,7 +8052,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			else
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 		} else if (chan->state == BT_CONNECT2 &&
-			   chan->mode != L2CAP_MODE_LE_FLOWCTL) {
+			   !(chan->mode & L2CAP_MODE_ECRED_MASK)) {
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a7be8b59b3c2..adb323d17a64 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -232,7 +232,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 			return -EINVAL;
 	}
 
-	if (chan->psm && bdaddr_type_is_le(chan->src_type))
+	if (chan->psm && bdaddr_type_is_le(chan->src_type) && !chan->mode)
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
@@ -273,6 +273,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 	case L2CAP_MODE_LE_FLOWCTL:
+	case L2CAP_MODE_ECRED:
 		break;
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
@@ -408,16 +409,6 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case L2CAP_OPTIONS:
-		/* LE sockets should use BT_SNDMTU/BT_RCVMTU, but since
-		 * legacy ATT code depends on getsockopt for
-		 * L2CAP_OPTIONS we need to let this pass.
-		 */
-		if (bdaddr_type_is_le(chan->src_type) &&
-		    chan->scid != L2CAP_CID_ATT) {
-			err = -EINVAL;
-			break;
-		}
-
 		memset(&opts, 0, sizeof(opts));
 		opts.imtu     = chan->imtu;
 		opts.omtu     = chan->omtu;
@@ -427,6 +418,8 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 		opts.max_tx   = chan->max_tx;
 		opts.txwin_size = chan->tx_win;
 
+		BT_DBG("mode 0x%2.2x", chan->mode);
+
 		len = min_t(unsigned int, len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
 			err = -EFAULT;
@@ -643,11 +636,6 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case L2CAP_OPTIONS:
-		if (bdaddr_type_is_le(chan->src_type)) {
-			err = -EINVAL;
-			break;
-		}
-
 		if (sk->sk_state == BT_CONNECTED) {
 			err = -EINVAL;
 			break;
@@ -680,6 +668,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		chan->mode = opts.mode;
 		switch (chan->mode) {
 		case L2CAP_MODE_LE_FLOWCTL:
+		case L2CAP_MODE_ECRED:
 			break;
 		case L2CAP_MODE_BASIC:
 			clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
@@ -694,6 +683,8 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		BT_DBG("mode 0x%2.2x", chan->mode);
+
 		chan->imtu = opts.imtu;
 		chan->omtu = opts.omtu;
 		chan->fcs  = opts.fcs;
@@ -926,7 +917,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (sk->sk_state == BT_CONNECTED) {
+		if (chan->mode == L2CAP_MODE_LE_FLOWCTL &&
+		    sk->sk_state == BT_CONNECTED) {
 			err = -EISCONN;
 			break;
 		}
@@ -936,7 +928,12 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		chan->imtu = opt;
+		if (chan->mode == L2CAP_MODE_ECRED &&
+		    sk->sk_state == BT_CONNECTED)
+			err = l2cap_chan_reconfigure(chan, opt);
+		else
+			chan->imtu = opt;
+
 		break;
 
 	default:
@@ -991,7 +988,11 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 
 	if (sk->sk_state == BT_CONNECT2 && test_bit(BT_SK_DEFER_SETUP,
 						    &bt_sk(sk)->flags)) {
-		if (bdaddr_type_is_le(pi->chan->src_type)) {
+		if (pi->chan->mode == L2CAP_MODE_ECRED) {
+			sk->sk_state = BT_CONNECTED;
+			pi->chan->state = BT_CONNECTED;
+			__l2cap_ecred_conn_rsp_defer(pi->chan);
+		} if (bdaddr_type_is_le(pi->chan->src_type)) {
 			sk->sk_state = BT_CONNECTED;
 			pi->chan->state = BT_CONNECTED;
 			__l2cap_le_connect_rsp_defer(pi->chan);
-- 
2.21.0

