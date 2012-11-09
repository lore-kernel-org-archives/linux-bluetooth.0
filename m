Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/4] doc: Update proximity API document
Date: Fri, 9 Nov 2012 13:33:20 +0100
Message-ID: <1352464401-12702-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352464401-12702-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352464401-12702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/proximity-api.txt | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
index c8eae50..b68a4fe 100644
--- a/doc/proximity-api.txt
+++ b/doc/proximity-api.txt
@@ -11,27 +11,7 @@ Service		org.bluez
 Interface	org.bluez.ProximityMonitor
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
-Methods		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			properties section for available properties.
-
-		void SetProperty(string name, variant value)
-
-			Changes the value of the specified property. Only
-			properties that are listed as read-write are changeable.
-			On success this will emit a PropertyChanged signal.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-
-Signals		PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of a given
-			property.
-
-Properties
-
-		string SignalLevel[readonly]
+Properties	string SignalLevel [readonly]
 
 			Alert indicating that a threshold has been reached.
 			Possible values: "unknown", "good", "regular", "weak"
@@ -63,19 +43,7 @@ Service		org.bluez
 Interface	org.bluez.ProximityReporter
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
-Methods		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			properties section for available properties.
-
-Signals		PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of a given
-			property.
-
-Properties
-
-		string ImmediateAlertLevel [readonly]
+Properties	string ImmediateAlertLevel [readonly]
 
 			This property indicates that Immediate Alert Level
 			characteristic in the local Immediate Alert Service
-- 
1.8.0

