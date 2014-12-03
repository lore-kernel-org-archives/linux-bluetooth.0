Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/49] Bluetooth: Set link key generation bit if necessary for LE SC
Date: Wed,  3 Dec 2014 17:02:06 +0200
Message-Id: <1417618963-18010-13-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Depending on whether Secure Connections is enabled or not we may need to add
the link key generation bit to the key distribution. This patch does the
necessary modifications to the build_pairing_cmd() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0973e37073e2..d993d7d4fcc8 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -333,6 +333,16 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
 		local_dist |= SMP_DIST_ID_KEY;
 
+	if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
+		if ((authreq & SMP_AUTH_SC) &&
+		    test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+			local_dist |= SMP_DIST_LINK_KEY;
+			remote_dist |= SMP_DIST_LINK_KEY;
+		}
+	} else {
+		authreq &= ~SMP_AUTH_SC;
+	}
+
 	if (rsp == NULL) {
 		req->io_capability = conn->hcon->io_capability;
 		req->oob_flag = SMP_OOB_NOT_PRESENT;
-- 
2.1.0

