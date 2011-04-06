Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 12/15] Bluetooth: Update the security level when link is encrypted
Date: Tue,  5 Apr 2011 22:51:53 -0300
Message-Id: <1302054716-24534-13-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
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
index 28e03e2..e0e690a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -712,6 +712,9 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status, __u8 encr
 	if (conn->sec_level == BT_SECURITY_SDP)
 		conn->sec_level = BT_SECURITY_LOW;
 
+	if (conn->pending_sec_level > conn->sec_level)
+		conn->sec_level = conn->pending_sec_level;
+
 	hci_proto_encrypt_cfm(conn, status, encrypt);
 
 	read_lock_bh(&hci_cb_list_lock);
-- 
1.7.4.1

