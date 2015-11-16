Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH 1/2] doc/adapter-api: Use correct signal name
Date: Mon, 16 Nov 2015 21:58:12 +0100
Message-Id: <1447707493-9342-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index cf7169f..284214e 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -167,7 +167,7 @@ Properties	string Address [readonly]
 			value will fail.
 
 			When changing the Powered property the new state of
-			this property will be updated via a PropertyChanged
+			this property will be updated via a PropertiesChanged
 			signal.
 
 			For any new adapter this settings defaults to false.
-- 
2.5.0

