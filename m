Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/bluetooth: Send device prop event only if prop changed
Date: Wed, 29 Jan 2014 00:47:15 +0100
Message-Id: <1390952835-23251-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1390952835-23251-1-git-send-email-szymon.janc@tieto.com>
References: <1390952835-23251-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reduce number of notification sends durring discovery session.
For devices found for the first time incurrent discovery session
always send all properties.
---
 android/bluetooth.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b95023c..a0a678b 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1068,6 +1068,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 	uint8_t *num_prop;
 	uint8_t opcode;
 	int size = 0;
+	bool found = false;
 
 	memset(buf, 0, sizeof(buf));
 	memset(&eir, 0, sizeof(eir));
@@ -1088,7 +1089,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		if (!dev)
 			dev = create_device(bdaddr, bdaddr_type);
 
-		dev->found = true;
+		found = true;
 
 		size += sizeof(*ev);
 
@@ -1118,7 +1119,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		bdaddr2android(bdaddr, ev->bdaddr);
 	}
 
-	if (eir.class) {
+	if (eir.class && (found || dev->class != eir.class)) {
 		dev->class = eir.class;
 
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_CLASS,
@@ -1126,7 +1127,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		(*num_prop)++;
 	}
 
-	if (rssi && rssi_threashold(dev->rssi, rssi)) {
+	if (rssi && (found || rssi_threashold(dev->rssi, rssi))) {
 		dev->rssi = rssi;
 
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_RSSI,
@@ -1134,7 +1135,7 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		(*num_prop)++;
 	}
 
-	if (eir.name) {
+	if (eir.name && (found || g_strcmp0(dev->name, eir.name))) {
 		g_free(dev->name);
 		dev->name = g_strdup(eir.name);
 
@@ -1143,6 +1144,9 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		(*num_prop)++;
 	}
 
+	if (found)
+		dev->found = true;
+
 	if (dev->bond_state != HAL_BOND_STATE_BONDED)
 		cache_device(dev);
 
-- 
1.8.5.3

