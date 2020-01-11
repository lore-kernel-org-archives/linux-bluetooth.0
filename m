Return-Path: <SRS0=d6qz=3A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3EBC282DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 01:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9DF2064C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 01:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgAKBjH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jan 2020 20:39:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:63809 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgAKBjH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jan 2020 20:39:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 17:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,419,1571727600"; 
   d="scan'208";a="371763080"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.191.206])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2020 17:39:06 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v3 1/1] mesh: Implement provisioning loop-back
Date:   Fri, 10 Jan 2020 17:38:56 -0800
Message-Id: <20200111013856.32675-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200111013856.32675-1-brian.gix@intel.com>
References: <20200111013856.32675-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows one App using the mesh daemon to provision another.
---
 mesh/pb-adv.c | 163 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 130 insertions(+), 33 deletions(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index c9a2a6574..4767908f3 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -39,6 +39,7 @@ struct pb_adv_session {
 	mesh_prov_receive_func_t rx_cb;
 	mesh_prov_ack_func_t ack_cb;
 	struct l_timeout *tx_timeout;
+	struct pb_adv_session *loop;
 	uint32_t link_id;
 	uint16_t exp_len;
 	uint8_t exp_fcs;
@@ -93,10 +94,43 @@ struct pb_close_ind {
 	uint8_t reason;
 } __packed;
 
-static struct pb_adv_session *pb_session = NULL;
+struct idle_rx {
+	struct pb_adv_session *session;
+	uint16_t len;
+	uint8_t data[PB_ADV_MTU + 6];
+};
+
+static struct l_queue *pb_sessions = NULL;
 
 static const uint8_t filter[1] = { MESH_AD_TYPE_PROVISION };
 
+static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len);
+
+static void idle_rx_adv(void *user_data)
+{
+	struct idle_rx *rx = user_data;
+
+	pb_adv_packet(rx->session, rx->data, rx->len);
+	l_free(rx);
+}
+
+static void pb_adv_send(struct pb_adv_session *session,
+					uint8_t count, uint16_t interval,
+					void *data, uint16_t len)
+{
+	struct idle_rx *rx = l_new(struct idle_rx, 1);
+
+	if (session->loop) {
+		rx = l_new(struct idle_rx, 1);
+		rx->session = session->loop;
+		rx->len = len;
+		memcpy(rx->data, data, len);
+
+		l_idle_oneshot(idle_rx_adv, rx, NULL);
+	} else
+		mesh_send_pkt(count, interval, data, len);
+}
+
 static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 							uint16_t size)
 {
@@ -135,7 +169,9 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 	l_debug("max_seg: %2.2x", max_seg);
 	l_debug("size: %2.2x, CRC: %2.2x", size, buf[9]);
 	/* print_packet("PB-TX", buf + 1, init_size + 9); */
-	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 200, buf, init_size + 10);
+
+	pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 200,
+							buf, init_size + 10);
 
 	consumed = init_size;
 
@@ -152,19 +188,39 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 
 		/* print_packet("PB-TX", buf + 1, seg_size + 6); */
 
-		mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 200,
+		pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 200,
 							buf, seg_size + 7);
 
 		consumed += seg_size;
 	}
 }
 
+static bool session_match (const void *a, const void *b)
+{
+	return a == b;
+}
+
+static bool uuid_match (const void *a, const void *b)
+{
+	const struct pb_adv_session *session = a;
+	const uint8_t *uuid = b;
+
+	return !memcmp(session->uuid, uuid, sizeof(session->uuid));
+}
+
+static bool user_match (const void *a, const void *b)
+{
+	const struct pb_adv_session *session = a;
+
+	return session->user_data == b;
+}
+
 static void tx_timeout(struct l_timeout *timeout, void *user_data)
 {
 	struct pb_adv_session *session = user_data;
 	mesh_prov_close_func_t cb;
 
-	if (!session || pb_session != session)
+	if (!l_queue_find(pb_sessions, session_match, session))
 		return;
 
 	l_timeout_remove(session->tx_timeout);
@@ -173,8 +229,8 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 	mesh_send_cancel(filter, sizeof(filter));
 
 	l_info("TX timeout");
-	cb = pb_session->close_cb;
-	user_data = pb_session->user_data;
+	cb = session->close_cb;
+	user_data = session->user_data;
 	cb(user_data, 1);
 }
 
@@ -182,7 +238,7 @@ static void pb_adv_tx(void *user_data, void *data, uint16_t len)
 {
 	struct pb_adv_session *session = user_data;
 
-	if (!session || pb_session != session)
+	if (!l_queue_find(pb_sessions, session_match, session))
 		return;
 
 	l_timeout_remove(session->tx_timeout);
@@ -201,7 +257,8 @@ static void send_open_req(struct pb_adv_session *session)
 	memcpy(open_req.uuid, session->uuid, 16);
 
 	mesh_send_cancel(filter, sizeof(filter));
-	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 500, &open_req,
+
+	pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 500, &open_req,
 							sizeof(open_req));
 }
 
@@ -214,7 +271,8 @@ static void send_open_cfm(struct pb_adv_session *session)
 	open_cfm.opcode = PB_ADV_OPEN_CFM;
 
 	mesh_send_cancel(filter, sizeof(filter));
-	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 500, &open_cfm,
+
+	pb_adv_send(session, MESH_IO_TX_COUNT_UNLIMITED, 500, &open_cfm,
 							sizeof(open_cfm));
 }
 
@@ -222,18 +280,21 @@ static void send_ack(struct pb_adv_session *session, uint8_t trans_num)
 {
 	struct pb_ack ack = { MESH_AD_TYPE_PROVISION };
 
+	if (!l_queue_find(pb_sessions, session_match, session))
+		return;
+
 	l_put_be32(session->link_id, &ack.link_id);
 	ack.trans_num = trans_num;
 	ack.opcode = PB_ADV_ACK;
 
-	mesh_send_pkt(1, 100, &ack, sizeof(ack));
+	pb_adv_send(session, 1, 100, &ack, sizeof(ack));
 }
 
 static void send_close_ind(struct pb_adv_session *session, uint8_t reason)
 {
 	struct pb_close_ind close_ind = { MESH_AD_TYPE_PROVISION };
 
-	if (!pb_session || pb_session != session)
+	if (!l_queue_find(pb_sessions, session_match, session))
 		return;
 
 	l_put_be32(session->link_id, &close_ind.link_id);
@@ -242,7 +303,8 @@ static void send_close_ind(struct pb_adv_session *session, uint8_t reason)
 	close_ind.reason = reason;
 
 	mesh_send_cancel(filter, sizeof(filter));
-	mesh_send_pkt(10, 100, &close_ind, sizeof(close_ind));
+
+	pb_adv_send(session, 10, 100, &close_ind, sizeof(close_ind));
 }
 
 static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
@@ -254,7 +316,7 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 	uint8_t type;
 	bool first;
 
-	if (!pb_session || pb_session != session)
+	if (!l_queue_find(pb_sessions, session_match, session))
 		return;
 
 	link_id = l_get_be32(pkt + 1);
@@ -337,8 +399,8 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 			mesh_prov_close_func_t cb = session->close_cb;
 			void *user_data = session->user_data;
 
+			l_queue_remove(pb_sessions, session);
 			l_free(session);
-			pb_session = NULL;
 			cb(user_data, pkt[0]);
 		}
 		break;
@@ -442,37 +504,72 @@ bool pb_adv_reg(bool initiator, mesh_prov_open_func_t open_cb,
 		mesh_prov_receive_func_t rx_cb, mesh_prov_ack_func_t ack_cb,
 		uint8_t uuid[16], void *user_data)
 {
-	if (pb_session)
+	struct pb_adv_session *session, *old_session;
+
+	if (!pb_sessions)
+		pb_sessions = l_queue_new();
+
+	old_session = l_queue_find(pb_sessions, uuid_match, uuid);
+
+	/* Reject 2nd session if not looping back */
+	if (l_queue_length(pb_sessions) && !old_session)
+		return false;
+
+	/* Reject looping to more than one session or with same role*/
+	if (old_session && (old_session->loop ||
+					old_session->initiator == initiator))
 		return false;
 
-	pb_session = l_new(struct pb_adv_session, 1);
-	pb_session->open_cb = open_cb;
-	pb_session->close_cb = close_cb;
-	pb_session->rx_cb = rx_cb;
-	pb_session->ack_cb = ack_cb;
-	pb_session->user_data = user_data;
-	pb_session->initiator = initiator;
-	memcpy(pb_session->uuid, uuid, 16);
+	session = l_new(struct pb_adv_session, 1);
+	session->open_cb = open_cb;
+	session->close_cb = close_cb;
+	session->rx_cb = rx_cb;
+	session->ack_cb = ack_cb;
+	session->user_data = user_data;
+	session->initiator = initiator;
+	memcpy(session->uuid, uuid, 16);
 
-	mesh_reg_prov_rx(pb_adv_packet, pb_session);
+	l_queue_push_head(pb_sessions, session);
 
 	if (initiator) {
-		l_getrandom(&pb_session->link_id, sizeof(pb_session->link_id));
-		pb_session->tx_timeout = l_timeout_create(60, tx_timeout,
-							pb_session, NULL);
-		send_open_req(pb_session);
+		l_getrandom(&session->link_id, sizeof(session->link_id));
+		session->tx_timeout = l_timeout_create(60, tx_timeout,
+							session, NULL);
+	}
+
+	/* Setup Loop-back if complementary session with same UUID */
+	if (old_session) {
+		session->loop = old_session;
+		old_session->loop = session;
+		mesh_unreg_prov_rx(pb_adv_packet);
+
+		if (initiator)
+			send_open_req(session);
+		else
+			send_open_req(old_session);
+
+		return true;
 	}
 
+	mesh_reg_prov_rx(pb_adv_packet, session);
+
+	if (initiator)
+		send_open_req(session);
+
 	return true;
 }
 
 void pb_adv_unreg(void *user_data)
 {
-	if (!pb_session || pb_session->user_data != user_data)
+	struct pb_adv_session *session = l_queue_find(pb_sessions,
+						user_match, user_data);
+
+	if (!session)
 		return;
 
-	l_timeout_remove(pb_session->tx_timeout);
-	send_close_ind(pb_session, 0);
-	l_free(pb_session);
-	pb_session = NULL;
+	l_timeout_remove(session->tx_timeout);
+	session->tx_timeout = NULL;
+	send_close_ind(session, 0);
+	l_queue_remove(pb_sessions, session);
+	l_free(session);
 }
-- 
2.21.1

