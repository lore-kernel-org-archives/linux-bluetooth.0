Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:34:47 +0800
Message-ID: <AANLkTikHKgHHv4Rg8tF4JPm6z9czNQN-JsWa8D2PhQwb@mail.gmail.com>
Subject: [PATCH 10/22] Add new configuration states for state machine of configuration
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From bc3e50d857279661e84ddadd4bf99de1290b5601 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Sun, 22 Aug 2010 23:54:19 +0800
Subject: [PATCH 10/22] Add new configuration states for state machine
of configuration.

---
 include/net/bluetooth/l2cap.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c609e04..4a18567 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -415,6 +415,10 @@ struct l2cap_pinfo {
 #define L2CAP_CONF_CONNECT_PEND   0x20
 #define L2CAP_CONF_NO_FCS_RECV    0x40
 #define L2CAP_CONF_STATE2_DEVICE  0x80
+#define L2CAP_CONF_LOCAL_PEND		0x100
+#define L2CAP_CONF_REMOTE_PEND		0x200
+#define L2CAP_CONF_EXTFLOWSPEC_DONE	0x400
+#define L2CAP_CONF_EXTWINSIZE_DONE	0x800

 #define L2CAP_CONF_MAX_CONF_REQ 2
 #define L2CAP_CONF_MAX_CONF_RSP 2
-- 
1.6.3.3
