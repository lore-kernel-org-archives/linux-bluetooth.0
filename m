Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] doc: Fix data length in Advertising API description
Date: Fri,  4 Mar 2016 12:16:43 +0100
Message-Id: <1457090203-5741-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

LE Advertising Data is 31 bytes long.
---
 doc/advertising-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 4ee37bb..1c18ae3 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -3,7 +3,7 @@ BlueZ D-Bus LE Advertising API Description
 
 Advertising packets are structured data which is broadcast on the LE Advertising
 channels and available for all devices in range.  Because of the limited space
-available in LE Advertising packets (32 bytes), each packet's contents must be
+available in LE Advertising packets (31 bytes), each packet's contents must be
 carefully controlled.
 
 BlueZ acts as a store for the Advertisement Data which is meant to be sent.
-- 
2.6.2

