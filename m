Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Initial draft of Application registration API
Date: Fri, 10 Dec 2010 01:13:37 -0300
Message-Id: <1291954417-18138-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add new methods to allow automatic connection when a known remote device
which supports the wanted services is found.

Overview: RegisterApplication method allows a given application to
controls the connection establishment procedure for bonded devices.
StartDiscovery() implements an interleaved discovery, switching between
inquiry and LE active scanning. For single mode devices found, an
application can call CreateDevice or CreatePairedDevice, these methods
will trigger the Discover All Primary Services and SSP(if applied).
Characteristics will be fetched on demand to avoid unnecessary data
transfers.

The Generic attribute API exposes methods to applications to read and
write characteristics. Implement profile specific API will be avoided.
For example, Proximity Monitor may need a BlueZ plugin to monitor the
path loss however additional method specific to this profile doesn't
need to be exposed. The Generic API can expose all the characteristic
necessary to a Proximity client application.

Characteristic Watchers allow the applications to monitor(passively)
characteristics changes for a given primary service. It doesn't control
or trigger any connection establishment.

Register application will act as an advertising monitor, allowing
external applications to control passive scanning and automatic
connections(for bonded devices).

Open: Define the necessary parameters for RegisterApplication, support
for GAP Broadcaster/Observer, define if RegisterApplication needs to
support BR/EDR connections, maybe merge Watchers and Application
interfaces.
---
 doc/attribute-api.txt |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 23808e6..ab62313 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -23,7 +23,6 @@ fully transparent and a differentiation becomes unimportant in the future.
 A service consists of some generic service information and a set of
 characteristics. All characteristic are presented as object path as well.
 
-
 Local Service hierarchy
 =======================
 
@@ -37,6 +36,35 @@ Methods
 Properties
 
 
+Adapter Application Attribute hierarchy
+=======================================
+
+Service		org.bluez
+Interface	org.bluez.Attrib
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		void RegisterApplication(array{string} uuids, dict settings)
+
+			Method to allow applications to control automatic
+			connections to known devices.
+
+			"settings" dictionary defines the wanted application
+			connection parameters. Defined values:
+			- Latency: low, medium and high
+			- BandWidth: TBD
+			- AutoConnect: boolean
+
+			Latency parameter controls the scan and connect
+			interval. AutoConnect parameter controls automatic
+			connections if a bonded device emits a connectable
+			advertising report.
+
+		void UnregisterApplication(array{string} uuids)
+
+			Unregister a previously registered application.
+			Remotes are automatically disconnected if no more
+			applications are interested in the given services.
+
 Device Service hierarchy
 ========================
 
@@ -154,3 +182,17 @@ Object path	freely definable
 Methods		void ValueChanged(object characteristic, array{byte})
 
 			New raw value of the Characteristic Value attribute.
+
+Adapter Application Agent hierarchy
+====================================
+
+Service		unique name
+Interface	org.bluez.Application
+Object path	freely definable
+
+Methods		void Connected(object device, array{object} services)
+
+			Indication that a given remote device was found
+			and the connection has been established. service
+			object represents an instance of a primary service
+			that the application is interested in.
-- 
1.7.3.3

