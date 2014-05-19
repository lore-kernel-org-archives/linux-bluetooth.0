Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 01/11] doc: Update RSSI property description.
Date: Tue, 20 May 2014 01:44:33 +0200
Message-Id: <1400543083-28811-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>

RSSI property applies to either inquiry or advertising packets and this
should be stated here especially that we plan to add connection RSSI
property.
---
 doc/device-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 2d9fa3c..577ee60 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -192,4 +192,4 @@ Properties	string Address [readonly]
 		int16 RSSI [readonly, optional]
 
 			Received Signal Strength Indicator of the remote
-			device.
+			device (inquiry or advertising).
-- 
1.9.3

