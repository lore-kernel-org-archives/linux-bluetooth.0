Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] doc/advertising-api: Add Flags property
Date: Mon,  7 May 2018 19:13:59 +0300
Message-Id: <20180507161403.14181-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Flags which the application can use in case it want to set
it own flags.

Note: This would allow for example an application to advertise as
discoverable even if the adapter is not discoverable which may be
required by dual-mode as it may not require BR/EDR to be discoverable.
---
 doc/advertising-api.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index eef98ad91..4e015f282 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -78,6 +78,21 @@ Properties	string Type
 				<Transport Discovery> <Organization Flags...>
 				0x26                   0x01         0x01...
 
+		array{byte} Flags [Experimental]
+
+			Advertising Flags to include. When present this will
+			override existing flags such as Discoverable.
+
+			Note: This property shall not be set when Type is set
+			to broadcast.
+
+			Possible value:
+				bit 0 - LE Limited Discoverable Mode
+				bit 1 - LE General Discoverable Mode
+				bit 2 - BR/EDR Not Supported
+				bit 3 - Simultaneous LE and BR/EDR (Controller)
+				bit 4 - Simultaneous LE and BR/EDR (Host)
+
 		array{string} Includes
 
 			List of features to be included in the advertising
-- 
2.14.3

