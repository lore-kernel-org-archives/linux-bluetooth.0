Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	luiz.dentz@gmail.com, Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] tools/sdptool: Add MAP supported features for MNS
Date: Fri, 31 Oct 2014 11:00:23 +0530
Message-id: <1414733423-18958-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add MapSupportedFeatures into MNS
attribute names.
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

