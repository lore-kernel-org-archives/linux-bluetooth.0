Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH BlueZ 1/3] doc/gatt-api: Add UpdateMTU and MTU
Date: Thu, 14 Sep 2017 16:47:48 -0700
Message-Id: <20170914234748.79584-3-yunhanw@google.com>
In-Reply-To: <20170914234748.79584-1-yunhanw@google.com>
References: <20170914234748.79584-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add updateMTU in gatt method to get att mtu value in server side.
Add MTU property in gatt property.
---
 doc/gatt-api.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index cdd15f301..419308a7e 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -169,6 +169,13 @@ Methods		array{byte} ReadValue(dict options)
 
 			Possible Errors: org.bluez.Error.Failed
 
+		void UpdateMTU() [optional] (Server only)
+
+			This method doesn't expect a reply so it is just
+			MTU value update in user space at server side.
+
+			Possible Errors: org.bluez.Error.Failed
+
 Properties	string UUID [read-only]
 
 			128-bit characteristic UUID.
@@ -225,6 +232,10 @@ Properties	string UUID [read-only]
 				"secure-read" (Server only)
 				"secure-write" (Server only)
 
+		uint16_t MTU [read-only, optional]
+
+			ATT MTU value
+
 Characteristic Descriptors hierarchy
 ====================================
 
-- 
2.14.1.690.gbb1197296e-goog

