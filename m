Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:30:26 +0800
Message-ID: <AANLkTimuDaRdwwzUs8SedHa4V9BXD+r3JTeHB7KXpZB5@mail.gmail.com>
Subject: [PATCH 04/22] Add L2CAP_CID_A2MP_CHAN definition, it's fixed channel 3
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From cfa4ccc6baa017ffb3deea50286467de03176632 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Sun, 22 Aug 2010 23:35:19 +0800
Subject: [PATCH 04/22] Add L2CAP_CID_A2MP_CHAN definition, it's fixed channel 3.

---
 include/net/bluetooth/l2cap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 39f8118..0d48e61 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -174,6 +174,7 @@ struct l2cap_conn_rsp {
 /* channel indentifier */
 #define L2CAP_CID_SIGNALING	0x0001
 #define L2CAP_CID_CONN_LESS	0x0002
+#define L2CAP_CID_A2MP_CHAN	0x0003
 #define L2CAP_CID_DYN_START	0x0040
 #define L2CAP_CID_DYN_END	0xffff

-- 
1.6.3.3
