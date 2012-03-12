Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/6] Bluetooth: Correct length calc in L2CAP conf rsp
Date: Mon, 12 Mar 2012 12:13:07 +0200
Message-Id: <1331547191-15307-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

cmd->len is in le format so convert it to host format before use.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0eca14d..85c3404 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2955,14 +2955,14 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
 	u16 scid, flags, result;
 	struct l2cap_chan *chan;
-	int len = cmd->len - sizeof(*rsp);
+	int len = le16_to_cpu(cmd->len) - sizeof(*rsp);
 
 	scid   = __le16_to_cpu(rsp->scid);
 	flags  = __le16_to_cpu(rsp->flags);
 	result = __le16_to_cpu(rsp->result);
 
-	BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x",
-			scid, flags, result);
+	BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x len %d",
+			scid, flags, result, len);
 
 	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan)
-- 
1.7.9

