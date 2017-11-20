Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 1/3 v2] doc/mgmt-api: Add support for Get PHY information command
Date: Mon, 20 Nov 2017 15:56:55 +0530
Message-Id: <1511173617-25442-2-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 8e7de14..69e84cd 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2871,6 +2871,7 @@ Read Extended Controller Information Command
 		13	Privacy
 		14	Controller Configuration
 		15	Static Address
+		16  	PHY configuration
 
 	The EIR_Data field contains information about class of device,
 	local name and other values. Not all of them might be present. For
@@ -2916,6 +2917,33 @@ Set Appearance Command
 				Invalid Parameters
 				Invalid Index
 
+Get PHY Information Command
+==========================
+
+	Command Code:		0x0043
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Supported_phys (1 Octet)
+				Selected_phys (1 Octet)
+
+	This command is used to retrieve the supported PHYs and currently
+	selected PHYs.
+
+	Supported_phys and Selected_phys is a bitmask with the following bits.
+		0	LE 1M TX
+		1	LE 1M RX
+		2	LE 2M TX
+		3	LE 2M RX
+		4	LE CODED TX
+		5	LE CODED RX
+
+	LE 1M TX and LE 1M RX would be supported by default.
+
+	This command is only available for LE capable controllers.
+	It will return Not Supported otherwise.
+
+	Possible errors:	Not Supported
+				Invalid Index
 
 Command Complete Event
 ======================
-- 
2.7.4

