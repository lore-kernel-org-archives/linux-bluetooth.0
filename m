Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 2/4 v4] doc/mgmt-api: Add support for Set Phy Configuration command
Date: Wed, 29 Nov 2017 12:22:51 +0530
Message-Id: <1511938373-22396-3-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1511938373-22396-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1511938373-22396-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This also adds PHY Configuration Changed Event.
---
 doc/mgmt-api.txt | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index c07c48c..628ff18 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2940,9 +2940,46 @@ Get PHY Configuration Command
 	LE 1M TX and LE 1M RX would be supported by default.
 
 	This command is only available for LE capable controllers.
+        It will return Not Supported otherwise.
+
+        Possible errors:        Not Supported
+				Invalid Index
+
+Set PHY Configuration Command
+=============================
+
+	Command Code:		0x0044
+	Controller Index:	<controller id>
+	Command Parameters: 	Default_phys (2 Octet)
+	Return Parameters:
+
+	This command is used to set the default phy to the controller.
+
+	This will be stored and used for all the subsequent scanning
+	and connection initiation.
+
+	The list of supported PHYs can be retrieved via the
+	Get PHY Configuration command. Selecting unsupported PHYs will
+	result in an Invalid Parameters	error.
+
+	This can be called at any point to change the preferred PHYs.
+
+	Default_phy is a bitmask with the following bits.
+		0	LE 1M TX
+		1	LE 1M RX
+		2	LE 2M TX
+		3	LE 2M RX
+		4	LE CODED TX
+		5	LE CODED RX
+
+	This command generates a Command Complete event on success
+	or a Command Status event on failure.
+
+	This command is only available for LE capable controllers.
 	It will return Not Supported otherwise.
 
 	Possible errors:	Not Supported
+				Invalid Parameters
 				Invalid Index
 
 Command Complete Event
@@ -3810,3 +3847,18 @@ Extended Controller Information Changed Event
 
 	The event will only be sent to management sockets other than the
 	one through which the change was triggered.
+
+PHY Configuration Changed Event
+===============================
+
+	Event Code:		0x0026
+	Controller Index:	<controller id>
+	Event Parameters:	Selected_phys (2 Octets)
+
+	This event indicates that default PHYs have been updated.
+
+	This event will only be used after Set PHY Configuration
+	command has been used at least once.
+
+	The event will only be sent to management sockets other than the
+	one through which the change was triggered.
-- 
2.7.4

