Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:39:46 +0800
Message-ID: <AANLkTinMJs+pFkgqOQfkiA9v5vXFR-10HUZ+kjwGvkyu@mail.gmail.com>
Subject: [PATCH 19/22] Store physical link status in l2cap_conn
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From df717c32ff5e397dc7860f7ce93b3aa734aeac73 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Mon, 23 Aug 2010 00:23:32 +0800
Subject: [PATCH 19/22] Store physical link status in l2cap_conn.

---
 include/net/bluetooth/l2cap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f91111c..8a544a0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -336,6 +336,8 @@ struct l2cap_conn {
 	__u8		disc_reason;

 	struct l2cap_chan_list chan_list;
+
+	__u8 phyl_status;
 };

 struct sock_del_list {
-- 
1.6.3.3
