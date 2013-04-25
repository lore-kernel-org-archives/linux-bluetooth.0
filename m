Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0] doc: Fix optional properties not marked as such
Date: Thu, 25 Apr 2013 09:33:55 +0200
Message-Id: <1366875235-12077-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Commit 826023de56896e83f35ae69a73d6a120a2f5b11e made some of the
device's properties optional but the documentation was not updated
accordingly. More specifically, the properties 'Name' and 'UUIDs' won't
be present if the information is not available.
---
 doc/device-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 0f916c7..187f2bf 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -96,7 +96,7 @@ Properties	string Address [readonly]
 
 			The Bluetooth device address of the remote device.
 
-		string Name [readonly]
+		string Name [readonly, optional]
 
 			The Bluetooth remote name. This value can not be
 			changed. Use the Alias property instead.
@@ -121,7 +121,7 @@ Properties	string Address [readonly]
 
 			External appearance of device, as found on GAP service.
 
-		array{string} UUIDs [readonly]
+		array{string} UUIDs [readonly, optional]
 
 			List of 128-bit UUIDs that represents the available
 			remote services.
-- 
1.8.1.4

