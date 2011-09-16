Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/7] Bluetooth: EFS: add enable_hs kernel param
Date: Fri, 16 Sep 2011 16:26:32 +0300
Message-Id: <1316179596-30906-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1316179596-30906-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1316179596-30906-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add enable_hs kernel parameter. L2CAP_FEAT_EXT_FLOW depends on it.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ebe2703..4b05248 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -57,6 +57,7 @@
 #include <net/bluetooth/smp.h>
 
 int disable_ertm;
+int enable_hs;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
@@ -2780,6 +2781,9 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 		if (!disable_ertm)
 			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING
 							 | L2CAP_FEAT_FCS;
+		if (enable_hs)
+			feat_mask |= L2CAP_FEAT_EXT_FLOW;
+
 		put_unaligned_le32(feat_mask, rsp->data);
 		l2cap_send_cmd(conn, cmd->ident,
 					L2CAP_INFO_RSP, sizeof(buf), buf);
@@ -4304,3 +4308,6 @@ void l2cap_exit(void)
 
 module_param(disable_ertm, bool, 0644);
 MODULE_PARM_DESC(disable_ertm, "Disable enhanced retransmission mode");
+
+module_param(enable_hs, bool, 0644);
+MODULE_PARM_DESC(enable_hs, "Enable High Speed");
-- 
1.7.4.1

