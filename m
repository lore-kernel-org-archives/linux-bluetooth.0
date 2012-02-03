Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 5/7] Bluetooth: Add support for removing LTK's when pairing is removed
Date: Thu,  2 Feb 2012 21:08:03 -0300
Message-Id: <1328227685-27245-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of having a separated command for removing SMP keys, we use the
Remove Keys command to remove *all* keys.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d1433de..4d9c8ce 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1089,6 +1089,12 @@ static int remove_keys(struct sock *sk, u16 index, void *cp_data, u16 len)
 	bacpy(&rp.bdaddr, &cp->bdaddr);
 	rp.status = MGMT_STATUS_FAILED;
 
+	err = hci_remove_ltk(hdev, &cp->bdaddr);
+	if (err < 0) {
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_KEYS, -err);
+		goto unlock;
+	}
+
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0) {
 		rp.status = MGMT_STATUS_NOT_PAIRED;
-- 
1.7.8.1

