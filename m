Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Yunhan Wang <yunhanw@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yunhan Wang <yunhanw@google.com>
Subject: [PATCH v4 1/3] doc/gatt-api: Add Confirm
Date: Tue, 29 Aug 2017 00:35:18 -0700
Message-Id: <20170829073520.12059-1-yunhanw@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add Confirm method which doesn't expect a reply so it is just
 confirmation that value was received.
---
 doc/gatt-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index c0ad1de25..cdd15f301 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -162,6 +162,13 @@ Methods		array{byte} ReadValue(dict options)
 
 			Possible Errors: org.bluez.Error.Failed
 
+		void Confirm() [optional] (Server only)
+
+			This method doesn't expect a reply so it is just a
+			confirmation that value was received.
+
+			Possible Errors: org.bluez.Error.Failed
+
 Properties	string UUID [read-only]
 
 			128-bit characteristic UUID.
-- 
2.14.1.342.g6490525c54-goog

