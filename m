Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/adapter: Fix not updating names of connected devices
Date: Mon, 12 Dec 2016 16:24:23 +0200
Message-Id: <20161212142423.31086-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there is a device found event for a connected device let it update
the name as the device may still be temporary but it might be useful to
display a proper name while profile connections or paring are pending.
---
 src/adapter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d951307..3dac7d6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5631,10 +5631,11 @@ static void update_found_devices(struct btd_adapter *adapter,
 		device_store_cached_name(dev, eir_data.name);
 
 	/*
-	 * If no client has requested discovery, then only update
-	 * already paired devices (skip temporary ones).
+	 * Only skip devices that are not connected, are temporary and there
+	 * is no active discovery session ongoing.
 	 */
-	if (device_is_temporary(dev) && !adapter->discovery_list) {
+	if (!btd_device_is_connected(dev) && (device_is_temporary(dev) &&
+						 !adapter->discovery_list)) {
 		eir_data_free(&eir_data);
 		return;
 	}
-- 
2.9.3

