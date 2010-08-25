Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:34:15 +0800
Message-ID: <AANLkTimviXXMxpYoKKY7xxy_XgQ2Bxh9BravEuix+jTv@mail.gmail.com>
Subject: [PATCH 09/22] Add candidate values for service type
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 7e080dd0ad217e69b3abd614a981a861febbefa8 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Sun, 22 Aug 2010 23:50:53 +0800
Subject: [PATCH 09/22] Add candidate values for service type.

---
 include/net/bluetooth/l2cap.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4bbc1ff..c609e04 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -256,6 +256,10 @@ struct l2cap_conf_efs {
 #define L2CAP_MODE_ERTM		0x03
 #define L2CAP_MODE_STREAMING	0x04

+#define L2CAP_SERVTYPE_NOTRAFIC		0x00
+#define L2CAP_SERVTYPE_BESTEFFORT	0x01
+#define L2CAP_SERVTYPE_GUARANTEED	0x02
+
 struct l2cap_disconn_req {
 	__le16     dcid;
 	__le16     scid;
-- 
1.6.3.3
