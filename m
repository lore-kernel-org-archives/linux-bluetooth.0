Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/3] tools/sdptool: Add support for PBAP service record
Date: Wed, 12 Nov 2014 14:31:36 +0530
Message-id: <1415782897-11667-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1415782897-11667-1-git-send-email-gowtham.ab@samsung.com>
References: <1415782897-11667-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PBAP Record output captured from sdptool:

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x1000a
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x112f - Phonebook Access (PBAP) - PSE
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0xf
    Data Sequence
      UUID16 : 0x0008 - OBEX
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1130 - Phonebook Access (PBAP)
      Version (Integer) : 0x101
Attribute Identifier : 0x100
  Data : 50 68 6f 6e 65 20 42 6f 6f 6b 20 41 63 63 65 73 73 00
Attribute Identifier : 0x314 - SupportedRepositories
  Integer : 0x1
Attribute Identifier : 0x317 - PbapSupportedFeatures
  Integer : 0x3
---
 tools/sdptool.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 88a52bb..9fd1b7f 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -232,6 +232,12 @@ static struct attrib_def goep_attrib_names[] = {
 	{ 0x200, "GoepL2capPsm", NULL, 0 },
 };
 
+/* Name of the various PBAP attributes. See BT assigned numbers */
+static struct attrib_def pbap_attrib_names[] = {
+	{ 0x0314, "SupportedRepositories", NULL, 0 },
+	{ 0x0317, "PbapSupportedFeatures", NULL, 0 },
+};
+
 /* Name of the various MAS attributes. See BT assigned numbers */
 static struct attrib_def mas_attrib_names[] = {
 	{ 0x0315, "MASInstanceID", NULL, 0 },
@@ -327,7 +333,8 @@ static struct uuid_def uuid16_names[] = {
 	{ 0x112c, "Audio/Video", NULL, 0 },
 	{ 0x112d, "SIM Access (SAP)", NULL, 0 },
 	{ 0x112e, "Phonebook Access (PBAP) - PCE", NULL, 0 },
-	{ 0x112f, "Phonebook Access (PBAP) - PSE", NULL, 0 },
+	{ 0x112f, "Phonebook Access (PBAP) - PSE",
+		pbap_attrib_names, N_ELEMENTS(pbap_attrib_names) },
 	{ 0x1130, "Phonebook Access (PBAP)", NULL, 0 },
 	{ 0x1131, "Headset (HSP)", NULL, 0 },
 	{ 0x1132, "Message Access (MAP) - MAS",
-- 
1.9.1

