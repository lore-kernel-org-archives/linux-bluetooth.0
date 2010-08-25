Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:22:27 +0800
Message-ID: <AANLkTinpXB4ZXW=Oarn0qZAWWdRrr1JL1SB7mu9KSj08@mail.gmail.com>
Subject: [PATCH 01/22] Add eL2cap signal macro definition
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 0ce1315590e4bfe0d344acad7e770710833795aa Mon Sep 17 00:00:00 2001
From: haijun <haijun@haijun-laptop.(none)>
Date: Wed, 18 Aug 2010 22:26:19 +0800
Subject: [PATCH 01/22] Add eL2cap signal macro definition.

---
 include/net/bluetooth/l2cap.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7df70e4..bf0ea10 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -86,6 +86,12 @@ struct l2cap_conninfo {
 #define L2CAP_ECHO_RSP		0x09
 #define L2CAP_INFO_REQ		0x0a
 #define L2CAP_INFO_RSP		0x0b
+#define L2CAP_CREATECHAN_REQ	0x0c
+#define L2CAP_CREATECHAN_RSP	0x0d
+#define L2CAP_MOVECHAN_REQ	0x0e
+#define L2CAP_MOVECHAN_RSP	0x0f
+#define L2CAP_MOVECHAN_CFM	0x10
+#define L2CAP_MOVECHAN_CFM_RSP	0x11

 /* L2CAP feature mask */
 #define L2CAP_FEAT_FLOWCTL	0x00000001
-- 
1.6.3.3
