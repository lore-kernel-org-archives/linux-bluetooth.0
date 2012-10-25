Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 11/18] doc: Remove Get-/SetProperties from CSC API document
Date: Thu, 25 Oct 2012 16:43:41 +0200
Message-ID: <1351176228-5789-12-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

cyclingspeed plugin uses DBus.Properties instead of custom methods.
---
 doc/cycling-api.txt | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/doc/cycling-api.txt b/doc/cycling-api.txt
index adbcd33..08e11c8 100644
--- a/doc/cycling-api.txt
+++ b/doc/cycling-api.txt
@@ -28,31 +28,13 @@ Service		org.bluez
 Interface	org.bluez.CyclingSpeed
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
-Methods		void SetProperty(string name, variant value)
-
-			Changes the value of the specified property. Only
-			read-write properties can be changed. On success
-			this will emit a PropertyChanged signal.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-
-		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			Properties section for the available properties.
-
-		SetCumulativeWheelRevolutions(uint32 value)
+Methods		SetCumulativeWheelRevolutions(uint32 value)
 
 			Sets cumulative wheel revolutions value if
 			Cumulative Wheel Revolutions feature is supported.
 
 			Possible Errors: org.bluez.Error.NotSupported
 
-Signals		PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of the given
-			property.
-
 Properties	string Location (optional) [readwrite]
 
 			Current sensor location, if supported.
-- 
1.8.0

