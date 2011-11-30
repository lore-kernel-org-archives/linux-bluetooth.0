Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 1/3] Bluetooth: AMP: HCI infrastructure
Date: Wed, 30 Nov 2011 15:54:30 +0200
Message-Id: <1322661272-32027-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Implementing amp pending HCI function to deal with executing AMP
HCI commands from A2MP protocol.

Code copied from mgmt interface.
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/amp.c              |   79 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100644 net/bluetooth/amp.c

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6f2397e..1e53444 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -225,6 +225,7 @@ struct hci_dev {
 	__u16			init_last_cmd;
 
 	struct list_head	mgmt_pending;
+	struct list_head	amp_pending;
 
 	struct inquiry_cache	inq_cache;
 	struct hci_conn_hash	conn_hash;
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
new file mode 100644
index 0000000..d5c48b6
--- /dev/null
+++ b/net/bluetooth/amp.c
@@ -0,0 +1,79 @@
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/a2mp.h>
+#include <linux/workqueue.h>
+
+struct pending_amp {
+	struct list_head list;
+	u16 opcode;
+	int index;
+	void *param;
+	struct sock *sk;
+	void *user_data;
+	struct amp_mgr *mgr;
+};
+
+static struct pending_amp *amp_pending_find(u16 opcode, struct hci_dev *hdev)
+{
+	struct pending_amp *cmd;
+
+	list_for_each_entry(cmd, &hdev->amp_pending, list)
+		if (cmd->opcode == opcode)
+			return cmd;
+
+	return NULL;
+}
+
+static struct pending_amp *amp_pending_add(struct amp_mgr *mgr, u16 opcode,
+				struct hci_dev *hdev, void *data, u16 len)
+{
+	struct pending_amp *cmd;
+
+	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (!cmd)
+		return NULL;
+
+	cmd->opcode = opcode;
+	cmd->index = hdev->id;
+
+	cmd->param = kmalloc(len, GFP_ATOMIC);
+	if (!cmd->param) {
+		kfree(cmd);
+		return NULL;
+	}
+
+	if (data)
+		memcpy(cmd->param, data, len);
+
+	amp_mgr_get(mgr);
+	cmd->mgr = mgr;
+	cmd->sk = mgr->a2mp_sock->sk;
+	sock_hold(cmd->sk);
+
+	list_add(&cmd->list, &hdev->amp_pending);
+
+	return cmd;
+}
+
+static void amp_pending_free(struct pending_amp *cmd)
+{
+	sock_put(cmd->sk);
+	amp_mgr_put(cmd->mgr);
+	kfree(cmd->param);
+	kfree(cmd);
+}
+
+static void amp_pending_remove(struct pending_amp *cmd)
+{
+	list_del(&cmd->list);
+	amp_pending_free(cmd);
+}
+
+void amp_pending_remove_all(struct hci_dev *hdev)
+{
+	struct pending_amp *cmd;
+
+	list_for_each_entry(cmd, &hdev->amp_pending, list)
+		amp_pending_remove(cmd);
+}
-- 
1.7.4.1

