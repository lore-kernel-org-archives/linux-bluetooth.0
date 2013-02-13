Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] doc: Add missing device RSSI property
Date: Wed, 13 Feb 2013 23:24:38 +0100
Message-Id: <1360794278-29088-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

RSSI property was not documented in device API.
---
 doc/device-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index c79a46c..0f916c7 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -180,3 +180,8 @@ Properties	string Address [readonly]
 
 			Remote Device ID information in modalias format
 			used by the kernel and udev.
+
+		int16 RSSI [readonly, optional]
+
+			Received Signal Strength Indicator of the remote
+			device.
-- 
1.8.1.2

