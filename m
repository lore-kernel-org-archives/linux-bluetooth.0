Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 14/15] doc: Update thermometer API document
Date: Fri, 9 Nov 2012 09:55:56 +0100
Message-ID: <1352451357-22097-15-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates thermometer-api.txt document to include changes in
properties handling.
---
 doc/thermometer-api.txt | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/doc/thermometer-api.txt b/doc/thermometer-api.txt
index 7b99800..cab115f 100644
--- a/doc/thermometer-api.txt
+++ b/doc/thermometer-api.txt
@@ -48,24 +48,6 @@ Interface	org.bluez.Thermometer
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
-Signals		PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of the given
-			property.
-
 Properties	boolean Intermediate [readonly]
 
 			True if the thermometer supports intermediate
-- 
1.8.0

