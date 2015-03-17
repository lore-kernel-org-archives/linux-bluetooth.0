Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] core: Make device_set_bonded reset temporary flag
Date: Tue, 17 Mar 2015 11:13:15 +0200
Message-Id: <1426583595-28502-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426583595-28502-1-git-send-email-luiz.dentz@gmail.com>
References: <1426583595-28502-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If device is set to bonded it means some info has been stored so it
cannot be temporary anymore.
---
 src/adapter.c | 4 ----
 src/device.c  | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 691549a..6eeb2f9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6043,8 +6043,6 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 								key->pin_len);
 
 		device_set_bonded(device, BDADDR_BREDR);
-
-		btd_device_set_temporary(device, false);
 	}
 
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
@@ -6160,8 +6158,6 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 					key->type, key->enc_size, ediv, rand);
 
 		device_set_bonded(device, addr->type);
-
-		btd_device_set_temporary(device, false);
 	}
 
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
diff --git a/src/device.c b/src/device.c
index 14bfe7b..aaa9f43 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4518,6 +4518,8 @@ void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type)
 		device->bredr_state.bonded = true;
 	else
 		device->le_state.bonded = true;
+
+	btd_device_set_temporary(device, false);
 }
 
 void device_set_legacy(struct btd_device *device, bool legacy)
-- 
2.1.0

