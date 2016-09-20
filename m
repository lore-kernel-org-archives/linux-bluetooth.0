Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 5/5] tools/mgmt-tester: Add appearance to Read Ext Controller Info
Date: Tue, 20 Sep 2016 14:02:10 +0200
Message-Id: <1474372930-9706-5-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a253f84..b052570 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4920,12 +4920,16 @@ static const char ext_ctrl_info2[] = {
 	0x3f, 0x00, /* manufacturer */
 	0xff, 0xbf, 0x00, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
-	0x09, 0x00, /* eir length */
+	0x0D, 0x00, /* eir length */
 	0x04, /* dev class length */
 	0x0d, /* dev class info */
 	0xe0, /* minor */
 	0x03, /* major */
 	0x00, /* service classes */
+	0x03, /* appearance length */
+	0x19, /* EIR_APPEARANCE */
+	0x00, /* Appearance value */
+	0x00,
 	0x01, /* complete name data length */
 	0x09, /* complete name flag */
 	0x01, /* short name data length */
@@ -4947,12 +4951,16 @@ static const char ext_ctrl_info3[] = {
 	0x3f, 0x00, /* manufacturer */
 	0xff, 0xbf, 0x00, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
-	0x12, 0x00, /* eir length */
+	0x16, 0x00, /* eir length */
 	0x04, /* dev class length */
 	0x0d, /* dev class info */
 	0x00, /* minor */
 	0x00, /* major */
 	0x00, /* service classes */
+	0x03, /* appearance length */
+	0x19, /* EIR_APPEARANCE */
+	0x00, /* Appearance value */
+	0x00,
 	0x0A, /* Local name length */
 	0x09, /* Complete name */
 	0x54, 0x65, 0x73, 0x74,
@@ -4983,12 +4991,16 @@ static const char ext_ctrl_info4[] = {
 	0x3f, 0x00, /* manufacturer */
 	0xff, 0xbf, 0x00, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
-	0x16, 0x00, /* eir length */
+	0x1a, 0x00, /* eir length */
 	0x04, /* dev class length */
 	0x0d, /* dev class info */
 	0x00, /* minor */
 	0x00, /* major */
 	0x00, /* service classes */
+	0x03, /* appearance length */
+	0x19, /* EIR_APPEARANCE */
+	0x00, /* Appearance value */
+	0x00,
 	0x0A, /* Complete Local name len */
 	0x09, /* Complete name */
 	0x54, 0x65, 0x73, 0x74,
@@ -5038,12 +5050,16 @@ static const char ext_ctrl_info5[] = {
 	0x3f, 0x00, /* manufacturer */
 	0xff, 0xbf, 0x00, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
-	0x16, 0x00, /* eir len */
+	0x1a, 0x00, /* eir len */
 	0x04, /* dev class len */
 	0x0d, /* dev class info */
 	0xe0, /* minor */
 	0x03, /* major */
 	0x00, /* service classes */
+	0x03, /* appearance length */
+	0x19, /* EIR_APPEARANCE */
+	0x00, /* Appearance value */
+	0x00,
 	0x0A, /* Complete Local name len */
 	0x09, /* Complete name */
 	0x54, 0x65, 0x73, 0x74,
-- 
2.7.4

