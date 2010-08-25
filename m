Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:37:30 +0800
Message-ID: <AANLkTimnW0jk19cDG+r64Q+-HxdH2qdTBirTMB7ikr1W@mail.gmail.com>
Subject: [PATCH 16/22] Store new configuration values in l2cap_pinfo
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From d093975dde6d85c824a5aaac943d676100810010 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Mon, 23 Aug 2010 00:09:56 +0800
Subject: [PATCH 16/22] Store new configuration values in l2cap_pinfo.

---
 include/net/bluetooth/l2cap.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2d864d4..f2dd65d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -406,6 +406,15 @@ struct l2cap_pinfo {
 	__u16		remote_mps;
 	__u16		mps;

+	__u8		ext_flowspec_enable;
+	struct ext_flow_spec	loc_efs;
+	struct ext_flow_spec	rem_efs;
+
+	__u8		extwin_enable;
+	__u16		extwin_size;
+	__u8		rem_extwin_enable;
+	__u16		rem_extwin_size;
+
 	__le16		sport;

 	struct timer_list	retrans_timer;
-- 
1.6.3.3
