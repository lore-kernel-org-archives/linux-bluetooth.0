Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv2 7/9] Bluetooth: Use symbolic values for the fixed channel map
Date: Wed, 19 Oct 2011 10:44:05 -0700
Message-Id: <1319046247-3391-8-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The A2MP fixed channel bit is only set when high-speed mode is enabled.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 67f0ab6..f250392 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -60,7 +60,7 @@ int disable_ertm;
 int enable_hs;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
-static u8 l2cap_fixed_chan[8] = { 0x02, };
+static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP, };
 
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
@@ -2975,6 +2975,10 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 	} else if (type == L2CAP_IT_FIXED_CHAN) {
 		u8 buf[12];
 		struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
+
+		if (enable_hs)
+			l2cap_fixed_chan[0] |= L2CAP_FC_A2MP;
+
 		rsp->type   = cpu_to_le16(L2CAP_IT_FIXED_CHAN);
 		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
 		memcpy(buf + 4, l2cap_fixed_chan, 8);
-- 
1.7.7

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

