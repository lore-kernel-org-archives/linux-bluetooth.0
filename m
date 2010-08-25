Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:27:35 +0800
Message-ID: <AANLkTi=qOgovmY3s3PcS4tGb59HUhxx-Qydr2NyNs9Me@mail.gmail.com>
Subject: [PATCH 02/22] Add eL2cap new features macro definition
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From fb2a4d17435dbd6d8787e6928c1da4f12a839265 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Wed, 18 Aug 2010 22:33:22 +0800
Subject: [PATCH 02/22] Add eL2cap new features macro definition.

---
 include/net/bluetooth/l2cap.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index bf0ea10..2e782d0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -99,7 +99,11 @@ struct l2cap_conninfo {
 #define L2CAP_FEAT_ERTM		0x00000008
 #define L2CAP_FEAT_STREAMING	0x00000010
 #define L2CAP_FEAT_FCS		0x00000020
+#define L2CAP_FEAT_EFS_BREDR	0x00000040
 #define L2CAP_FEAT_FIXED_CHAN	0x00000080
+#define L2CAP_FEAT_EXT_WINSIZE	0x00000100
+#define L2CAP_FEAT_UCDR		0x00000200
+#define L2CAP_FEAT_RESERVED	0x80000000

 /* L2CAP checksum option */
 #define L2CAP_FCS_NONE		0x00
-- 
1.6.3.3
