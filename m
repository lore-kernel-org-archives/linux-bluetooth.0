Return-Path: <SRS0=1Za/=OY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAD0C43444
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C491208C1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeLOA0f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:26:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:22249 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbeLOA0d (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Dec 2018 19:26:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 16:26:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,355,1539673200"; 
   d="scan'208";a="109640324"
Received: from bgix-dell-lap.sea.intel.com ([10.251.138.67])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2018 16:26:32 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v3 14/30] mesh: re-arrange provisioning for DBus API
Date:   Fri, 14 Dec 2018 16:26:08 -0800
Message-Id: <20181215002624.9313-15-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181215002624.9313-1-brian.gix@intel.com>
References: <20181215002624.9313-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/prov.h      |  14 +++++--
 mesh/provision.h | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 112 insertions(+), 14 deletions(-)

diff --git a/mesh/prov.h b/mesh/prov.h
index 09fe6c3cd..61ec08e10 100644
--- a/mesh/prov.h
+++ b/mesh/prov.h
@@ -47,11 +47,17 @@ enum mesh_prov_mode {
 };
 
 struct mesh_prov;
-typedef void (*mesh_prov_open_func_t)(struct mesh_prov *prov);
-typedef void (*mesh_prov_close_func_t)(struct mesh_prov *prov, uint8_t reason);
+
+typedef void (*prov_trans_tx_t)(void *trans_data, uint8_t *data, uint16_t len);
+typedef void (*mesh_prov_open_func_t)(void *user_data, prov_trans_tx_t trans_tx,
+					void *trans_data, uint8_t trans_type);
+
+typedef void (*mesh_prov_close_func_t)(void *user_data, uint8_t reason);
 typedef void (*mesh_prov_send_func_t)(bool success, struct mesh_prov *prov);
-typedef void (*mesh_prov_receive_func_t)(const void *data, uint16_t size,
-							struct mesh_prov *prov);
+typedef void (*mesh_prov_ack_func_t)(void *user_data, uint8_t msg_num);
+typedef void (*mesh_prov_receive_func_t)(void *user_data, const uint8_t *data,
+								uint16_t size);
+
 
 struct prov_invite {
 	uint8_t attention;
diff --git a/mesh/provision.h b/mesh/provision.h
index 0c59bf037..6b61a45be 100644
--- a/mesh/provision.h
+++ b/mesh/provision.h
@@ -17,14 +17,106 @@
  *
  */
 
+
+/*
+ * size: hard define (mesh.conf - OOB_NUMBEROOB_NUMBER)
+ *      oob size - 8 if alpha or numeric
+ *	else 1 if mask is non zero
+ *	else 0
+ */
+struct bt_mesh;
 struct mesh_prov;
-struct l_queue;
-
-void initiator_prov_open(struct mesh_prov *prov);
-void initiator_prov_close(struct mesh_prov *prov, uint8_t reason);
-void initiator_prov_receive(const void *pkt, uint16_t size,
-							struct mesh_prov *prov);
-void acceptor_prov_open(struct mesh_prov *prov);
-void acceptor_prov_close(struct mesh_prov *prov, uint8_t reason);
-void acceptor_prov_receive(const void *pkt, uint16_t size,
-							struct mesh_prov *prov);
+struct mesh_agent;
+
+/* Provisioner Agent Response Types */
+#define OOB_CANCEL		0x00
+#define OOB_PRIV_KEY		0x01
+#define OOB_PUB_KEY		0x02
+#define OOB_NUMBER		0x03
+#define OOB_STATIC		0x04
+#define OOB_NUMBER_DISPLAY	0x05
+
+/* Spec defined Provisioning message types */
+#define PROV_INVITE	0x00
+#define PROV_CAPS	0x01
+#define PROV_START	0x02
+#define PROV_PUB_KEY	0x03
+#define PROV_INP_CMPLT	0x04
+#define PROV_CONFIRM	0x05
+#define PROV_RANDOM	0x06
+#define PROV_DATA	0x07
+#define PROV_COMPLETE	0x08
+#define PROV_FAILED	0x09
+
+/* Spec defined Error Codes */
+#define PROV_ERR_SUCCESS		0x00
+#define PROV_ERR_INVALID_PDU		0x01
+#define PROV_ERR_INVALID_FORMAT		0x02
+#define PROV_ERR_UNEXPECTED_PDU		0x03
+#define PROV_ERR_CONFIRM_FAILED		0x04
+#define PROV_ERR_INSUF_RESOURCE		0x05
+#define PROV_ERR_DECRYPT_FAILED		0x06
+#define PROV_ERR_UNEXPECTED_ERR		0x07
+#define PROV_ERR_CANT_ASSIGN_ADDR	0x08
+/* Internally generated Error Codes */
+#define PROV_ERR_TIMEOUT		0xFF
+
+/* Provisioner Action values */
+/* IN */
+#define PROV_ACTION_PUSH		0x00
+#define PROV_ACTION_TWIST		0x01
+#define PROV_ACTION_IN_NUMERIC		0x02
+#define PROV_ACTION_IN_ALPHA		0x03
+/* OUT */
+#define PROV_ACTION_BLINK		0x00
+#define PROV_ACTION_BEEP		0x01
+#define PROV_ACTION_VIBRATE		0x02
+#define PROV_ACTION_OUT_NUMERIC		0x03
+#define PROV_ACTION_OUT_ALPHA		0x04
+
+/* OOB_Info defines from Table 3.54 of Mesh profile Specification v1.0 */
+#define OOB_INFO_URI_HASH	0x0002
+
+/* PB_REMOTE not supported from unprovisioned state */
+enum trans_type {
+	PB_ADV = 0,
+	PB_GATT,
+};
+
+#define PROV_FLAG_KR	0x01
+#define PROV_FLAG_IVU	0x02
+
+struct mesh_prov_node_info {
+	uint32_t iv_index;
+	uint16_t unicast;
+	uint16_t net_index;
+	uint8_t net_key[16];
+	uint8_t device_key[16];
+	uint8_t flags; /* IVU and KR bits */
+};
+
+typedef bool (*mesh_prov_acceptor_complete_func_t)(void *user_data,
+					uint8_t status,
+					struct mesh_prov_node_info *info);
+
+typedef bool (*mesh_prov_initiator_complete_func_t)(void *user_data,
+					uint8_t status,
+					struct mesh_prov_node_info *info);
+
+/* This starts unprovisioned device beacon */
+bool acceptor_start(uint8_t num_ele, uint8_t uuid[16],
+			uint16_t algorithms, uint32_t timeout,
+			struct mesh_agent *agent,
+			mesh_prov_acceptor_complete_func_t complete_cb,
+			void *caller_data);
+void acceptor_cancel(void *user_data);
+
+bool initiator_start(enum trans_type transport,
+		uint8_t uuid[16],
+		uint16_t max_ele,
+		uint16_t server, /* Only valid for PB-Remote */
+		uint32_t timeout, /* in seconds from mesh.conf */
+		struct mesh_agent *agent,
+		mesh_prov_initiator_complete_func_t complete_cb,
+		void *caller_data);
+void initiator_cancel(void *user_data);
-- 
2.14.5

