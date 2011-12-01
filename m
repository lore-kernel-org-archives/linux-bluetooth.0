Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 7/8] Bluetooth: Use SNIFF mode only for BREDR controller
Date: Thu,  1 Dec 2011 14:42:14 +0200
Message-Id: <1322743335-8671-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 net/bluetooth/hci_conn.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b328ac6..beb280e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -749,6 +749,9 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 	if (test_bit(HCI_RAW, &hdev->flags))
 		return;
 
+	if (hdev->dev_type != HCI_BREDR)
+		return;
+
 	if (conn->mode != HCI_CM_SNIFF)
 		goto timer;
 
@@ -783,6 +786,9 @@ void hci_conn_enter_sniff_mode(struct hci_conn *conn)
 	if (conn->mode != HCI_CM_ACTIVE || !(conn->link_policy & HCI_LP_SNIFF))
 		return;
 
+	if (hdev->dev_type != HCI_BREDR)
+		return;
+
 	if (lmp_sniffsubr_capable(hdev) && lmp_sniffsubr_capable(conn)) {
 		struct hci_cp_sniff_subrate cp;
 		cp.handle             = cpu_to_le16(conn->handle);
-- 
1.7.4.1

