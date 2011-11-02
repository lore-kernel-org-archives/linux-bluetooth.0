Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	Andrei.Emeltchenko.news@gmail.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv4 6/9] Bluetooth: Add definitions for L2CAP fixed channels
Date: Wed,  2 Nov 2011 16:18:33 -0700
Message-Id: <1320275916-32103-7-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1320275916-32103-1-git-send-email-mathewm@codeaurora.org>
References: <1320275916-32103-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Symbolic fixed channel IDs will be used instead of magic numbers.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f822ab9..7f5c854 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -122,6 +122,10 @@ struct l2cap_conninfo {
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
1.7.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
