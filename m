Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Prefer BR/EDR over LE if it set in advertisement flag
Date: Wed, 10 Aug 2016 16:25:02 +0300
Message-Id: <1470835502-30698-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the code prefer BR/EDR if the last advertisement has it set
in the flags.
---
 src/adapter.c | 5 ++++-
 src/device.c  | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3742398..ddabf2d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5488,8 +5488,11 @@ static void update_found_devices(struct btd_adapter *adapter,
 	 * supports this we can make the non-zero check conditional.
 	 */
 	if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&
-					!(eir_data.flags & EIR_BREDR_UNSUP))
+					!(eir_data.flags & EIR_BREDR_UNSUP)) {
 		device_set_bredr_support(dev);
+		/* Update last seen for BR/EDR in case its flag is set */
+		device_update_last_seen(dev, BDADDR_BREDR);
+	}
 
 	if (eir_data.name != NULL && eir_data.name_complete)
 		device_store_cached_name(dev, eir_data.name);
diff --git a/src/device.c b/src/device.c
index 264d599..6c6be92 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1763,7 +1763,11 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	if (dev->le && (!dev->bredr || bredr_last == NVAL_TIME))
 		return dev->bdaddr_type;
 
-	if (bredr_last < le_last)
+	/*
+	 * Prefer BR/EDR if time is the same since it might be from an
+	 * advertisement with BR/EDR flag set.
+	 */
+	if (bredr_last <= le_last)
 		return BDADDR_BREDR;
 
 	return dev->bdaddr_type;
-- 
2.7.4

