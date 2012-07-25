Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 13/21] Bluetooth: Indentation fixes
Date: Wed, 25 Jul 2012 16:51:05 -0700
Message-Id: <1343260274-11953-14-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bc56f09..d981d87 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4133,8 +4133,8 @@ static void l2cap_send_move_chan_rsp(struct l2cap_conn *conn, u8 ident,
 }
 
 static void l2cap_send_move_chan_cfm(struct l2cap_conn *conn,
-				     struct l2cap_chan *chan,
-				     u16 icid, u16 result)
+				     struct l2cap_chan *chan, u16 icid,
+				     u16 result)
 {
 	struct l2cap_move_chan_cfm cfm;
 	u8 ident;
-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
