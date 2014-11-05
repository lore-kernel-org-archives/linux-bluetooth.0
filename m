Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1] tools/sdptool: Add MAP supported features for MNS
Date: Wed, 05 Nov 2014 11:24:49 +0530
Message-id: <1415166889-5018-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add MapSupportedFeatures into MNS attribute names.

MNS Record output captured from sdptool:
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10008
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1133 - Message Access (MAP) - MNS
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x11
    Data Sequence
      UUID16 : 0x0008 - OBEX
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1134 - Message Access (MAP)
      Version (Integer) : 0x102
Attribute Identifier : 0x100
  Data : 4d 65 73 73 61 67 65 20 4e 6f 74 69 66 69 63 61 74 69 6f 6e 00
Attribute Identifier : 0x200
  Integer : 0x1001
Attribute Identifier : 0x317 - MapSupportedFeatures
  Integer : 0x7f
---
 tools/sdptool.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index f2d3068..88a52bb 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -239,6 +239,11 @@ static struct attrib_def mas_attrib_names[] = {
 	{ 0x0317, "MapSupportedFeatures", NULL, 0 },
 };
 
+/* Name of the various MNS attributes. See BT assigned numbers */
+static struct attrib_def mns_attrib_names[] = {
+	{ 0x0317, "MapSupportedFeatures", NULL, 0 },
+};
+
 /* Same for the UUIDs. See BT assigned numbers */
 static struct uuid_def uuid16_names[] = {
 	/* -- Protocols -- */
@@ -327,7 +332,8 @@ static struct uuid_def uuid16_names[] = {
 	{ 0x1131, "Headset (HSP)", NULL, 0 },
 	{ 0x1132, "Message Access (MAP) - MAS",
 		mas_attrib_names, N_ELEMENTS(mas_attrib_names) },
-	{ 0x1133, "Message Access (MAP) - MNS", NULL, 0 },
+	{ 0x1133, "Message Access (MAP) - MNS",
+		mns_attrib_names, N_ELEMENTS(mns_attrib_names) },
 	{ 0x1134, "Message Access (MAP)", NULL, 0 },
 	/* ... */
 	{ 0x1200, "PnPInformation",
-- 
1.9.1

