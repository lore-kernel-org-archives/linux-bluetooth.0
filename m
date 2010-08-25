Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:31:35 +0800
Message-ID: <AANLkTimKs9pVuKc4A-a-OKLoc-h1OC6+E9HUR1O1CE8n@mail.gmail.com>
Subject: [PATCH 06/22] Add two new configuration status definition
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 8bfa66f68795e697e23cf4efe8fa7d2d135c176c Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Sun, 22 Aug 2010 23:41:02 +0800
Subject: [PATCH 06/22] Add two new configuration status definition.

---
 include/net/bluetooth/l2cap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fe95a63..9df9d70 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -207,6 +207,8 @@ struct l2cap_conf_rsp {
 #define L2CAP_CONF_UNACCEPT	0x0001
 #define L2CAP_CONF_REJECT	0x0002
 #define L2CAP_CONF_UNKNOWN	0x0003
+#define L2CAP_CONF_PENDING	0x0004
+#define L2CAP_CONF_FLOWSPEC_REJECT	0x0005

 struct l2cap_conf_opt {
 	__u8       type;
-- 
1.6.3.3
