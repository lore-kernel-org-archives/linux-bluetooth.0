Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC v0 3/5] doc: add RequestDiscoverable() and ReleaseDiscoverable()
Date: Thu,  6 Jun 2013 15:18:57 +0100
Message-Id: <1370528339-7921-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370528339-7921-1-git-send-email-gustavo@padovan.org>
References: <1370528339-7921-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

those methods should be used when the user wants BlueZ to tracks the
clients lifetime and release the discoverable session if the client goes
away without calling ReleaseDiscoverable().
When the last session is dsregistered Discoverable should be back to
False.
---
 doc/adapter-api.txt | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 74d235a..bb29795 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -35,6 +35,34 @@ Methods		void StartDiscovery()
 					 org.bluez.Error.Failed
 					 org.bluez.Error.NotAuthorized
 
+		void RequestDiscoverable()
+
+			This method starts an adapter Discoverable session,
+			if the Discoverable is False it will be set to True
+			and the D-Bus client who called it will be recorded
+			as the session owner. If it is True we only record
+			the session owner.
+
+			Setting the Discoverable property through the Set()
+			method is discouraged if you are using this method.
+
+			To release a session call ReleaseDiscoverable(). If
+			a client exits without calling it the session will
+			automatically removed.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+
+		void ReleaseDiscoverable()
+
+			This method removes a Discoverable session. When called
+			it will remove the session and make Discoverable False
+			if session removed is the last one.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+					 org.bluez.Error.NotAuthorized
+
 		void RemoveDevice(object device)
 
 			This removes the remote device object at the given
@@ -111,6 +139,10 @@ Properties	string Address [readonly]
 
 			For any new adapter this settings defaults to false.
 
+			If your system is using RequestDiscoverable() and
+			ReleaseDiscoverable() to make the adapter discoverable
+			you should not set this property directly.
+
 		boolean Pairable [readwrite]
 
 			Switch an adapter to pairable or non-pairable. This is
@@ -140,6 +172,10 @@ Properties	string Address [readonly]
 			The default value for the discoverable timeout should
 			be 180 seconds (3 minutes).
 
+			If your system is using RequestDiscoverable() and
+			ReleaseDiscoverable() to make the adapter discoverable
+			you should not set this property directly.
+
 		boolean Discovering [readonly]
 
 			Indicates that a device discovery procedure is active.
-- 
1.8.1.4

