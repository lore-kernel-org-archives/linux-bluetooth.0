Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v8] doc/adapter-api.txt: StartFilteredDiscovery method.
Date: Thu,  5 Mar 2015 11:32:18 -0800
Message-Id: <1425583938-3008-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes new method, StartFilteredDiscovery to D-Bus Adapter
API for desktop bluetoothd. It will allow for rapid discovery of nearby
devices that advertise services.

It also adds FilteredDiscovery property, that is set to true when any
StartFilteredDiscovery session is active.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 doc/adapter-api.txt | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 74d235a..528f0ba 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -43,6 +43,65 @@ Methods		void StartDiscovery()
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.Failed
 
+		void SetDiscoveryFilter(dict filter) [Experimental]
+
+			This method sets the device discovery filter for
+			current discovery session. When this method is called
+			with no filter parameter, filter is removed.
+
+			Parameters that can be set in filter dictionary include
+			the following:
+
+			array{string} UUIDs : filtered service UUIDs (required)
+			int16 RSSI	: RSSI threshold value (optional)
+			uint16 pathloss	: Pathloss threshold value (optional)
+			string transport: type of scan to run
+
+			When a device is found that advertise any UUID from
+			UUIDs, it will be reported if:
+			- pathloss and RSSI are both empty,
+			- only pathloss param is set, device advertise TX pwer,
+			  and computed pathloss is less than pathloss param,
+			- only RSSI param is set, and received RSSI is higher
+			  than RSSI param,
+
+			transport parameter determines the type of scan:
+				"auto"	- interleaved scan
+				"bredr"	- br/edr inquiry
+				"le"	- le only scan, default value
+
+			If "le" or "bredr" transport is requested, and device
+			doesn't support it, org.bluez.Error.Failed error will
+			be returned. If "auto" transport is requested, scan
+			will use LE, BREDR, or both, depending on what's
+			currently enabled on controller.
+
+			When discovery filter is set, Device objects will be
+			created as new devices matching criteria are
+			discovered. It will also emit PropertiesChanged signal
+			for already existing Device objects, with updated RSSI
+			value. This is different from plain StartDiscovery
+			behaviour, that keeps imposing the delta-threshold. As
+			soon as there's one or more filters set, this type of
+			filtering is removed.
+
+			When multiple clients call StartDiscoveryFilter, their
+			filters are internally merged, and notifications about
+			new devices are sent to all clients. Therfore every
+			client must check wether Devices that he was notificed
+			about are matching it's filter.
+
+			When SetDiscoveryFilter is called multiple times, last
+			filter passed will be active for given client.
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

