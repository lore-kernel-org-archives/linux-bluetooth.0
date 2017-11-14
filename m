Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 2/3] doc/mgmt-api: Add support for Set default Phy command
Date: Tue, 14 Nov 2017 16:02:17 +0530
Message-Id: <1510655538-12883-4-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 80edb14..25739cc 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2940,6 +2940,42 @@ Get Supported PHYs Command
 	Possible errors:	Not Supported
 				Invalid Index
 
+Set Default PHY Command
+==========================
+
+	Command Code:		0x0044
+	Controller Index:	<controller id>
+	Command Parameters: 	Default_phy (1 Octet)
+	Return Parameters:
+
+	This command is used to set the default phy to the controller.
+
+	This will be stored and used for all the subsequent scanning
+	and connection initiation.
+
+	Prior to this, Get Supported PHYs Command shall be called
+	to retrieve the supported phys by the controller. If default_phy
+	has phy not supported by the controller (not there in supported_phys)
+	then Invalid Parameters will be returned.
+
+	This can be called at any point to change the preferred phys.
+
+	Default_phy is a bitmask with the following bits.
+
+		0	LE 1M
+		1	LE 2M
+		2	LE CODED (LR)
+
+	This command generates a Command Complete event on success
+	or a Command Status event on failure.
+
+	This command is only available for LE capable controllers.
+	It will return Not Supported otherwise.
+
+	Possible errors:	Not Supported
+				Invalid Parameters
+				Invalid Index
+
 Command Complete Event
 ======================
 
-- 
2.7.4

