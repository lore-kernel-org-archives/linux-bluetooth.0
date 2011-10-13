Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 6/9] Bluetooth: Add definitions for L2CAP fixed channels
Date: Thu, 13 Oct 2011 15:00:44 -0700
Message-Id: <1318543247-27130-7-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Symbolic fixed channel IDs will be used instead of magic numbers.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2ea0d15..e5d860e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -114,6 +114,10 @@ struct l2cap_conninfo {
 #define L2CAP_FCS_NONE		0x00
 #define L2CAP_FCS_CRC16		0x01
 
+/* L2CAP fixed channels */
+#define L2CAP_FC_L2CAP		0x02
+#define L2CAP_FC_A2MP		0x08
+
 /* L2CAP Control Field bit masks */
 #define L2CAP_CTRL_SAR			0xC000
 #define L2CAP_CTRL_REQSEQ		0x3F00
-- 
1.7.7

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

