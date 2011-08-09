Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 1/7] Bluetooth: Add RSSI Monitor commands
Date: Tue,  9 Aug 2011 16:29:36 -0400
Message-Id: <4e4198c0.0750640a.58f6.0ebf@mx.google.com>
In-Reply-To: <1312921782-27523-1-git-send-email-y>
References: <y>
 <1312921782-27523-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch adds two new Management commands: Enable/Disable RSSI Monitor.
These commands are used to handle a list of RSSI monitors, that are
responsible to watch RSSI values from a connection. It is useful for
Proximity profile implementation.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/mgmt.h |   12 ++++++++++++
 net/bluetooth/mgmt.c         |   22 ++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5428fd3..ef3b636 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -211,6 +211,18 @@ struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define MGMT_OP_ENABLE_RSSI_MONITOR	0x001F
+struct mgmt_cp_enable_rssi_monitor {
+	bdaddr_t bdaddr;
+	__s8 low_alert_trigger;
+	__s8 high_alert_trigger;
+} __packed;
+
+#define MGMT_OP_DISABLE_RSSI_MONITOR	0x0020
+struct mgmt_cp_disable_rssi_monitor {
+	bdaddr_t bdaddr;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7c0f4f6..36ed168 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1884,6 +1884,22 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 	return err;
 }
 
+static int enable_rssi_monitor(struct sock *sk, u16 index,
+					unsigned char *data, u16 len)
+{
+	BT_DBG("hci%u", index);
+
+	return -ENOSYS;
+}
+
+static int disable_rssi_monitor(struct sock *sk, u16 index,
+					unsigned char *data, u16 len)
+{
+	BT_DBG("hci%u", index);
+
+	return -ENOSYS;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -2004,6 +2020,12 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_UNBLOCK_DEVICE:
 		err = unblock_device(sk, index, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_ENABLE_RSSI_MONITOR:
+		err = enable_rssi_monitor(sk, index, buf + sizeof(*hdr), len);
+		break;
+	case MGMT_OP_DISABLE_RSSI_MONITOR:
+		err = disable_rssi_monitor(sk, index, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode, 0x01);
-- 
1.7.4.1

