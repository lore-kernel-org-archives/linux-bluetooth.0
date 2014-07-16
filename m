Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't bother user space without IO capabilities
Date: Wed, 16 Jul 2014 15:09:13 +0300
Message-Id: <1405512553-15781-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If user space has a NoInputNoOutput IO capability it makes no sense to
bother it with confirmation requests. This patch updates both SSP and
SMP to check for the local IO capability before sending a user
confirmation request to user space.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 4 +++-
 net/bluetooth/smp.c       | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e54db7f0590b..ceaffd681f8b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3753,9 +3753,11 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 		/* If we're not the initiators request authorization to
 		 * proceed from user space (mgmt_user_confirm with
 		 * confirm_hint set to 1). The exception is if neither
-		 * side had MITM in which case we do auto-accept.
+		 * side had MITM or if the local IO capability is
+		 * NoInputNoOutput, in which case we do auto-accept
 		 */
 		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
+		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
 		    (loc_mitm || rem_mitm)) {
 			BT_DBG("Confirming auto-accept as acceptor");
 			confirm_hint = 1;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 70b726518d7b..74a0308e39f3 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -431,6 +431,10 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	if (method == JUST_CFM && test_bit(SMP_FLAG_INITIATOR, &smp->flags))
 		method = JUST_WORKS;
 
+	/* Don't bother user space with no IO capabilities */
+	if (method == JUST_CFM && hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
+		method = JUST_WORKS;
+
 	/* If Just Works, Continue with Zero TK */
 	if (method == JUST_WORKS) {
 		set_bit(SMP_FLAG_TK_VALID, &smp->flags);
-- 
1.9.3

