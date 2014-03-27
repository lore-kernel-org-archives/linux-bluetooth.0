Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 5/5] doc: Remove Core SPEC page number from gatt-api.txt
Date: Thu, 27 Mar 2014 10:21:15 -0300
Message-Id: <1395926475-8841-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395926475-8841-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove Core SPEC page number from the API document to avoid wrong
page reference when the SPEC changes.
---
 doc/gatt-api.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 0f6b084..6c70679 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -65,13 +65,12 @@ Properties	string UUID [read-only]
 		array{string} Flags [read-only, optional]
 
 			Defines how the characteristic value can be used. See
-			Core spec page 1898, "Table 3.5: Characteristic
-			Properties bit field" and page 1900, "Table 3.8:
-			Characteristic Extended Properties bit field". Allowed
-			values: "broadcast", "read", "write-without-response",
-			"write", "notify", "indicate",
-			"authenticated-signed-writes", "reliable-write", and
-			"writable-auxiliaries".
+			Core spec page "Table 3.5: Characteristic Properties
+			bit field", and "Table 3.8: Characteristic Extended
+			Properties bit field". Allowed values: "broadcast",
+			"read", "write-without-response", "write", "notify",
+			"indicate", "authenticated-signed-writes",
+			"reliable-write", and "writable-auxiliaries".
 
 
 Characteristic Descriptors hierarchy
-- 
1.8.3.1

