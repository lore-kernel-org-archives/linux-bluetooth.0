Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools: add GoepL2capPsm decoding support to sdptool
Date: Mon,  6 Feb 2012 15:19:01 +0200
Message-Id: <1328534341-11335-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/sdptool.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index aea4954..1a89245 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -226,6 +226,11 @@ static struct attrib_def audio_attrib_names[] = {
 	{ 0x302, "Remote audio volume control", NULL, 0 },
 };
 
+/* Name of the various GOEP attributes. See BT assigned numbers */
+static struct attrib_def goep_attrib_names[] = {
+	{ 0x200, "GoepL2capPsm", NULL, 0 },
+};
+
 /* Same for the UUIDs. See BT assigned numbers */
 static struct uuid_def uuid16_names[] = {
 	/* -- Protocols -- */
@@ -261,8 +266,10 @@ static struct uuid_def uuid16_names[] = {
 	{ 0x1102, "LANAccessUsingPPP", NULL, 0 },
 	{ 0x1103, "DialupNetworking (DUN)", NULL, 0 },
 	{ 0x1104, "IrMCSync", NULL, 0 },
-	{ 0x1105, "OBEXObjectPush", NULL, 0 },
-	{ 0x1106, "OBEXFileTransfer", NULL, 0 },
+	{ 0x1105, "OBEXObjectPush",
+		goep_attrib_names, sizeof(goep_attrib_names)/sizeof(struct attrib_def) },
+	{ 0x1106, "OBEXFileTransfer",
+		goep_attrib_names, sizeof(goep_attrib_names)/sizeof(struct attrib_def) },
 	{ 0x1107, "IrMCSyncCommand", NULL, 0 },
 	{ 0x1108, "Headset",
 		audio_attrib_names, sizeof(audio_attrib_names)/sizeof(struct attrib_def) },
-- 
1.7.7.6

