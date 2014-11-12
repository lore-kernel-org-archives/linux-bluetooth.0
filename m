Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  3/3] tools/sdptool: Add support for IrMC service record
Date: Wed, 12 Nov 2014 14:31:37 +0530
Message-id: <1415782897-11667-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1415782897-11667-1-git-send-email-gowtham.ab@samsung.com>
References: <1415782897-11667-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

IrMC Record output captured from sdptool:

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x1000b
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1104 - IrMCSync
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0xe
    Data Sequence
      UUID16 : 0x0008 - OBEX
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1104 - IrMCSync
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Data : 53 79 6e 63 68 72 6f 6e 69 7a 61 74 69 6f 6e 00
Attribute Identifier : 0x301 - SupportedDataStoresList
  Data Sequence
    Integer : 0x1
---
 tools/sdptool.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 9fd1b7f..f3aebd2 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -227,6 +227,11 @@ static struct attrib_def audio_attrib_names[] = {
 	{ 0x302, "Remote audio volume control", NULL, 0 },
 };
 
+/* Name of the various IrMCSync attributes. See BT assigned numbers */
+static struct attrib_def irmc_attrib_names[] = {
+	{ 0x0301, "SupportedDataStoresList", NULL, 0 },
+};
+
 /* Name of the various GOEP attributes. See BT assigned numbers */
 static struct attrib_def goep_attrib_names[] = {
 	{ 0x200, "GoepL2capPsm", NULL, 0 },
@@ -284,7 +289,8 @@ static struct uuid_def uuid16_names[] = {
 	{ 0x1101, "SerialPort", NULL, 0 },
 	{ 0x1102, "LANAccessUsingPPP", NULL, 0 },
 	{ 0x1103, "DialupNetworking (DUN)", NULL, 0 },
-	{ 0x1104, "IrMCSync", NULL, 0 },
+	{ 0x1104, "IrMCSync",
+		irmc_attrib_names, N_ELEMENTS(irmc_attrib_names) },
 	{ 0x1105, "OBEXObjectPush",
 		goep_attrib_names, N_ELEMENTS(goep_attrib_names) },
 	{ 0x1106, "OBEXFileTransfer",
-- 
1.9.1

