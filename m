Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: remove magic offset and size
Date: Thu, 20 Oct 2011 17:02:44 +0300
Message-Id: <1319119364-2185-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

make code readable by removing magic numbers

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bda6da7..ded2068 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2977,7 +2977,7 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 		struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
 		rsp->type   = cpu_to_le16(L2CAP_IT_FIXED_CHAN);
 		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
-		memcpy(buf + 4, l2cap_fixed_chan, 8);
+		memcpy(rsp->data, l2cap_fixed_chan, sizeof(l2cap_fixed_chan));
 		l2cap_send_cmd(conn, cmd->ident,
 					L2CAP_INFO_RSP, sizeof(buf), buf);
 	} else {
-- 
1.7.4.1

