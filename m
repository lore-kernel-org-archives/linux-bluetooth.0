Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] doc/advertising-api: Add Duration and Timeout
Date: Thu,  2 Nov 2017 16:15:13 +0200
Message-Id: <20171102141519.28446-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds duration and timeout so application can control the periods
which the advertisement stays active.
---
 doc/advertising-api.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b10010a19..15e64d38a 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -84,6 +84,17 @@ Properties	string Type
 
 			Possible values: as found on GAP Service.
 
+		uint16_t Duration
+
+			Duration of the advertisement in seconds. If there are
+			other applications advertising no duration is set the
+			default is 2 seconds.
+
+		uint16_t Timeout
+
+			Timeout of the advertisement in seconds. This defines
+			the lifetime of the advertisement.
+
 LE Advertising Manager hierarchy
 ================================
 
-- 
2.13.6

