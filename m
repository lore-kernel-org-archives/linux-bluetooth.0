Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] att.h: Add client characteristic configuration bit fields
Date: Fri,  9 Dec 2011 19:03:43 +0100
Message-Id: <1323453823-7905-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 851e6ba..dc266f1 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -106,6 +106,9 @@
 #define ATT_CHAR_PROPER_AUTH			0x40
 #define ATT_CHAR_PROPER_EXT_PROPER		0x80
 
+/* Client Characteristic Configuration bit field */
+#define ATT_CLIENT_CHAR_CONF_NOTIFICATION	0x0001
+#define ATT_CLIENT_CHAR_CONF_INDICATION		0x0002
 
 #define ATT_MAX_MTU				256
 #define ATT_DEFAULT_L2CAP_MTU			48
-- 
1.7.8

