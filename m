Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:35:11 +0800
Message-ID: <AANLkTinscqG8E_wen5zm-fmN5cbN6kBNZxOPmc-w8b_N@mail.gmail.com>
Subject: [PATCH 11/22] Add two timeout values for configuration process
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 92a177d2d601c4ed502d3b1f618dfbe3084d01cb Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Sun, 22 Aug 2010 23:55:44 +0800
Subject: [PATCH 11/22] Add two timeout values for configuration process.

---
 include/net/bluetooth/l2cap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4a18567..fe411e2 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -38,6 +38,8 @@
 #define L2CAP_LOCAL_BUSY_TRIES		12

 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
+#define L2CAP_CONFIG_TIMEOUT	(40000) /* 40 seconds */
+#define L2CAP_PENDING_TIMEOUT	(120000) /* 120 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */

 /* L2CAP socket address */
-- 
1.6.3.3
