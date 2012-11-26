Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC] doc: Split media transport volume into two parts
Date: Mon, 26 Nov 2012 11:46:31 +0100
Message-Id: <1353926791-8769-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Separate the input and output audio volumes in two independent
properties in order to control both speaker and microphone gains while
doing HSP/HFP.
---
This property was introduced quite recently but never implemented. Shouldn't we split it into two separate properties?

It wouldn't do much harm for the A2DP transports and it would be needed for HSP/HFP.

 doc/media-api.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index b4f2fc6..6515e5f 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -375,10 +375,18 @@ Properties	object Device [readonly]
 
 			Possible Values: "HCI" or "PCM"
 
-		uint16 Volume [readwrite]
+		uint16 InputVolume [readwrite] [optional]
 
-			Optional. Indicates volume level of the transport,
-			this property is only writeable when the transport was
-			acquired by the sender.
+			Indicates volume level of the transport's incoming
+			audio stream, if any. This property is only writeable
+			when the transport was acquired by the sender.
+
+			Possible Values: 0-127
+
+		uint16 OutputVolume [readwrite] [optional]
+
+			Indicates volume level of the transport's outgoing
+			audio stream, if any. This property is only writeable
+			when the transport was acquired by the sender.
 
 			Possible Values: 0-127
-- 
1.7.11.7

