Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:36:35 +0800
Message-ID: <AANLkTikf=UeHUaT8wLnwUDnxgg0ouz1f6QkgYZvbr8t8@mail.gmail.com>
Subject: [PATCH 14/22] Add three new options for l2cap_pinfo
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 06124ba36c1f6c9cf5bef861751ce749712cecb0 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Mon, 23 Aug 2010 00:03:39 +0800
Subject: [PATCH 14/22] Add three new options for l2cap_pinfo.

---
 include/net/bluetooth/l2cap.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4f87aec..7a9bec4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -367,6 +367,10 @@ struct l2cap_pinfo {
 	__u8		num_conf_req;
 	__u8		num_conf_rsp;

+	__u8		hschan_req;
+	__u8		guaranteed;
+	__u8		reconfig;
+
 	__u8		fcs;
 	__u8		sec_level;
 	__u8		role_switch;
-- 
1.6.3.3
