Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH BlueZ 1/5] doc/mgmt-api: Allow set appearance only for LE capable controllers
Date: Tue, 20 Sep 2016 14:02:06 +0200
Message-Id: <1474372930-9706-1-git-send-email-michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 334c884..a7bd6e4 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2908,7 +2908,11 @@ Set Appearance Command
 	This command generates a Command Complete event on success
 	or a Command Status event on failure.
 
-	Possible errors:	Invalid Parameters
+	This command is only available for LE capable controllers.
+	It will return Not Supported otherwise.
+
+	Possible errors:	Not Supported
+				Invalid Parameters
 				Invalid Index
 
 
-- 
2.7.4

