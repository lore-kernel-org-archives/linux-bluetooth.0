Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:35:34 +0800
Message-ID: <AANLkTikAZBO6dka+yN3tFTZekm9+1nzo3=OZEoxZ1Eab@mail.gmail.com>
Subject: [PATCH 12/22] Add some default values for configuration process
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 2d21459fa52b754ce0f666ccefc0175bc7f04420 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Sun, 22 Aug 2010 23:57:09 +0800
Subject: [PATCH 12/22] Add some default values for configuration process.

---
 include/net/bluetooth/l2cap.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fe411e2..d0ae9f5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -36,6 +36,11 @@
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	672
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_LOCAL_BUSY_TRIES		12
+#define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
+#define L2CAP_DEFAULT_SDU_ARRIVAL_TIME	0xFFFFFFFF
+#define L2CAP_DEFAULT_FLUSH_TIMEOUT	0xFFFFFFFF
+#define L2CAP_DEFAULT_ACCESS_LATENCY	0xFFFFFFFF
+#define L2CAP_DEFAULT_EXT_WINSIZE	1024

 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_CONFIG_TIMEOUT	(40000) /* 40 seconds */
-- 
1.6.3.3
