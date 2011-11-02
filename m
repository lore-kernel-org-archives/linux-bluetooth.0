Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	Andrei.Emeltchenko.news@gmail.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv4 7/9] Bluetooth: Use symbolic values for the fixed channel map
Date: Wed,  2 Nov 2011 16:18:34 -0700
Message-Id: <1320275916-32103-8-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1320275916-32103-1-git-send-email-mathewm@codeaurora.org>
References: <1320275916-32103-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The A2MP fixed channel bit is only set when high-speed mode is enabled.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2a49cf3..b27b061 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -60,7 +60,7 @@ int disable_ertm;
 int enable_hs;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
-static u8 l2cap_fixed_chan[8] = { 0x02, };
+static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP, };
 
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
@@ -3032,6 +3032,12 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 	} else if (type == L2CAP_IT_FIXED_CHAN) {
 		u8 buf[12];
 		struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
+
+		if (enable_hs)
+			l2cap_fixed_chan[0] |= L2CAP_FC_A2MP;
+		else
+			l2cap_fixed_chan[0] &= ~L2CAP_FC_A2MP;
+
 		rsp->type   = cpu_to_le16(L2CAP_IT_FIXED_CHAN);
 		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
 		memcpy(rsp->data, l2cap_fixed_chan, sizeof(l2cap_fixed_chan));
-- 
1.7.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
