Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:39:17 +0800
Message-ID: <AANLkTinAMmdrjvBGmzjhroC2QjXFe-_+hNmDf_YN_hmB@mail.gmail.com>
Subject: [PATCH 18/22] Add physical link status definition
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 45246346bed4c351f61b6c71002dccaff88be6ac Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Mon, 23 Aug 2010 00:20:59 +0800
Subject: [PATCH 18/22] Add physical link status definition.

---
 include/net/bluetooth/l2cap.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f2dd65d..f91111c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -299,6 +299,11 @@ struct l2cap_info_rsp {
 #define L2CAP_IR_SUCCESS    0x0000
 #define L2CAP_IR_NOTSUPP    0x0001

+/* physical link status */
+#define L2CAP_PHYLINK_NOAVL	0x0000
+#define L2CAP_PHYLINK_CREATING	0x0001
+#define L2CAP_PHYLINK_READY	0x0002
+
 /* ----- L2CAP connections ----- */
 struct l2cap_chan_list {
 	struct sock	*head;
-- 
1.6.3.3
