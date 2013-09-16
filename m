Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/8] Bluetooth: Fix double error response for l2cap_create_chan_req
Date: Mon, 16 Sep 2013 13:05:13 +0300
Message-Id: <1379325919-19003-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com>
References: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When an L2CAP request handler returns non-zero the calling code will
send a command reject response. The l2cap_create_chan_req function will
in some cases send its own response but then still return a -EFAULT
error which would cause two responses to be sent. This patch fixes this
by making the function return 0 after sending its own response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b3bb7bc..0b8a270 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4462,7 +4462,7 @@ error:
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
 		       sizeof(rsp), &rsp);
 
-	return -EFAULT;
+	return 0;
 }
 
 static void l2cap_send_move_chan_req(struct l2cap_chan *chan, u8 dest_amp_id)
-- 
1.8.4.rc3

