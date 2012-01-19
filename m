Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 33/34] Bluetooth: AMP: Use HCI callback for Read AMP Info
Date: Thu, 19 Jan 2012 11:20:22 +0200
Message-Id: <1326964823-26747-34-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds Read Local AMP Info HCI command with callback to be executed
when receiving command complete event.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/Makefile    |    4 ++--
 net/bluetooth/a2mp.c      |    4 ++++
 net/bluetooth/amp.c       |   34 ++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c |   13 +++++++++++--
 4 files changed, 51 insertions(+), 4 deletions(-)
 create mode 100644 net/bluetooth/amp.c

diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 88bc999..b38e5be 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -10,6 +10,6 @@ obj-$(CONFIG_BT_HIDP)	+= hidp/
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
-	a2mp.o
+	a2mp.o amp.o
 
-bluetooth-$(CONFIG_BT_HS)	+= a2mp.o
+bluetooth-$(CONFIG_BT_HS)	+= a2mp.o amp.o
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b40b079..4de97a5 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -19,6 +19,8 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
 
+int amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
+
 /* A2MP build & send command helper functions */
 static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
 {
@@ -94,6 +96,8 @@ static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl, u8 num_ctrl)
 		cl[i].id = hdev->id;
 		cl[i].type = hdev->amp_type;
 		cl[i].status = hdev->amp_status;
+
+		amp_read_loc_info(hdev, mgr);
 	}
 }
 
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
new file mode 100644
index 0000000..3832c28b
--- /dev/null
+++ b/net/bluetooth/amp.c
@@ -0,0 +1,34 @@
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/a2mp.h>
+#include <linux/workqueue.h>
+
+void amp_read_loc_info_complete(struct hci_dev *hdev, struct cb_cmd *cmd)
+{
+	BT_DBG("%s cmd %p mgr %p", hdev->name, cmd, cmd->opt);
+}
+
+static void cb_destructor(struct cb_cmd *cmd)
+{
+	struct amp_mgr *mgr = cmd->opt;
+
+	BT_DBG("Destructor cmd %p mgr %p", cmd, mgr);
+
+	amp_mgr_put(mgr);
+	kfree(cmd);
+}
+
+int amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr)
+{
+	int err = 0;
+
+	BT_DBG("%s mgr %p", hdev->name, mgr);
+
+	amp_mgr_get(mgr);
+
+	hci_cmd_cb(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL,
+			amp_read_loc_info_complete, mgr, cb_destructor);
+
+	return err;
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c43ba90..acbf4a9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -44,6 +44,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/a2mp.h>
 
 static int enable_le;
 
@@ -813,14 +814,15 @@ static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
 }
 
 static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
-		struct sk_buff *skb)
+							struct sk_buff *skb)
 {
 	struct hci_rp_read_local_amp_info *rp = (void *) skb->data;
+	struct cb_cmd *cmd;
 
 	BT_DBG("%s status 0x%x", hdev->name, rp->status);
 
 	if (rp->status)
-		return;
+		goto send;
 
 	hdev->amp_status = rp->amp_status;
 	hdev->amp_total_bw = __le32_to_cpu(rp->total_bw);
@@ -834,6 +836,13 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
 
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_AMP_INFO, rp->status);
+
+send:
+	cmd = hci_find_cb(hdev, HCI_OP_READ_LOCAL_AMP_INFO);
+	if (cmd) {
+		cmd->status = rp->status;
+		hci_queue_cb(hdev, cmd, hdev->workqueue);
+	}
 }
 
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
-- 
1.7.4.1

