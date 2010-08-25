Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:33:12 +0800
Message-ID: <AANLkTikgORpWLPaantEF_CBnKG4qHohm=qYCD6dp5ewd@mail.gmail.com>
Subject: [PATCH 07/22] Add a candidate value definition for flag of
 configuration response packet
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 27541871ae9d3a2a510349bae155a63e8adf91f0 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Sun, 22 Aug 2010 23:46:58 +0800
Subject: [PATCH 07/22] Add a candidate value definition for flag of
configuration response packet.

---
 include/net/bluetooth/l2cap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9df9d70..a1931ae 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -210,6 +210,8 @@ struct l2cap_conf_rsp {
 #define L2CAP_CONF_PENDING	0x0004
 #define L2CAP_CONF_FLOWSPEC_REJECT	0x0005

+#define L2CAP_CONF_FLAG_CONT	0x0001
+
 struct l2cap_conf_opt {
 	__u8       type;
 	__u8       len;
-- 
1.6.3.3
