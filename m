Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 16 Sep 2010 15:15:18 +0800
Message-ID: <AANLkTi=86t=osr8YUfUfU3QLHiHXgp8SCuwqOE_GoPgp@mail.gmail.com>
Subject: [PATCH] Bluetooth: Replace hard code of fixed channels bit mask
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mat Martineau <mathewm@codeaurora.org>,
	"dantian.ip" <dantian.ip@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add fixed channels bit mask definition for
 		L2CAP_FIXCHAN_NULLID
 		L2CAP_FIXCHAN_SIGNAL
 		L2CAP_FIXCHAN_CONNLESS
 		L2CAP_FIXCHAN_A2MP
And replace hard code in source file with the macro.

Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
---
 include/net/bluetooth/l2cap.h |    6 ++++++
 net/bluetooth/l2cap.c         |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6c24144..e4fe2c7 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -97,6 +97,12 @@ struct l2cap_conninfo {
 #define L2CAP_FEAT_FCS		0x00000020
 #define L2CAP_FEAT_FIXED_CHAN	0x00000080

+/* L2CAP fixed channel bitmask */
+#define L2CAP_FIXCHAN_NULLID	0x00
+#define L2CAP_FIXCHAN_SIGNAL	0x02
+#define L2CAP_FIXCHAN_CONNLESS	0x04
+#define L2CAP_FIXCHAN_A2MP	0x08
+
 /* L2CAP checksum option */
 #define L2CAP_FCS_NONE		0x00
 #define L2CAP_FCS_CRC16		0x01
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index c784703..23e487e 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -60,7 +60,7 @@
 static int disable_ertm = 0;

 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
-static u8 l2cap_fixed_chan[8] = { 0x02, };
+static u8 l2cap_fixed_chan[8] = { L2CAP_FIXCHAN_SIGNAL, };

 static const struct proto_ops l2cap_sock_ops;

-- 
1.6.3.3
