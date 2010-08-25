Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:38:27 +0800
Message-ID: <AANLkTinaFobBK5OiFaV+fGsEe3JRTy7_dT-FFLjSt-Rq@mail.gmail.com>
Subject: [PATCH 17/22] Add parameter enable_highspeed to control highspeed
 code in running phase
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From c3fba9b5d7546576d9eb1d30eb45c453c8ee1dff Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Mon, 23 Aug 2010 00:17:24 +0800
Subject: [PATCH 17/22] Add parameter enable_highspeed to control
highspeed code in running phase.

---
 net/bluetooth/l2cap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 449cbdd..e7f7067 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -4851,6 +4851,9 @@ module_exit(l2cap_exit);
 module_param(enable_ertm, bool, 0644);
 MODULE_PARM_DESC(enable_ertm, "Enable enhanced retransmission mode");

+module_param(enable_highspeed, bool, 0644);
+MODULE_PARM_DESC(enable_highspeed, "Enable Bluetooth V3.0+HS
highspeed feature");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth L2CAP ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
1.6.3.3
