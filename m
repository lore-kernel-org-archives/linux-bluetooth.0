Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/4] Add the Attribute interface to the API
Date: Tue, 28 Sep 2010 14:49:12 -0300
Message-Id: <1285696155-32766-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

For now the Attribute API will allow users to list all the GATT
services that a device has.
---
 doc/attribute-api.txt |   19 +++++++++++++++++++
 doc/device-api.txt    |    4 ----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 011691e..0989099 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -37,6 +37,25 @@ Methods
 Properties
 
 
+Attribute Protocol hierarchy
+============================
+
+Service		org.bluez
+Interface	org.bluez.Attribute
+Object path	[prefix]/{hci0}/{device0}
+
+
+Methods		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+Properties	array{object} Services
+
+			List of all the Primary Services that this device
+			implements.
+
+
 Device Service hierarchy
 ========================
 
diff --git a/doc/device-api.txt b/doc/device-api.txt
index 95b5b22..b818299 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -139,10 +139,6 @@ Properties	string Address [readonly]
 			List of 128-bit UUIDs that represents the available
 			remote services.
 
-		array{object} Services [readonly]
-
-			List of characteristics based services.
-
 		boolean Paired [readonly]
 
 			Indicates if the remote device is paired.
-- 
1.7.3

