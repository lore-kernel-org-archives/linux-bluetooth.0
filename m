Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] doc/gatt-api: Update documentation regarding link option
Date: Fri, 23 Mar 2018 15:37:01 +0200
Message-Id: <20180323133703.12499-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reflects what the code has already doing so any server operation which
requires the device option shall also get the link type as well.
---
 doc/gatt-api.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 60a997cbf..0f1cc9029 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -84,6 +84,7 @@ Methods		array{byte} ReadValue(dict options)
 
 			Possible options: "offset": Start offset
 					  "device": Device path (Server only)
+					  "link": Link type (Server only)
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
@@ -117,6 +118,7 @@ Methods		array{byte} ReadValue(dict options)
 
 			Possible options: "device": Object Device (Server only)
 					  "MTU": Exchanged MTU (Server only)
+					  "link": Link type (Server only)
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.NotSupported
@@ -152,6 +154,7 @@ Methods		array{byte} ReadValue(dict options)
 
 			Possible options: "device": Object Device (Server only)
 					  "MTU": Exchanged MTU (Server only)
+					  "link": Link type (Server only)
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.NotSupported
-- 
2.14.3

