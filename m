Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 2/3 v2] doc/mgmt-api: Add support for Set default Phy command
Date: Mon, 20 Nov 2017 15:56:56 +0530
Message-Id: <1511173617-25442-3-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 69e84cd..b59bf0c 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2940,9 +2940,47 @@ Get PHY Information Command
 	LE 1M TX and LE 1M RX would be supported by default.
 
 	This command is only available for LE capable controllers.
+        It will return Not Supported otherwise.
+
+        Possible errors:        Not Supported
+				Invalid Index
+
+Set Default PHY Command
+==========================
+
+	Command Code:		0x0044
+	Controller Index:	<controller id>
+	Command Parameters: 	Default_phy (1 Octet)
+	Return Parameters:	Current_phys (1 Octet)
+
+	This command is used to set the default PHYs to the controller.
+
+	This will be stored and used for all the subsequent scanning
+	and connection initiation.
+
+	Prior to this, Get PHY information Command should be called
+	to retrieve the supported PHYs by the controller. If default_phy
+	has PHY not supported by the controller (not there in supported_phys)
+	then Invalid Parameters will be returned.
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
-- 
2.7.4

