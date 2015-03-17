Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] core/adapter: Remove checks to device_is_temporary
Date: Tue, 17 Mar 2015 11:13:14 +0200
Message-Id: <1426583595-28502-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426583595-28502-1-git-send-email-luiz.dentz@gmail.com>
References: <1426583595-28502-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btd_device_set_temporary already checks if value is already set.
---
 src/adapter.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 09219e5..691549a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6044,8 +6044,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 
 		device_set_bonded(device, BDADDR_BREDR);
 
-		if (device_is_temporary(device))
-			btd_device_set_temporary(device, false);
+		btd_device_set_temporary(device, false);
 	}
 
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
@@ -6162,8 +6161,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 
 		device_set_bonded(device, addr->type);
 
-		if (device_is_temporary(device))
-			btd_device_set_temporary(device, false);
+		btd_device_set_temporary(device, false);
 	}
 
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
@@ -6264,8 +6262,7 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 	store_csrk(bdaddr, &key->addr.bdaddr, key->addr.type, key->val, 0,
 								key->type);
 
-	if (device_is_temporary(device))
-		btd_device_set_temporary(device, false);
+	btd_device_set_temporary(device, false);
 }
 
 static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
@@ -6352,8 +6349,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 
 	store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
 
-	if (device_is_temporary(device))
-		btd_device_set_temporary(device, false);
+	btd_device_set_temporary(device, false);
 }
 
 static void store_conn_param(struct btd_adapter *adapter, const bdaddr_t *peer,
-- 
2.1.0

