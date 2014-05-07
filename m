Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, szymon.janc@tieto.com,
	andrzej.kaczmarek@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] doc: Update RSSI property description.
Date: Wed,  7 May 2014 16:17:12 +0200
Message-Id: <1399472233-19056-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

RSSI property is inquiry RSSI and this should be stated here especially
that we plan to add connection RSSI property soon.
---
 doc/device-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 2d9fa3c..7a301d3 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -191,5 +191,5 @@ Properties	string Address [readonly]
 
 		int16 RSSI [readonly, optional]
 
-			Received Signal Strength Indicator of the remote
+			Received Signal Strength Indicator (inquiry) of the remote
 			device.
-- 
1.8.4

