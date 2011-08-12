Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] doc: add org.bluez.Handsfree interface
Date: Fri, 12 Aug 2011 15:28:00 +0200
Message-Id: <1313155680-10759-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This change allows to share the same interface for both Handsfree HF
and AG (only diffrence is interface name), and most part of the code.

This will imply to rename and update audio/gateway.[ch] to be more hfp
generic (moving it to audio/hfp.[ch], renaming APIs from gateway_...()
to hfp_...()).

Adding version and features to RegisterAgent interface will allow BlueZ
to adapt the SDP record to agent capabilities.
---
 doc/hfp-api.txt |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/doc/hfp-api.txt b/doc/hfp-api.txt
index cf2e730..d50a048 100644
--- a/doc/hfp-api.txt
+++ b/doc/hfp-api.txt
@@ -1,3 +1,63 @@
+Handsfree hierarchy
+========================
+
+Service		org.bluez
+Interface	org.bluez.Handsfree
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+This interface is available for remote devices which can function in the
+HandsFree role of the HFP profiles.  It is intended to be used with external
+telephony stacks / handlers of the HFP protocol.
+
+Methods		void Connect()
+
+			Connect to the AG service on the remote device.
+
+		void Disconnect()
+
+			Disconnect from the AG service on the remote device
+
+		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+		void RegisterAgent(object path, uint16 version, uint32 features)
+
+			The object path defines the path the of the agent
+			that will be called when a new Handsfree connection
+			is established.
+			Version and features are the profile version and
+			HandsFree features (like for +BRSF reply) supported by
+			the agent.
+
+			If an application disconnects from the bus all of its
+			registered agents will be removed.
+
+		void UnregisterAgent(object path)
+
+			This unregisters the agent that has been previously
+			registered. The object path parameter must match the
+			same value that has been used on registration.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InvalidArguments
+
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string State [readonly]
+
+			Indicates the state of the connection.  Possible
+			values are:
+				"disconnected"
+				"connecting"
+				"connected"
+				"playing"
+
 Gateway hierarchy
 ========================
 
@@ -22,11 +82,14 @@ Methods		void Connect()
 			Returns all properties for the interface. See the
 			properties section for available properties.
 
-		void RegisterAgent(object path)
+		void RegisterAgent(object path, uint16 version, uint32 features)
 
 			The object path defines the path the of the agent
 			that will be called when a new Handsfree connection
 			is established.
+			Version and features are the profile version and
+			HandsFree features (like for AT+BRSF command) supported
+			by the agent.
 
 			If an application disconnects from the bus all of its
 			registered agents will be removed.
-- 
1.7.1

