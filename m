Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 6/7] attrib-api: Add RegisterWatcher/UnregisterWatcher methods
Date: Mon, 23 Jul 2012 11:55:19 -0400
Message-Id: <1343058920-18608-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These methods are used to register or unregister watchers for
characteristics, so applications can be notified when the characteristic
value changes.

The Release() method is added to the Watcher interface to notify the
watcher object that it has been unregistered and is no longer valid.
---
 doc/attribute-api.txt |    7 +++++++
 doc/service-api.txt   |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 4b392b9..0805756 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -120,3 +120,10 @@ Methods		void ValueChanged(object characteristic, dict value)
 
 			This method is only called when the "raw" setting is
 			enabled on Adapter.RegisterCharacteristicsWatcher().
+
+		void Release()
+
+			This method is called when the service daemon
+			unregisters the watcher, which can then perform cleanup
+			tasks. There is no need to unregister the watcher if
+			this method is called.
diff --git a/doc/service-api.txt b/doc/service-api.txt
index 5c8c7f3..0139f5f 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -43,6 +43,27 @@ Methods		uint32 AddRecord(string record)
 					 org.bluez.Error.DoesNotExist
 					 org.bluez.Error.Failed
 
+		void RegisterWatcher(object agent, dict settings,
+						array{object} characteristics)
+
+			Register a watcher to monitor characteristic changes.
+
+			A watcher will be registered for each specified
+			characteristic object. The settings dictionary has the
+			following format:
+
+			{
+				"raw": boolean (optional)
+			}
+
+			If the "raw" setting is enabled, the RawValueChanged()
+			watcher method is called when the characteristic value
+			changes, otherwise, ValueChanged() is called.
+
+		void UnregisterWatcher(object agent)
+
+			Unregister a characteristic watcher.
+
 		void RequestAuthorization(string address, uint32 handle)
 
 			Request an authorization for an incoming connection
-- 
1.7.9.5

