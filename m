Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 1/3] doc/mgmt-api: Add support for Get supported phys command
Date: Tue, 14 Nov 2017 16:02:16 +0530
Message-Id: <1510655538-12883-3-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 8e7de14..80edb14 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2916,6 +2916,29 @@ Set Appearance Command
 				Invalid Parameters
 				Invalid Index
 
+Get Supported PHYs Command
+==========================
+
+	Command Code:		0x0043
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Supported_phys (1 Octet)
+
+	This command is used to retrieve the supported phys by the
+	controller.
+
+	Supported_phys is a bitmask with the following bits.
+		0	LE 1M
+		1	LE 2M
+		2	LE CODED (LR)
+
+	LE 1M would be supported by default.
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

