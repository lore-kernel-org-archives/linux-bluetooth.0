Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] doc/gatt-api: Add authorization options for attributes
Date: Wed, 16 May 2018 15:52:28 +0200
Message-Id: <20180516135230.7182-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180516135230.7182-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180516135230.7182-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds authorization property for attributes and prepare write
request for authorization option for write request. This is require to
handle correctly prepare writes, which may response with insufficient
authorization error.
---
 doc/gatt-api.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 0f1cc9029..fc61838df 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -85,6 +85,8 @@ Methods		array{byte} ReadValue(dict options)
 			Possible options: "offset": Start offset
 					  "device": Device path (Server only)
 					  "link": Link type (Server only)
+					  "authorize": boolean Is prepare write
+							    authorization request
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
@@ -251,6 +253,12 @@ Properties	string UUID [read-only]
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
 
@@ -284,6 +292,8 @@ Methods		array{byte} ReadValue(dict flags)
 			Possible options: "offset": Start offset
 					  "device": Device path (Server only)
 					  "link": Link type (Server only)
+					  "authorize": boolean Is authorization
+						       request
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
-- 
2.13.6

