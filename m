Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Introduce force_bredr_smp debugfs option for testing
Date: Wed, 31 Dec 2014 14:43:16 -0800
Message-Id: <1420065799-28781-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Testing cross-transport pairing that starts on BR/EDR is only valid when
using a controller with BR/EDR Secure Connections. Devices will indicate
this by providing BR/EDR SMP fixed channel over L2CAP. To allow testing
of this feature on Bluetooth 4.0 controller or controllers without the
BR/EDR Secure Connections features, introduce a force_bredr_smp debugfs
option that allows faking the required AES connection.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/l2cap_core.c  |  2 +-
 net/bluetooth/smp.c         | 78 ++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1849a437f6e1..fddb93f168b8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -174,6 +174,7 @@ enum {
 	HCI_DUT_MODE,
 	HCI_FORCE_SC,
 	HCI_FORCE_LESC,
+	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
 };
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d04dc0095736..11029b212874 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6968,7 +6968,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 
 	if (test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags) &&
 	    (bredr_sc_enabled(hcon->hdev) ||
-	     test_bit(HCI_FORCE_LESC, &hcon->hdev->dbg_flags)))
+	     test_bit(HCI_FORCE_BREDR_SMP, &hcon->hdev->dbg_flags)))
 		conn->local_fixed_chan |= L2CAP_FC_SMP_BREDR;
 
 	mutex_init(&conn->ident_lock);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 358264c0e785..73643a6ca3cf 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -20,6 +20,7 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#include <linux/debugfs.h>
 #include <linux/crypto.h>
 #include <linux/scatterlist.h>
 #include <crypto/b128ops.h>
@@ -1675,7 +1676,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (conn->hcon->type == ACL_LINK) {
 		/* We must have a BR/EDR SC link */
 		if (!test_bit(HCI_CONN_AES_CCM, &conn->hcon->flags) &&
-		    !test_bit(HCI_FORCE_LESC, &hdev->dbg_flags))
+		    !test_bit(HCI_FORCE_BREDR_SMP, &hdev->dbg_flags))
 			return SMP_CROSS_TRANSP_NOT_ALLOWED;
 
 		set_bit(SMP_FLAG_SC, &smp->flags);
@@ -2738,7 +2739,7 @@ static void bredr_pairing(struct l2cap_chan *chan)
 
 	/* BR/EDR must use Secure Connections for SMP */
 	if (!test_bit(HCI_CONN_AES_CCM, &hcon->flags) &&
-	    !test_bit(HCI_FORCE_LESC, &hdev->dbg_flags))
+	    !test_bit(HCI_FORCE_BREDR_SMP, &hdev->dbg_flags))
 		return;
 
 	/* If our LE support is not enabled don't do anything */
@@ -2976,6 +2977,66 @@ static void smp_del_chan(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
+static ssize_t force_bredr_smp_read(struct file *file,
+				    char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = test_bit(HCI_FORCE_BREDR_SMP, &hdev->dbg_flags) ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_bredr_smp_write(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[32];
+	size_t buf_size = min(count, (sizeof(buf)-1));
+	bool enable;
+
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	if (strtobool(buf, &enable))
+		return -EINVAL;
+
+	if (enable == test_bit(HCI_FORCE_BREDR_SMP, &hdev->dbg_flags))
+		return -EALREADY;
+
+	if (enable) {
+		struct l2cap_chan *chan;
+
+		chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
+		if (IS_ERR(chan))
+			return PTR_ERR(chan);
+
+		hdev->smp_bredr_data = chan;
+	} else {
+		struct l2cap_chan *chan;
+
+		chan = hdev->smp_bredr_data;
+		hdev->smp_bredr_data = NULL;
+		smp_del_chan(chan);
+	}
+
+	change_bit(HCI_FORCE_BREDR_SMP, &hdev->dbg_flags);
+
+	return count;
+}
+
+static const struct file_operations force_bredr_smp_fops = {
+	.open		= simple_open,
+	.read		= force_bredr_smp_read,
+	.write		= force_bredr_smp_write,
+	.llseek		= default_llseek,
+};
+
 int smp_register(struct hci_dev *hdev)
 {
 	struct l2cap_chan *chan;
@@ -2988,9 +3049,18 @@ int smp_register(struct hci_dev *hdev)
 
 	hdev->smp_data = chan;
 
-	if (!lmp_sc_capable(hdev) &&
-	    !test_bit(HCI_FORCE_LESC, &hdev->dbg_flags))
+	/* If the controller does not support BR/EDR Secure Connections
+	 * feature, then the BR/EDR SMP channel shall not be present.
+	 *
+	 * To test this with Bluetooth 4.0 controllers, create a debugfs
+	 * switch that allows forcing BR/EDR SMP support and accepting
+	 * cross-transport pairing on non-AES encrypted connections.
+	 */
+	if (!lmp_sc_capable(hdev)) {
+		debugfs_create_file("force_bredr_smp", 0644, hdev->debugfs,
+				    hdev, &force_bredr_smp_fops);
 		return 0;
+	}
 
 	chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
 	if (IS_ERR(chan)) {
-- 
2.1.0

