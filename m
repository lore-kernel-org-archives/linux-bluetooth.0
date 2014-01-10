Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 07/19] monitor: Add mcc structs and types to rfcomm.h
Date: Fri, 10 Jan 2014 10:18:17 +0100
Message-Id: <1389345509-27206-8-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/rfcomm.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/monitor/rfcomm.h b/monitor/rfcomm.h
index 8dcb9c1..4222624 100644
--- a/monitor/rfcomm.h
+++ b/monitor/rfcomm.h
@@ -45,3 +45,35 @@ struct rfcomm_cmd {
 	uint8_t length;
 	uint8_t fcs;
 } __attribute__((packed));
+
+#define RFCOMM_TEST    0x08
+#define RFCOMM_FCON    0x28
+#define RFCOMM_FCOFF   0x18
+#define RFCOMM_MSC     0x38
+#define RFCOMM_RPN     0x24
+#define RFCOMM_RLS     0x14
+#define RFCOMM_PN      0x20
+#define RFCOMM_NSC     0x04
+
+#define RFCOMM_TEST_CR(type)	((type & 0x02))
+#define RFCOMM_GET_MCC_TYPE(type)	((type & 0xfc) >> 2)
+
+struct rfcomm_mcc {
+	uint8_t type;
+	uint8_t length;
+} __attribute__((packed));
+
+struct rfcomm_msc {
+	uint8_t dlci;
+	uint8_t v24_sig;
+} __attribute__((packed));
+
+struct rfcomm_pn {
+	uint8_t dlci;
+	uint8_t flow_ctrl;
+	uint8_t priority;
+	uint8_t ack_timer;
+	uint16_t mtu;
+	uint8_t max_retrans;
+	uint8_t credits;
+} __attribute__((packed));
-- 
1.8.3.1

