Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 18/19] doc: Fix typo
Date: Thu, 12 Apr 2012 20:33:09 +0530
Message-id: <1334243001-17016-19-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/adapter-api.txt |    2 +-
 doc/audio-api.txt   |    2 +-
 doc/device-api.txt  |    2 +-
 doc/health-api.txt  |    6 +++---
 doc/media-api.txt   |    6 +++---
 doc/mgmt-api.txt    |    2 +-
 doc/serial-api.txt  |    2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 20cef03..0cded8c 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -261,7 +261,7 @@ Properties	string Address [readonly]
 
 			The pairable timeout in seconds. A value of zero
 			means that the timeout is disabled and it will stay in
-			pareable mode forever.
+			pairable mode forever.
 
 		uint32 DiscoverableTimeout [readwrite]
 
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index b85400b..02291fd 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -428,7 +428,7 @@ properties	boolean Connected [readonly]
 
 		uint16 RegistrationStatus [readonly]
 
-			Service availability indicatior of AG, where:
+			Service availability indicator of AG, where:
 			0 implies no service. No Home/Roam network available.
 			1 implies presence of service. Home/Roam network
 			available.
diff --git a/doc/device-api.txt b/doc/device-api.txt
index 69081d8..4a170e4 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -191,7 +191,7 @@ Properties	string Address [readonly]
 			device name. Setting an empty string as alias will
 			convert it back to the remote device name.
 
-			When reseting the alias with an empty string, the
+			When resetting the alias with an empty string, the
 			emitted PropertyChanged signal will show the remote
 			name again.
 
diff --git a/doc/health-api.txt b/doc/health-api.txt
index 3d0a717..7a000cb 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -82,8 +82,8 @@ Methods:
 	void DestroyChannel(object channel)
 
 		Destroys the data channel object. Only the creator of the
-		channel or the creator of the HealtApplication that received the
-		data channel will be able to destroy it
+		channel or the creator of the HealthApplication that received
+		the data channel will be able to destroy it.
 
 		Possible errors: org.bluez.Error.InvalidArguments
 				org.bluez.Error.NotFound
@@ -131,7 +131,7 @@ Methods:
 		Returns all properties for the interface. See the properties
 		section for available properties.
 
-		Posible errors: org.bluez.Error.NotAllowed
+		Possible errors: org.bluez.Error.NotAllowed
 
 	fd Acquire()
 
diff --git a/doc/media-api.txt b/doc/media-api.txt
index c53ab7b..7a593c3 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -25,7 +25,7 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 
 				byte Codec:
 
-					Assigned mumber of codec that the
+					Assigned number of codec that the
 					endpoint implements. The values should
 					match the profile specification which
 					is indicated by the UUID.
@@ -308,7 +308,7 @@ Properties	object Device [readonly]
 
 		byte Codec [readonly]
 
-			Assigned mumber of codec that the transport support.
+			Assigned number of codec that the transport support.
 			The values should match the profile specification which
 			is indicated by the UUID.
 
@@ -319,7 +319,7 @@ Properties	object Device [readonly]
 
 		uint16 Delay [readwrite]
 
-			Optional. Transport delay in 1/10 of milisecond, this
+			Optional. Transport delay in 1/10 of millisecond, this
 			property is only writeable when the transport was
 			acquired by the sender.
 
diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 4ede43d..51c9b46 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -347,7 +347,7 @@ Set Local Name Command
 	Return Parameters:	Name (249 Octets)
 				Short_Name (11 Octets)
 
-	The name parameters need to always end with a nul byte (failure
+	The name parameters need to always end with a null byte (failure
 	to do so will cause the command to fail).
 
 	This command can be used when the controller is not powered and
diff --git a/doc/serial-api.txt b/doc/serial-api.txt
index ad496d2..0bdbdcd 100644
--- a/doc/serial-api.txt
+++ b/doc/serial-api.txt
@@ -51,7 +51,7 @@ Methods		fd ConnectFD(string pattern) [experimental]
 			timeouts in the client it is fine to call this method.
 
 			In that case one of patterns of the Connect method should
-			be suplied instead of the TTY device.
+			be supplied instead of the TTY device.
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
-- 
1.7.4.1

