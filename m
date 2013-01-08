Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 1/2] media: Add HFP/HSP gains to transport API
Date: Tue,  8 Jan 2013 10:41:04 +0100
Message-Id: <1357638065-19156-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1357638065-19156-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1357638065-19156-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add two independent and HSP/HFP-specific properties to the media
transport representing the input and output audio volumes.
---
 doc/media-api.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index e2a72dc..cdde6ea 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -393,4 +393,26 @@ Properties	object Device [readonly]
 			this property is only writeable when the transport was
 			acquired by the sender.
 
+			Note: the property will not be present for HSP/HFP
+			transports and MicrophoneGain/SpeakerGain should be
+			used instead.
+
 			Possible Values: 0-127
+
+		byte MicrophoneGain [readwrite]
+
+			Optional. Indicates volume level of the transport's
+			incoming audio stream for HSP/HFP transports. This
+			property is only writeable when the transport was
+			acquired by the sender.
+
+			Possible Values: 0-15
+
+		byte SpeakerGain [readwrite]
+
+			Optional. Indicates volume level of the transport's
+			outgoing audio stream for HSP/HFP transports. This
+			property is only writeable when the transport was
+			acquired by the sender.
+
+			Possible Values: 0-15
-- 
1.7.11.7

