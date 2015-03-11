Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v12] doc/adapter-api.txt: SetDiscoveryFilter method.
Date: Wed, 11 Mar 2015 09:03:26 -0700
Message-Id: <1426089806-30249-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes new method, SetDiscoveryFilter to D-Bus Adapter
API for desktop bluetoothd. It will allow to set per-client discovery
filter that would limit devices being discovered.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 doc/adapter-api.txt | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 74d235a..1332dcc 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -19,6 +19,8 @@ Methods		void StartDiscovery()
 			This process will start creating Device objects as
 			new devices are discovered.
 
+			During discovery RSSI delta-threshold is imposed.
+
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 
@@ -43,6 +45,65 @@ Methods		void StartDiscovery()
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.Failed
 
+		void SetDiscoveryFilter(dict filter) [Experimental]
+
+			This method sets the device discovery filter for the
+			caller. When this method is called with no filter
+			parameter, filter is removed.
+
+			Parameters that may be set in the filter dictionary
+			include the following:
+
+			array{string} UUIDs : filtered service UUIDs (required)
+			int16 RSSI	: RSSI threshold value (optional)
+			uint16 Pathloss	: Pathloss threshold value (optional)
+			string Transport: type of scan to run
+
+			When a remote device is found that advertises any UUID
+			from UUIDs, it will be reported if:
+			- Pathloss and RSSI are both empty,
+			- only Pathloss param is set, device advertise TX pwer,
+			  and computed pathloss is less than Pathloss param,
+			- only RSSI param is set, and received RSSI is higher
+			  than RSSI param,
+
+			Transport parameter determines the type of scan:
+				"auto"	- interleaved scan, default value
+				"bredr"	- BR/EDR inquiry
+				"le"	- LE scan only
+
+			If "le" or "bredr" Transport is requested, and the
+			controller doesn't support it, org.bluez.Error.Failed
+			error will be returned. If "auto" transport is
+			requested, scan will use LE, BREDR, or both, depending
+			on what's currently enabled on the controller.
+
+			When discovery filter is set, Device objects will be
+			created as new devices with matching criteria are
+			discovered. PropertiesChanged signals will be emitted
+			for already existing Device objects, with updated RSSI
+			value. If one or more discovery filters have been set,
+			the RSSI delta-threshold, that is imposed by
+			StartDiscovery by default, will not be applied.
+
+			When multiple clients call SetDiscoveryFilter, their
+			filters are internally merged, and notifications about
+			new devices are sent to all clients. Therefore, each
+			client must check that device updates actually match
+			its filter.
+
+			When SetDiscoveryFilter is called multiple times by the
+			same client, last filter passed will be active for
+			given client.
+
+			SetDiscoveryFilter can be called before StartDiscovery.
+			It is useful when client will create first discovery
+			session, to ensure that proper scan will be started
+			right after call to StartDiscovery.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
-- 
2.2.0.rc0.207.ga3a616c

