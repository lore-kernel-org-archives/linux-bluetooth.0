Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 3/7] Bluetooth: Implement Disable RSSI Monitor
Date: Tue,  9 Aug 2011 16:29:38 -0400
Message-Id: <4e4198c4.0750640a.58f6.0ec2@mx.google.com>
In-Reply-To: <1312921782-27523-1-git-send-email-y>
References: <y>
 <1312921782-27523-1-git-send-email-y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch implements Disable RSSI Monitor command. It is used to remove
elements from RSSI monitor list.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 net/bluetooth/mgmt.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 410f614..a4a2927 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1957,6 +1957,20 @@ static int rssi_monitor_add(u16 index, bdaddr_t *bdaddr, s8 low_trigger,
 	return 0;
 }
 
+static int rssi_monitor_remove(u16 index, bdaddr_t *bdaddr)
+{
+	struct rssi_monitor *rm;
+
+	rm = rssi_monitor_find(index, bdaddr);
+	if (!rm)
+		return -EINVAL;
+
+	list_del(&rm->list);
+	kfree(rm);
+
+	return 0;
+}
+
 static int enable_rssi_monitor(struct sock *sk, u16 index,
 					unsigned char *data, u16 len)
 {
@@ -1977,9 +1991,17 @@ static int enable_rssi_monitor(struct sock *sk, u16 index,
 static int disable_rssi_monitor(struct sock *sk, u16 index,
 					unsigned char *data, u16 len)
 {
+	struct mgmt_cp_disable_rssi_monitor *cp;
+
 	BT_DBG("hci%u", index);
 
-	return -ENOSYS;
+	cp = (void *) data;
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index,
+				MGMT_OP_DISABLE_RSSI_MONITOR, EINVAL);
+
+	return rssi_monitor_remove(index, &cp->bdaddr);
 }
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
-- 
1.7.4.1

