Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 3/7] Bluetooth: Implement Disable RSSI Monitor
Date: Tue,  2 Aug 2011 14:35:05 -0400
Message-Id: <1312310109-27082-4-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
References: <y>
 <1312310109-27082-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements Disable RSSI Monitor command in order to remove
elements from RSSI monitor list.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 net/bluetooth/mgmt.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccfc19b..e655542 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1938,6 +1938,19 @@ static int rssi_monitor_add(u16 index, bdaddr_t *bdaddr, s8 low_trigger,
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
+
+	return 0;
+}
+
 static int enable_rssi_monitor(struct sock *sk, u16 index,
 					unsigned char *data, u16 len)
 {
@@ -1958,9 +1971,17 @@ static int enable_rssi_monitor(struct sock *sk, u16 index,
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

