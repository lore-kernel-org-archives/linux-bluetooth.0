Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 1/8] Add RSSI threshold monitor definition in mgmt
Date: Tue,  2 Aug 2011 18:37:33 -0300
Message-Id: <1312321060-19283-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312321060-19283-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312321060-19283-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add RSSI threshold monitor in Management header. Low and high threshold
value range is -128 to 127. Alert events are sent by the kernel when the
measured RSSI crosses the defined thresholds.

Alert types are:
0x00 In range
0x01 Low alert
0x02 High alert
---
 lib/mgmt.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index f22434e..8cca51e 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -215,6 +215,18 @@ struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define MGMT_OP_ENABLE_RSSI_MONITOR	0x001F
+struct mgmt_cp_enable_rssi_monitor {
+	bdaddr_t bdaddr;
+	int8_t low;
+	int8_t high;
+} __packed;
+
+#define MGMT_OP_DISABLE_RSSI_MONITOR	0x0020
+struct mgmt_cp_disable_rssi_monitor {
+	bdaddr_t bdaddr;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -305,3 +317,9 @@ struct mgmt_ev_remote_name {
 } __packed;
 
 #define MGMT_EV_DISCOVERING		0x0014
+
+#define MGMT_EV_RSSI_MONITOR_ALERT	0x0015
+struct mgmt_ev_rssi_monitor_alert {
+	bdaddr_t bdaddr;
+	uint8_t alert_type;
+} __packed;
-- 
1.7.6

