Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH 1/3] doc/device-api: Add TxPower
Date: Fri, 17 Apr 2015 18:09:30 -0700
Message-Id: <1429319372-25172-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds TxPower from advertisement data.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 doc/device-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 72c597e..875fd9d 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -196,6 +196,11 @@ Properties	string Address [readonly]
 			Received Signal Strength Indicator of the remote
 			device (inquiry or advertising).
 
+		int16 TxPower [readonly, optional]
+
+			Advertised transmitted power level (inquiry or
+			advertising).
+
 		dict ManufacturerData [readonly, optional]
 
 			Manufacturer specific advertisement data. Keys are
-- 
2.2.0.rc0.207.ga3a616c

