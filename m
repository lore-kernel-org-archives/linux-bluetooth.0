Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv2 2/9] Bluetooth: Change scope of the enable_hs module parameter
Date: Wed, 19 Oct 2011 10:44:00 -0700
Message-Id: <1319046247-3391-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This variable is currently only accessible within l2cap_core.c, but
it is also needed in l2cap_sock.c

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fddc82a..fd090db 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -730,6 +730,7 @@ static inline __u8 __ctrl_size(struct l2cap_chan *chan)
 }
 
 extern int disable_ertm;
+extern int enable_hs;
 
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
-- 
1.7.7

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

