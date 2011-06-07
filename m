Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next v3 12/16] Bluetooth: Update the security level when link is encrypted
Date: Tue,  7 Jun 2011 18:46:41 -0300
Message-Id: <1307483205-1518-13-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the pending security level is greater than the current security
level and the link is now encrypted, we should update the link
security level.

This is only useful for LE links, when the only event generated
when SMP is sucessful in the Encrypt Change event.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2f1c91a..13e5b48 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -734,6 +734,9 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status, __u8 encr
 	if (conn->sec_level == BT_SECURITY_SDP)
 		conn->sec_level = BT_SECURITY_LOW;
 
+	if (conn->pending_sec_level > conn->sec_level)
+		conn->sec_level = conn->pending_sec_level;
+
 	hci_proto_encrypt_cfm(conn, status, encrypt);
 
 	read_lock_bh(&hci_cb_list_lock);
-- 
1.7.5.4

