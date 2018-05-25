Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/4] doc/gatt-api: Add authorization options for attributes
Date: Fri, 25 May 2018 09:38:54 +0200
Message-Id: <20180525073857.17860-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds authorization property for attributes and prepare write
request for authorization option for write request. This is require to
handle correctly prepare writes, which may response with insufficient
authorization error.
---
 doc/gatt-api.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 0f1cc9029..914fc7031 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -85,6 +85,9 @@ Methods		array{byte} ReadValue(dict options)
 			Possible options: "offset": Start offset
 					  "device": Device path (Server only)
 					  "link": Link type (Server only)
+					  "prep-authorize": boolean Is prepare
+							    authorization
+							    request
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
@@ -251,6 +254,12 @@ Properties	string UUID [read-only]
 				"secure-read" (Server only)
 				"secure-write" (Server only)
 
+		boolean Authorize [read-only, optional] (Server only)
+
+			True, if authorization is required for attribute
+			operations. By default this valuie is set to false for
+			attribute.
+
 Characteristic Descriptors hierarchy
 ====================================
 
@@ -284,6 +293,9 @@ Methods		array{byte} ReadValue(dict flags)
 			Possible options: "offset": Start offset
 					  "device": Device path (Server only)
 					  "link": Link type (Server only)
+					  "prep-authorize": boolean Is prepare
+							    authorization
+							    request
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
@@ -322,6 +334,12 @@ Properties	string UUID [read-only]
 				"secure-read" (Server Only)
 				"secure-write" (Server Only)
 
+		boolean Authorize [read-only, optional] (Server only)
+
+			True, if authorization is required for attribute
+			operations. By default this valuie is set to false for
+			attribute.
+
 GATT Profile hierarchy
 =====================
 
-- 
2.13.6

