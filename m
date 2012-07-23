Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 5/7] attrib-api: Update Watcher interface methods
Date: Mon, 23 Jul 2012 11:55:18 -0400
Message-Id: <1343058920-18608-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are now two different methods for the interface. Only one method
is called, based on the "raw" setting being enabled or not when
registering the watcher.
---
 doc/attribute-api.txt |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 4f7dd40..4b392b9 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -105,6 +105,18 @@ Service		unique name
 Interface	org.bluez.Watcher
 Object path	freely definable
 
-Methods		void ValueChanged(object characteristic, array{byte})
+Methods		void ValueChanged(object characteristic, dict value)
 
-			New raw value of the Characteristic Value attribute.
+			The value dictionary contains the new value for the
+			Characteristic. The format is the same returned by
+			Characteristic.GetValue().
+
+			This method is only called when the "raw" setting is
+			disabled on Adapter.RegisterCharacteristicsWatcher().
+
+		void RawValueChanged(object characteristic, array{byte} value)
+
+			New raw Characteristic value.
+
+			This method is only called when the "raw" setting is
+			enabled on Adapter.RegisterCharacteristicsWatcher().
-- 
1.7.9.5

