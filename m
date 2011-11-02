Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	Andrei.Emeltchenko.news@gmail.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv4 2/9] Bluetooth: Change scope of the enable_hs module parameter
Date: Wed,  2 Nov 2011 16:18:29 -0700
Message-Id: <1320275916-32103-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1320275916-32103-1-git-send-email-mathewm@codeaurora.org>
References: <1320275916-32103-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This variable is currently only accessible within l2cap_core.c, but
it is also needed in l2cap_sock.c

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5a0a9c8..77df95e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -736,6 +736,7 @@ static inline __u8 __ctrl_size(struct l2cap_chan *chan)
 }
 
 extern int disable_ertm;
+extern int enable_hs;
 
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
-- 
1.7.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
