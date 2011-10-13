Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 2/9] Bluetooth: Add AMP policy information to l2cap_chan
Date: Thu, 13 Oct 2011 15:00:40 -0700
Message-Id: <1318543247-27130-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Each channel has an active AMP policy to require BR/EDR (the default),
prefer AMP, or prefer BR/EDR.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 806b950..e77d39f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -357,6 +357,7 @@ struct l2cap_chan {
 	__u8		num_conf_rsp;
 
 	__u8		fcs;
+	__u8		amp_policy;
 
 	__u16		tx_win;
 	__u8		max_tx;
-- 
1.7.7

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

