Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:36:05 +0800
Message-ID: <AANLkTi=8xVks--xcLXEQ_=sHfP3fY+Wvyctu5K_kMDG-@mail.gmail.com>
Subject: [PATCH 13/22] Add three new options for l2cap_options which used in
 setsockopt & getsockopt
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 897b281d14ba4cf9a5fbbf5ba65b84c85e688737 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Mon, 23 Aug 2010 00:00:26 +0800
Subject: [PATCH 13/22] Add three new options for l2cap_options which
used in setsockopt & getsockopt.

---
 include/net/bluetooth/l2cap.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d0ae9f5..4f87aec 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -65,6 +65,9 @@ struct l2cap_options {
 	__u8  fcs;
 	__u8  max_tx;
 	__u16 txwin_size;
+	__u8  hschan_req;
+	__u8  guaranteed;
+	__u8  reconfig;
 };

 #define L2CAP_CONNINFO	0x02
-- 
1.6.3.3
