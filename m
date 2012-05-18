Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 22/25] Bluetooth: Remove unneccesary inline
Date: Thu, 17 May 2012 20:53:52 -0700
Message-Id: <1337313235-26535-23-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Let the compiler decide if inlining is appropriate.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index afb7afc..5faddba 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4396,7 +4396,7 @@ static int l2cap_check_fcs(struct l2cap_chan *chan,  struct sk_buff *skb)
 	return 0;
 }
 
-static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
+static void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 {
 	struct l2cap_ctrl control;
 
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
