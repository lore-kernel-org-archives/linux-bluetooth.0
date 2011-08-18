Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 3/7] Bluetooth: EFS: add disable_flowspec kernel param
Date: Thu, 18 Aug 2011 10:44:58 +0300
Message-Id: <1313653502-6303-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1313653502-6303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1313653502-6303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make extended flowspec option kernel parameter. Disabled by default.
---
 net/bluetooth/l2cap_core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index be30c32..4167cb0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -57,6 +57,7 @@
 #include <net/bluetooth/smp.h>
 
 int disable_ertm;
+int disable_flowspec = 1;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
@@ -2775,6 +2776,9 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 		if (!disable_ertm)
 			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING
 							 | L2CAP_FEAT_FCS;
+		if (!disable_flowspec)
+			feat_mask |= L2CAP_FEAT_EXT_FLOW;
+
 		put_unaligned_le32(feat_mask, rsp->data);
 		l2cap_send_cmd(conn, cmd->ident,
 					L2CAP_INFO_RSP, sizeof(buf), buf);
@@ -4296,3 +4300,6 @@ void l2cap_exit(void)
 
 module_param(disable_ertm, bool, 0644);
 MODULE_PARM_DESC(disable_ertm, "Disable enhanced retransmission mode");
+
+module_param(disable_flowspec, bool, 0644);
+MODULE_PARM_DESC(disable_flowspec, "Disable Extended Flow Specification");
-- 
1.7.4.1

