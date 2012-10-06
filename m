Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 3/6] doc: Mark optional properties in Device interface
Date: Sat,  6 Oct 2012 04:02:37 -0300
Message-Id: <1349506960-9398-3-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349506960-9398-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349506960-9398-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/device-api.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 76af34c..71abb29 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -126,32 +126,32 @@ Properties	string Address [readonly]
 			The Bluetooth remote name. This value can not be
 			changed. Use the Alias property instead.
 
-		uint16 Vendor [readonly]
+		uint16 Vendor [readonly] [optional]
 
 			Vendor unique numeric identifier.
 
-		uint16 VendorSource [readonly]
+		uint16 VendorSource [readonly] [optional]
 
 			Vendor source numeric identifier.
 
-		uint16 Product [readonly]
+		uint16 Product [readonly] [optional]
 
 			Product unique numeric identifier.
 
-		uint16 Version [readonly]
+		uint16 Version [readonly] [optional]
 
 			Version unique numeric identifier.
 
-		string Icon [readonly]
+		string Icon [readonly] [optional]
 
 			Proposed icon name according to the freedesktop.org
 			icon naming specification.
 
-		uint32 Class [readonly]
+		uint32 Class [readonly] [optional]
 
 			The Bluetooth class of device of the remote device.
 
-		uint16 Appearance [readonly]
+		uint16 Appearance [readonly] [optional]
 
 			External appearance of device, as found on GAP service.
 
-- 
1.7.12.2

