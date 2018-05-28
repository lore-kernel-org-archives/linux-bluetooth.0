Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 1/4] doc/gatt-api: Add authorization options for attributes
Date: Mon, 28 May 2018 10:20:51 +0200
Message-Id: <20180528082054.4017-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds authorization property for attributes and prepare write
request for authorization option for write request. This is require to
handle correctly prepare writes, which may response with insufficient
authorization error.
---
 doc/gatt-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 0f1cc9029..2a8da75b0 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -85,6 +85,9 @@ Methods		array{byte} ReadValue(dict options)
 			Possible options: "offset": Start offset
 					  "device": Device path (Server only)
 					  "link": Link type (Server only)
+					  "prepare-authorize": boolean Is prepare
+							       authorization
+							       request
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
@@ -250,6 +253,7 @@ Properties	string UUID [read-only]
 				"encrypt-authenticated-write"
 				"secure-read" (Server only)
 				"secure-write" (Server only)
+				"authorize"
 
 Characteristic Descriptors hierarchy
 ====================================
@@ -284,6 +288,9 @@ Methods		array{byte} ReadValue(dict flags)
 			Possible options: "offset": Start offset
 					  "device": Device path (Server only)
 					  "link": Link type (Server only)
+					  "prepare-authorize": boolean Is prepare
+							       authorization
+							       request
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
@@ -321,6 +328,7 @@ Properties	string UUID [read-only]
 				"encrypt-authenticated-write"
 				"secure-read" (Server Only)
 				"secure-write" (Server Only)
+				"authorize"
 
 GATT Profile hierarchy
 =====================
-- 
2.13.6

