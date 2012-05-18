Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 23/25] Bluetooth: Set txwin values for streaming mode
Date: Thu, 17 May 2012 20:53:53 -0700
Message-Id: <1337313235-26535-24-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
References: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The transmit window values must be configured for streaming mode, even
though streaming mode does not have a window.  This enables use of
extended headers when the transmit window socket option is set to 64
or larger.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5faddba..1a0f942 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2938,6 +2938,7 @@ done:
 		break;
 
 	case L2CAP_MODE_STREAMING:
+		l2cap_txwin_setup(chan);
 		rfc.mode            = L2CAP_MODE_STREAMING;
 		rfc.txwin_size      = 0;
 		rfc.max_transmit    = 0;
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
