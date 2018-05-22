Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/8] doc/advertising-api: Add Discoverable property
Date: Tue, 22 May 2018 12:50:04 +0300
Message-Id: <20180522095011.517-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Discoverable which the application can use in case it want
to set the General Discoverable flag per instance.

Note: This would allow for example an application to advertise as
discoverable even if the adapter is not discoverable which may be
required by dual-mode as it may not require BR/EDR to be discoverable.
---
 doc/advertising-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index eef98ad91..96deeeccd 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -78,6 +78,14 @@ Properties	string Type
 				<Transport Discovery> <Organization Flags...>
 				0x26                   0x01         0x01...
 
+		bool Discoverable [Experimental]
+
+			Advertise as general discoverable. When present this
+			will override adapter Discoverable property.
+
+			Note: This property shall not be set when Type is set
+			to broadcast.
+
 		array{string} Includes
 
 			List of features to be included in the advertising
-- 
2.14.3

