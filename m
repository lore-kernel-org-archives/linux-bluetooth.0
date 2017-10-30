Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] doc/gatt-api: Add link option
Date: Mon, 30 Oct 2017 14:59:24 +0200
Message-Id: <20171030125925.17784-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds link option to ReadValue and WriteValue so the application
can determine which bearer the request is coming from.
---
 doc/gatt-api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 400470631..8a367783c 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -264,6 +264,7 @@ Methods		array{byte} ReadValue(dict flags)
 
 			Possible options: "offset": Start offset
 					  "device": Device path (Server only)
+					  "link": Link type (Server only)
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
@@ -278,6 +279,7 @@ Methods		array{byte} ReadValue(dict flags)
 
 			Possible options: "offset": Start offset
 					  "device": Device path (Server only)
+					  "link": Link type (Server only)
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
-- 
2.13.6

