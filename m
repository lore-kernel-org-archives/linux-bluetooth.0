Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] lib/mgmt: Add New Connection Parameter Event
Date: Tue,  1 Jul 2014 19:26:39 -0300
Message-Id: <1404253600-24211-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds struct and macro for New Connection Parameter Event.
---
 lib/mgmt.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 6db3883..df4697f 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -564,6 +564,16 @@ struct mgmt_ev_device_removed {
 	struct mgmt_addr_info addr;
 } __packed;
 
+#define MGMT_EV_NEW_CONN_PARAM		0x001c
+struct mgmt_ev_new_conn_param {
+	struct mgmt_addr_info addr;
+	uint8_t store_hint;
+	uint16_t min_interval;
+	uint16_t max_interval;
+	uint16_t latency;
+	uint16_t timeout;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
-- 
1.9.1

