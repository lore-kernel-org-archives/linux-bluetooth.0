Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 12/15] Bluetooth: Update the security level when link is encrypted
Date: Mon, 21 Feb 2011 14:23:59 -0300
Message-Id: <d61523d4112fdc90c4f84cac6762990b1d76f20e.1298307667.git.vinicius.gomes@openbossa.org>
In-Reply-To: <cover.1298307667.git.vinicius.gomes@openbossa.org>
References: <cover.1298307667.git.vinicius.gomes@openbossa.org>
In-Reply-To: <cover.1298307667.git.vinicius.gomes@openbossa.org>
References: <cover.1298307667.git.vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the pending security level is greater than the current security
level and the link is now encrypted, we should update the link
security level.

This is only useful for LE links, when the only event generated
when SMP is sucessful in the Encrypt Change event.
---
 include/net/bluetooth/hci_core.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aeae4b4..c949073 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -679,6 +679,9 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status, __u8 encr
 	if (conn->sec_level == BT_SECURITY_SDP)
 		conn->sec_level = BT_SECURITY_LOW;
 
+	if (conn->pending_sec_level > conn->sec_level)
+		conn->sec_level = conn->pending_sec_level;
+
 	hci_proto_encrypt_cfm(conn, status, encrypt);
 
 	read_lock_bh(&hci_cb_list_lock);
-- 
1.7.4.1

