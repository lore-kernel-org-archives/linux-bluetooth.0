Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Wait for SMP key distribution completion when pairing
Date: Tue, 18 Feb 2014 21:41:34 +0200
Message-Id: <1392752497-8696-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
References: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we initiate pairing through mgmt_pair_device the code has so far
been waiting for a successful HCI Encrypt Change event in order to
respond to the mgmt command. However, putting privacy into the play we
actually want the key distribution to be complete before replying so
that we can include the Identity Address in the mgmt response.

This patch updates the various hci_conn callbacks for LE in mgmt.c to
only respond in the case of failure, and adds a new mgmt_smp_complete
function that the SMP code will call once key distribution has been
completed.

Since the smp_chan_destroy function that's used to indicate completion
and clean up the SMP context can be called from various places,
including outside of smp.c, the easiest way to track failure vs success
is a new flag that we set once key distribution has been successfully
completed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/mgmt.c             | 25 +++++++++++++++++++------
 net/bluetooth/smp.c              |  5 +++++
 net/bluetooth/smp.h              |  1 +
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4461c0051228..64c4e3f0a515 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1212,6 +1212,7 @@ int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
+void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 90aac905a98b..24a85fe76cd8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2655,6 +2655,16 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	mgmt_pending_remove(cmd);
 }
 
+void mgmt_smp_complete(struct hci_conn *conn, bool complete)
+{
+	u8 status = complete ? MGMT_STATUS_SUCCESS : MGMT_STATUS_FAILED;
+	struct pending_cmd *cmd;
+
+	cmd = find_pairing(conn);
+	if (cmd)
+		pairing_complete(cmd, status);
+}
+
 static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -2668,7 +2678,7 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 		pairing_complete(cmd, mgmt_status(status));
 }
 
-static void le_connect_complete_cb(struct hci_conn *conn, u8 status)
+static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
 {
 	struct pending_cmd *cmd;
 
@@ -2755,13 +2765,16 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	/* For LE, just connecting isn't a proof that the pairing finished */
-	if (cp->addr.type == BDADDR_BREDR)
+	if (cp->addr.type == BDADDR_BREDR) {
 		conn->connect_cfm_cb = pairing_complete_cb;
-	else
-		conn->connect_cfm_cb = le_connect_complete_cb;
+		conn->security_cfm_cb = pairing_complete_cb;
+		conn->disconn_cfm_cb = pairing_complete_cb;
+	} else {
+		conn->connect_cfm_cb = le_pairing_complete_cb;
+		conn->security_cfm_cb = le_pairing_complete_cb;
+		conn->disconn_cfm_cb = le_pairing_complete_cb;
+	}
 
-	conn->security_cfm_cb = pairing_complete_cb;
-	conn->disconn_cfm_cb = pairing_complete_cb;
 	conn->io_capability = cp->io_cap;
 	cmd->user_data = conn;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b6a2a8942b2d..27eebca260fa 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -565,9 +565,13 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 void smp_chan_destroy(struct l2cap_conn *conn)
 {
 	struct smp_chan *smp = conn->smp_chan;
+	bool complete;
 
 	BUG_ON(!smp);
 
+	complete = test_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
+	mgmt_smp_complete(conn->hcon, complete);
+
 	kfree(smp);
 	conn->smp_chan = NULL;
 	conn->hcon->smp_conn = NULL;
@@ -1187,6 +1191,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 	if (conn->hcon->out || force || !(rsp->init_key_dist & 0x07)) {
 		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags);
 		cancel_delayed_work_sync(&conn->security_timer);
+		set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
 		smp_chan_destroy(conn);
 	}
 
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 8f54c9b152de..675fd3b21d2c 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -118,6 +118,7 @@ struct smp_cmd_security_req {
 #define SMP_FLAG_TK_VALID	1
 #define SMP_FLAG_CFM_PENDING	2
 #define SMP_FLAG_MITM_AUTH	3
+#define SMP_FLAG_COMPLETE	4
 
 struct smp_chan {
 	struct l2cap_conn *conn;
-- 
1.8.5.3

