Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] doc/gatt-api: Add Flags property to GattDescriptor
Date: Mon, 27 Apr 2015 16:14:32 +0300
Message-Id: <1430140475-20349-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
References: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Flags property to GattDescriptor so the server can define
permissions and authentication requirements for descriptors.
---
 doc/gatt-api.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 8db35f2..8459430 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -210,6 +210,20 @@ Properties	string UUID [read-only]
 			gets updated only after a successful read request, upon
 			which a PropertiesChanged signal will be emitted.
 
+		array{string} Flags [read-only]
+
+			Defines how the descriptor value can be used.
+
+			Possible values:
+
+				"read"
+				"write-without-response"
+				"write"
+				"authenticated-signed-writes"
+				"encrypt-read"
+				"encrypt-write"
+				"encrypt-authenticated-read"
+				"encrypt-authenticated-write"
 
 Profile hierarcy
 ================
-- 
2.1.0

