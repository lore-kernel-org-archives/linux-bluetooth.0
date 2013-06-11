Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 5/9] doc: add EnablePairing() and DisablePairing()
Date: Tue, 11 Jun 2013 11:56:23 +0100
Message-Id: <1370948187-3702-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
References: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Those methods improve the tracking of the Discoverable and Pairable
properties for Pairing purposes. One could call EnablePairing() to get a
Pairing session.

DisablePairing() releases a session. If the client exits without calling
the DisablePairing() the session is also released.  When the last session
is released both Discoverable and Pairable goes back the value they had
before the first session started.

The Pairing property tracks if the there is a ongoing Pairing session.
---
 doc/adapter-api.txt | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 74d235a..dba037f 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -35,6 +35,43 @@ Methods		void StartDiscovery()
 					 org.bluez.Error.Failed
 					 org.bluez.Error.NotAuthorized
 
+		void EnablePairing()
+
+			This method starts a Pairing session, in other words,
+			it enables both Discoverable and Pairable properties
+			and tracks the lifetime of the client that requested
+			it. The client can release the session by calling
+			ReleasePairingSession(). The session is also released
+			if the clients exits unexpectedly.
+
+			Many sessions can be created by different clients. When
+			last session is released Discoverable and Pairable are
+			set back to wherever value they had before the request
+			of the first session.
+
+			The Pairing property show if there is a ongoing session
+			or not.
+
+			When one or more pairing session is running the
+			following properties goes to the readonly mode:
+			Discoverable, DiscoverableTimeout, Pairable and
+			PairableTimeout. An error will be returned if a
+			client tries to set their value.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+
+		void DisablePairing()
+
+			This method removes a Pairing session. When called
+			it will remove the session and if it is the last session
+			Discoverable and Pairable will be set to the value they
+			had before the beginning of the first session.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+					 org.bluez.Error.NotAuthorized
+
 		void RemoveDevice(object device)
 
 			This removes the remote device object at the given
@@ -111,6 +148,9 @@ Properties	string Address [readonly]
 
 			For any new adapter this settings defaults to false.
 
+			This property will become readonly if a Pairing session
+			is ongoing.
+
 		boolean Pairable [readwrite]
 
 			Switch an adapter to pairable or non-pairable. This is
@@ -122,6 +162,9 @@ Properties	string Address [readonly]
 
 			For any new adapter this settings defaults to true.
 
+			This property will become readonly if a Pairing session
+			is ongoing.
+
 		uint32 PairableTimeout [readwrite]
 
 			The pairable timeout in seconds. A value of zero
@@ -131,6 +174,9 @@ Properties	string Address [readonly]
 			The default value for pairable timeout should be
 			disabled (value 0).
 
+			This property will become readonly if a Pairing session
+			is ongoing.
+
 		uint32 DiscoverableTimeout [readwrite]
 
 			The discoverable timeout in seconds. A value of zero
@@ -140,10 +186,17 @@ Properties	string Address [readonly]
 			The default value for the discoverable timeout should
 			be 180 seconds (3 minutes).
 
+			This property will become readonly if a Pairing session
+			is ongoing.
+
 		boolean Discovering [readonly]
 
 			Indicates that a device discovery procedure is active.
 
+		boolean Pairing [readonly]
+
+			Indicates that one or more pairing session is active.
+
 		array{string} UUIDs [readonly]
 
 			List of 128-bit UUIDs that represents the available
-- 
1.8.1.4

