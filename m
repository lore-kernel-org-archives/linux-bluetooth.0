Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 1/4] Bluetooth: Restore accidentally-deleted line
Date: Fri,  3 Jun 2011 16:21:07 -0700
Message-Id: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When code was moved from l2cap_core.c to l2cap_sock.c in commit
6de0702b5b93da0ef097aa092b4597fbc024ebba, one line was dropped
from the old __l2cap_sock_close() implementation. This sk_state
change should still be in l2cap_chan_close().

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 15e6a53..dc5c654 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -435,6 +435,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 				result = L2CAP_CR_SEC_BLOCK;
 			else
 				result = L2CAP_CR_BAD_PSM;
+			sk->sk_state = BT_DISCONN;
 
 			rsp.scid   = cpu_to_le16(chan->dcid);
 			rsp.dcid   = cpu_to_le16(chan->scid);
-- 
1.7.5.2


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

