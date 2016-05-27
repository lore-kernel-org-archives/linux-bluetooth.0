Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] core/device: Make filtered discovery able to detect beacons
Date: Fri, 27 May 2016 14:18:29 +0300
Message-Id: <1464347909-19738-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it possible to use SetDiscoveryFilter to disable checking
discoverable flags making it possible to see beacons such as the ones
create by tools/eddystone that doesn't show on regular discovery sessions
since they are not discoverable/connectable.
---
This is an alternative to core/device: Fix checking flags for
non-connectable advertisements as it would not spam the UI trying to
configure new devices with beacons and improve the filtered discovery
to be more useful in regard of matching beacons.


 doc/adapter-api.txt | 6 +++++-
 src/adapter.c       | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 4dbf879..97462a3 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -80,7 +80,11 @@ Methods		void StartDiscovery()
 
 			When discovery filter is set, Device objects will be
 			created as new devices with matching criteria are
-			discovered. PropertiesChanged signals will be emitted
+			discovered regardless of they are connectable or
+			discoverable which enables listening to
+			non-connectable and non-discoverable devices.
+
+			PropertiesChanged signals will be emitted
 			for already existing Device objects, with updated RSSI
 			value. If one or more discovery filters have been set,
 			the RSSI delta-threshold, that is imposed by
diff --git a/src/adapter.c b/src/adapter.c
index f4fbf82..5499bfc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5451,7 +5451,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 	memset(&eir_data, 0, sizeof(eir_data));
 	eir_parse(&eir_data, data, data_len);
 
-	if (bdaddr_type == BDADDR_BREDR)
+	if (bdaddr_type == BDADDR_BREDR || adapter->filtered_discovery)
 		discoverable = true;
 	else
 		discoverable = eir_data.flags & (EIR_LIM_DISC | EIR_GEN_DISC);
-- 
2.5.5

