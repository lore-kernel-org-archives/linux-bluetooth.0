Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: jrg.otte@gmail.com, torvalds@linux-foundation.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hidp: Fix regression with older userspace and flags validation
Date: Fri, 17 Apr 2015 22:34:18 +0200
Message-Id: <1429302858-44595-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While it is not used by newer userspace anymore, the older userspace was
utilizing HIDP_VIRTUAL_CABLE_UNPLUG and HIDP_BOOT_PROTOCOL_MODE flags
when adding a new HIDP connection.

The flags validation is important, but we can not break older userspace
and with that allow providing these flags even if newer userspace does
not use them anymore.

Reported-by: Jörg Otte <jrg.otte@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index a05b9dbf14c9..9070dfd6b4ad 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1313,7 +1313,8 @@ int hidp_connection_add(struct hidp_connadd_req *req,
 			struct socket *ctrl_sock,
 			struct socket *intr_sock)
 {
-	u32 valid_flags = 0;
+	u32 valid_flags = BIT(HIDP_VIRTUAL_CABLE_UNPLUG) |
+			  BIT(HIDP_BOOT_PROTOCOL_MODE);
 	struct hidp_session *session;
 	struct l2cap_conn *conn;
 	struct l2cap_chan *chan;
-- 
2.1.0

