Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B340C74A36
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 23:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7A8214AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 23:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfGJXIT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:08:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:52368 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGJXIT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 19:08:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 16:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="186250390"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 16:08:18 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ 2/8] mesh: Fix support for Provisioner Initiator
Date:   Wed, 10 Jul 2019 16:07:51 -0700
Message-Id: <20190710230757.8425-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190710230757.8425-1-brian.gix@intel.com>
References: <20190710230757.8425-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/pb-adv.c | 54 ++++++++++++++++++++++++++++++++++++------------------
 mesh/pb-adv.h |  3 ++-
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 8762afd7c..346293bd0 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -65,6 +65,8 @@ struct pb_adv_session {
 
 static struct pb_adv_session *pb_session = NULL;
 
+static const uint8_t filter[1] = { MESH_AD_TYPE_PROVISION };
+
 static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 							uint16_t size)
 {
@@ -77,7 +79,7 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
 	if (!size)
 		return;
 
-	mesh_send_cancel(buf, 1);
+	mesh_send_cancel(filter, sizeof(filter));
 
 	l_put_be32(session->conn_id, buf + 1);
 	buf[1 + 4] = ++session->local_msg_num;
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
@@ -162,17 +163,29 @@ static void pb_adv_tx(void *user_data, uint8_t *data, uint16_t len)
 	send_adv_segs(session, data, len);
 }
 
+static void send_open_req(struct pb_adv_session *session)
+{
+	uint8_t open_req[23] = { MESH_AD_TYPE_PROVISION };
+
+	l_put_be32(session->conn_id, open_req + 1);
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
 
 	l_put_be32(session->conn_id, open_cfm + 1);
 	open_cfm[1 + 4] = 0;
-	open_cfm[1 + 4 + 1] = 0x07; /* OPEN_CFM */
-
-	/* print_packet("PB-TX", open_cfm + 1, sizeof(open_cfm) - 1); */
+	open_cfm[1 + 4 + 1] = PB_ADV_OPEN_CFM; /* OPEN_CFM */
 
-	mesh_send_cancel(open_cfm, 1);
+	mesh_send_cancel(filter, sizeof(filter));
 	mesh_send_pkt(5, 100, open_cfm, sizeof(open_cfm));
 }
 
@@ -182,9 +195,8 @@ static void send_ack(struct pb_adv_session *session, uint8_t msg_num)
 
 	l_put_be32(session->conn_id, ack + 1);
 	ack[1 + 4] = msg_num;
-	ack[1 + 4 + 1] = 0x01; /* ACK */
+	ack[1 + 4 + 1] = PB_ADV_ACK;
 
-	/* print_packet("ADV-ACK", ack + 1, sizeof(ack) - 1); */
 	mesh_send_pkt(1, 100, ack, sizeof(ack));
 }
 
@@ -192,16 +204,16 @@ static void send_close_ind(struct pb_adv_session *session, uint8_t reason)
 {
 	uint8_t close_ind[8] = { MESH_AD_TYPE_PROVISION };
 
-	if (!pb_session || pb_session->user_data != session)
+	if (!pb_session || pb_session != session)
 		return;
 
 	l_put_be32(session->conn_id, close_ind + 1);
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
@@ -311,7 +323,7 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
 		if (session->local_acked > msg_num)
 			return;
 
-		l_debug("Got ACK %d", msg_num);
+		mesh_send_cancel(filter, sizeof(filter));
 		session->local_acked = msg_num;
 		session->ack_cb(session->user_data, msg_num);
 		break;
@@ -395,7 +407,8 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
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
+		l_getrandom(&pb_session->conn_id, sizeof(pb_session->conn_id));
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
-- 
2.14.5

