Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 1/5] Bluetooth: Add address type to struct sockaddr_l2
Date: Wed,  4 Apr 2012 17:16:06 -0300
Message-Id: <1333570570-1288-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1333570570-1288-1-git-send-email-andre.guedes@openbossa.org>
References: <1333570570-1288-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the address type info to struct sockaddr_l2 so
user-space can inform the remote device address type required
to establish LE connections.

Soon, instead of looking the advertising cache up to discover the
address type, we'll use this address type info to establish LE
connections.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/l2cap.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f6f0500..d14967e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -57,6 +57,7 @@ struct sockaddr_l2 {
 	__le16		l2_psm;
 	bdaddr_t	l2_bdaddr;
 	__le16		l2_cid;
+	__u8		l2_bdaddr_type;
 };
 
 /* L2CAP socket options */
-- 
1.7.9.4

