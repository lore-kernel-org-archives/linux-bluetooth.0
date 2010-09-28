Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/4] Add GetProperties method in the Device service hierarchy
Date: Tue, 28 Sep 2010 14:49:13 -0300
Message-Id: <1285696155-32766-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1285696155-32766-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1285696155-32766-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes the attribute API to become compliant with other BlueZ
APIs. Characteristics properties can be retrieved using GetProperties
method of the Device Characteristic hierarchy. This patch also removes
unneeded characteristic properties description which is already
explained in the next section.
---
 doc/attribute-api.txt |   28 +++-------------------------
 1 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 0989099..a5e475b 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -64,15 +64,10 @@ Interface	org.bluez.Characteristic
 Object path	[prefix]/{hci0}/{device0}/{service0, service1, ...}
 		[prefix]/{hci0}/{device1}/{service0, service1, ...}
 
-Methods		array[(object, dict)] GetCharacteristics()
+Methods 	dict GetProperties()
 
-			Array of tuples with object path as identifier. An
-			alternative is doing dict of dict since the object
-			path is unique and the order of characteristics is
-			irrelevant. However it might be good to actually
-			present an order here.
-
-			See Characteristics properties for dictionary details.
+			Returns all properties for the interface. See the
+			Properties section for the available properties.
 
 		RegisterCharacteristicsWatcher(object path)
 
@@ -109,23 +104,6 @@ Properties	string Name (mandatory) [readonly]
 			includes. That way no complicated service includes array
 			is needed.
 
-			string UUID
-			string Name
-			string Description
-			struct Format (type, name, exponet etc.)
-
-			array{byte} Value
-			string Representation (of the binary Value)
-
-			object Service (the original service in case of includes)
-
-			At this point only GetProperties() method call should be
-			supported for simplicity. Changing characteristics is up
-			to future support.
-
-			The object path of the characteristics might be split
-			over multiple service objects, because of includes.
-
 
 Device Characteristic hierarchy
 ===============================
-- 
1.7.3

