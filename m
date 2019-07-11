Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40819C742A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB9A21019
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfGKXAV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:00:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:39428 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbfGKXAV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 19:00:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 16:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="166516193"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2019 16:00:20 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ v2 2/9] mesh: Fix support for Provisioner Initiator
Date:   Thu, 11 Jul 2019 15:59:45 -0700
Message-Id: <20190711225952.1599-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190711225952.1599-1-brian.gix@intel.com>
References: <20190711225952.1599-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/pb-adv.c         | 128 ++++++++++++++++++++++++++++----------------------
 mesh/pb-adv.h         |   3 +-
 mesh/prov-acceptor.c  |   2 +-
 mesh/prov-initiator.c |   2 +-
 4 files changed, 77 insertions(+), 58 deletions(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 8762afd7c..4d85ee72e 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -39,16 +39,16 @@ struct pb_adv_session {
 	mesh_prov_receive_func_t rx_cb;
 	mesh_prov_ack_func_t ack_cb;
 	struct l_timeout *tx_timeout;
-	uint32_t conn_id;
+	uint32_t link_id;
 	uint16_t exp_len;
 	uint8_t exp_fcs;
 	uint8_t exp_segs;
 	uint8_t got_segs;
-	uint8_t msg_num;
+	uint8_t trans_num;
 	uint8_t local_acked;
-	uint8_t local_msg_num;
-	uint8_t peer_msg_num;
-	uint8_t last_peer_msg_num;
+	uint8_t local_trans_num;
+	uint8_t peer_trans_num;
+	uint8_t last_peer_trans_num;
 	uint8_t sar[80];
 	uint8_t uuid[16];
 	bool initiator;
@@ -65,6 +65,8 @@ struct pb_adv_session {
 
 static struct pb_adv_session *pb_session = NULL;
 
+static const uint8_t filter[1] = { MESH_AD_TYPE_PROVISION };
+
 static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 							uint16_t size)
 {
@@ -77,10 +79,10 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 	if (!size)
 		return;
 
-	mesh_send_cancel(buf, 1);
+	mesh_send_cancel(filter, sizeof(filter));
 
-	l_put_be32(session->conn_id, buf + 1);
-	buf[1 + 4] = ++session->local_msg_num;
+	l_put_be32(session->link_id, buf + 1);
+	buf[1 + 4] = ++session->local_trans_num;
 
 	if (size > PB_ADV_MTU - 4) {
 		max_seg = 1 +
@@ -103,7 +105,7 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 	l_debug("max_seg: %2.2x", max_seg);
 	l_debug("size: %2.2x, CRC: %2.2x", size, buf[9]);
 	/* print_packet("PB-TX", buf + 1, init_size + 9); */
-	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 50, buf, init_size + 10);
+	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 200, buf, init_size + 10);
 
 	consumed = init_size;
 
@@ -120,7 +122,7 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 
 		/* print_packet("PB-TX", buf + 1, seg_size + 6); */
 
-		mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 50,
+		mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 200,
 							buf, seg_size + 7);
 
 		consumed += seg_size;
@@ -130,7 +132,6 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 static void tx_timeout(struct l_timeout *timeout, void *user_data)
 {
 	struct pb_adv_session *session = user_data;
-	uint8_t cancel[] = { MESH_AD_TYPE_PROVISION };
 	mesh_prov_close_func_t cb;
 
 	if (!session || pb_session != session)
@@ -139,7 +140,7 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 	l_timeout_remove(session->tx_timeout);
 	session->tx_timeout = NULL;
 
-	mesh_send_cancel(cancel, sizeof(cancel));
+	mesh_send_cancel(filter, sizeof(filter));
 
 	l_info("TX timeout");
 	cb = pb_session->close_cb;
@@ -162,29 +163,40 @@ static void pb_adv_tx(void *user_data, uint8_t *data, uint16_t len)
 	send_adv_segs(session, data, len);
 }
 
+static void send_open_req(struct pb_adv_session *session)
+{
+	uint8_t open_req[23] = { MESH_AD_TYPE_PROVISION };
+
+	l_put_be32(session->link_id, open_req + 1);
+	open_req[1 + 4] = 0;
+	open_req[1 + 4 + 1] = PB_ADV_OPEN_REQ;
+	memcpy(open_req + 7, session->uuid, 16);
+
+	mesh_send_cancel(filter, sizeof(filter));
+	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 500, open_req,
+						sizeof(open_req));
+}
+
 static void send_open_cfm(struct pb_adv_session *session)
 {
 	uint8_t open_cfm[7] = { MESH_AD_TYPE_PROVISION };
 
-	l_put_be32(session->conn_id, open_cfm + 1);
+	l_put_be32(session->link_id, open_cfm + 1);
 	open_cfm[1 + 4] = 0;
-	open_cfm[1 + 4 + 1] = 0x07; /* OPEN_CFM */
-
-	/* print_packet("PB-TX", open_cfm + 1, sizeof(open_cfm) - 1); */
+	open_cfm[1 + 4 + 1] = PB_ADV_OPEN_CFM; /* OPEN_CFM */
 
-	mesh_send_cancel(open_cfm, 1);
+	mesh_send_cancel(filter, sizeof(filter));
 	mesh_send_pkt(5, 100, open_cfm, sizeof(open_cfm));
 }
 
-static void send_ack(struct pb_adv_session *session, uint8_t msg_num)
+static void send_ack(struct pb_adv_session *session, uint8_t trans_num)
 {
 	uint8_t ack[7] = { MESH_AD_TYPE_PROVISION };
 
-	l_put_be32(session->conn_id, ack + 1);
-	ack[1 + 4] = msg_num;
-	ack[1 + 4 + 1] = 0x01; /* ACK */
+	l_put_be32(session->link_id, ack + 1);
+	ack[1 + 4] = trans_num;
+	ack[1 + 4 + 1] = PB_ADV_ACK;
 
-	/* print_packet("ADV-ACK", ack + 1, sizeof(ack) - 1); */
 	mesh_send_pkt(1, 100, ack, sizeof(ack));
 }
 
@@ -192,43 +204,43 @@ static void send_close_ind(struct pb_adv_session *session, uint8_t reason)
 {
 	uint8_t close_ind[8] = { MESH_AD_TYPE_PROVISION };
 
-	if (!pb_session || pb_session->user_data != session)
+	if (!pb_session || pb_session != session)
 		return;
 
-	l_put_be32(session->conn_id, close_ind + 1);
+	l_put_be32(session->link_id, close_ind + 1);
 	close_ind[5] = 0;
-	close_ind[6] = PB_ADV_CLOSE;		/* CLOSE_IND */
+	close_ind[6] = PB_ADV_CLOSE;
 	close_ind[7] = reason;
 
-	mesh_send_cancel(close_ind, 1);
-	mesh_send_pkt(5, 100, close_ind, sizeof(close_ind));
+	mesh_send_cancel(filter, sizeof(filter));
+	mesh_send_pkt(10, 100, close_ind, sizeof(close_ind));
 }
 
 static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 {
 	struct pb_adv_session *session = user_data;
-	uint32_t conn_id;
+	uint32_t link_id;
 	size_t offset;
-	uint8_t msg_num;
+	uint8_t trans_num;
 	uint8_t type;
 	bool first;
 
 	if (!session || pb_session != session)
 		return;
 
-	conn_id = l_get_be32(pkt + 1);
+	link_id = l_get_be32(pkt + 1);
 	type = l_get_u8(pkt + 6);
 
 	/* Validate new or existing Connection ID */
-	if (session->conn_id) {
-		if (session->conn_id != conn_id)
+	if (session->link_id) {
+		if (session->link_id != link_id)
 			return;
 	} else if (type != 0x03)
 		return;
-	else if (!conn_id)
+	else if (!link_id)
 		return;
 
-	msg_num = l_get_u8(pkt + 5);
+	trans_num = l_get_u8(pkt + 5);
 	pkt += 7;
 	len -= 7;
 
@@ -237,7 +249,7 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 		/*
 		 * Ignore if:
 		 * 1. We are acceptor
-		 * 2. We are already provisioning on different conn_id
+		 * 2. We are already provisioning on different link_id
 		 */
 
 		if (!session->initiator)
@@ -259,7 +271,7 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 		 * Ignore if:
 		 * 1. We are initiator
 		 * 2. Open request not addressed to us
-		 * 3. We are already provisioning on different conn_id
+		 * 3. We are already provisioning on different link_id
 		 */
 
 		if (session->initiator)
@@ -268,12 +280,12 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 		if (memcmp(pkt, session->uuid, 16))
 			return;
 
-		first = !session->conn_id;
-		session->conn_id = conn_id;
-		session->last_peer_msg_num = 0xFF;
+		first = !session->link_id;
+		session->link_id = link_id;
+		session->last_peer_trans_num = 0xFF;
 		session->local_acked = 0xFF;
-		session->peer_msg_num = 0x00;
-		session->local_msg_num = 0x7F;
+		session->peer_trans_num = 0x00;
+		session->local_trans_num = 0x7F;
 		session->opened = true;
 
 		/* Only call Open callback once */
@@ -305,29 +317,29 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 		if (!session->opened)
 			return;
 
-		if (msg_num != session->local_msg_num)
+		if (trans_num != session->local_trans_num)
 			return;
 
-		if (session->local_acked > msg_num)
+		if (session->local_acked > trans_num)
 			return;
 
-		l_debug("Got ACK %d", msg_num);
-		session->local_acked = msg_num;
-		session->ack_cb(session->user_data, msg_num);
+		mesh_send_cancel(filter, sizeof(filter));
+		session->local_acked = trans_num;
+		session->ack_cb(session->user_data, trans_num);
 		break;
 
 	default: /* DATA SEGMENT */
 		if (!session->opened)
 			return;
 
-		if (msg_num == session->last_peer_msg_num) {
-			send_ack(session, msg_num);
+		if (trans_num == session->last_peer_trans_num) {
+			send_ack(session, trans_num);
 			return;
 		}
 
 		switch(type & 0x03) {
 		case 0x00:
-			session->peer_msg_num = msg_num;
+			session->peer_trans_num = trans_num;
 			session->exp_len = l_get_be16(pkt);
 
 			l_debug("PB-ADV start with %u fragments, %d octets",
@@ -348,7 +360,7 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 			break;
 
 		case 0x02:
-			session->peer_msg_num = msg_num;
+			session->peer_trans_num = trans_num;
 			offset = 20 + (((type >> 2) - 1) * 23);
 
 			if (offset + len - 3 > sizeof(session->sar)) {
@@ -384,18 +396,19 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 			return;
 		}
 
-		if (session->last_peer_msg_num != session->peer_msg_num) {
+		if (session->last_peer_trans_num != session->peer_trans_num) {
 			session->got_segs = 0;
 			session->rx_cb(session->user_data, session->sar,
 							session->exp_len);
 		}
 
-		session->last_peer_msg_num = session->peer_msg_num;
-		send_ack(session, session->last_peer_msg_num);
+		session->last_peer_trans_num = session->peer_trans_num;
+		send_ack(session, session->last_peer_trans_num);
 	}
 }
 
-bool pb_adv_reg(mesh_prov_open_func_t open_cb, mesh_prov_close_func_t close_cb,
+bool pb_adv_reg(bool initiator, mesh_prov_open_func_t open_cb,
+		mesh_prov_close_func_t close_cb,
 		mesh_prov_receive_func_t rx_cb, mesh_prov_ack_func_t ack_cb,
 		uint8_t uuid[16], void *user_data)
 {
@@ -408,11 +421,16 @@ bool pb_adv_reg(mesh_prov_open_func_t open_cb, mesh_prov_close_func_t close_cb,
 	pb_session->rx_cb = rx_cb;
 	pb_session->ack_cb = ack_cb;
 	pb_session->user_data = user_data;
+	pb_session->initiator = initiator;
 	memcpy(pb_session->uuid, uuid, 16);
 
-	/* TODO: register PB AD type and Start Beaconing ? */
 	mesh_reg_prov_rx(pb_adv_packet, pb_session);
 
+	if (initiator) {
+		l_getrandom(&pb_session->link_id, sizeof(pb_session->link_id));
+		send_open_req(pb_session);
+	}
+
 	return true;
 }
 
diff --git a/mesh/pb-adv.h b/mesh/pb-adv.h
index a5870d5a2..80d53d234 100644
--- a/mesh/pb-adv.h
+++ b/mesh/pb-adv.h
@@ -17,7 +17,8 @@
  *
  */
 
-bool pb_adv_reg(mesh_prov_open_func_t open_cb, mesh_prov_close_func_t close_cb,
+bool pb_adv_reg(bool initiator, mesh_prov_open_func_t open_cb,
+		mesh_prov_close_func_t close_cb,
 		mesh_prov_receive_func_t rx_cb, mesh_prov_ack_func_t ack_cb,
 		uint8_t uuid[16], void *user_data);
 void pb_adv_unreg(void *user_data);
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 7b79fa916..111340db3 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -651,7 +651,7 @@ bool acceptor_start(uint8_t num_ele, uint8_t uuid[16],
 		goto error_fail;
 
 	/* Always register for PB-ADV */
-	result = pb_adv_reg(acp_prov_open, acp_prov_close, acp_prov_rx,
+	result = pb_adv_reg(false, acp_prov_open, acp_prov_close, acp_prov_rx,
 						acp_prov_ack, uuid, prov);
 
 	if (result)
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index f147c7ad8..b1ed96a60 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -613,7 +613,7 @@ bool initiator_start(enum trans_type transport,
 	prov->previous = -1;
 
 	/* Always register for PB-ADV */
-	result = pb_adv_reg(int_prov_open, int_prov_close, int_prov_rx,
+	result = pb_adv_reg(true, int_prov_open, int_prov_close, int_prov_rx,
 						int_prov_ack, uuid, prov);
 
 	if (result)
-- 
2.14.5

