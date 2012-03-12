Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/6] Bluetooth: Convert error codes to le16
Date: Mon, 12 Mar 2012 12:13:09 +0200
Message-Id: <1331547191-15307-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Create Chan Rsp shall put result and status in le format.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c778585..57c8507 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3263,8 +3263,8 @@ static inline int l2cap_create_channel_req(struct l2cap_conn *conn,
 	/* Placeholder: Always reject */
 	rsp.dcid = 0;
 	rsp.scid = cpu_to_le16(scid);
-	rsp.result = L2CAP_CR_NO_MEM;
-	rsp.status = L2CAP_CS_NO_INFO;
+	rsp.result = __constant_cpu_to_le16(L2CAP_CR_NO_MEM);
+	rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
 
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CREATE_CHAN_RSP,
 		       sizeof(rsp), &rsp);
-- 
1.7.9

