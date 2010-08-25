Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:36:57 +0800
Message-ID: <AANLkTi=Cp0pe2r9bQ7zpw21_BF=K+df824-6AoMvPH3Q@mail.gmail.com>
Subject: [PATCH 15/22] Enlarge value scope of conf_state in l2cap_pinfo to
 hold new states for lock step configuration
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From ff97115044570dae7e88dd665a0e82d6b542da5b Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Mon, 23 Aug 2010 00:05:43 +0800
Subject: [PATCH 15/22] Enlarge value scope of conf_state in
l2cap_pinfo to hold new states for lock step configuration.

---
 include/net/bluetooth/l2cap.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7a9bec4..2d864d4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -378,7 +378,7 @@ struct l2cap_pinfo {

 	__u8		conf_req[64];
 	__u8		conf_len;
-	__u8		conf_state;
+	__u16		conf_state;
 	__u16		conn_state;

 	__u8		next_tx_seq;
-- 
1.6.3.3
