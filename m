Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:29:41 +0800
Message-ID: <AANLkTim6D9y4zRUerhbKcT8_j++H-=XNkt7p5eNCPnTC@mail.gmail.com>
Subject: [PATCH 03/22] Add eL2cap fixed channel bitmask definition
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 7cee9cfecbe626a5671db96c30d4e60b69f0d191 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Wed, 18 Aug 2010 22:34:56 +0800
Subject: [PATCH 03/22] Add eL2cap fixed channel bitmask definition.

---
 include/net/bluetooth/l2cap.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2e782d0..39f8118 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -105,6 +105,12 @@ struct l2cap_conninfo {
 #define L2CAP_FEAT_UCDR		0x00000200
 #define L2CAP_FEAT_RESERVED	0x80000000

+/* L2CAP fixed channel bitmask */
+#define L2CAP_FIXCHAN_NULLID	0x01
+#define L2CAP_FIXCHAN_SIG	0x02
+#define L2CAP_FIXCHAN_CL	0x04
+#define L2CAP_FIXCHAN_A2MP	0x08
+
 /* L2CAP checksum option */
 #define L2CAP_FCS_NONE		0x00
 #define L2CAP_FCS_CRC16		0x01
-- 
1.6.3.3
