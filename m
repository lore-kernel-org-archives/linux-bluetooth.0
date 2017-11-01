Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] client: Fix not detecting advertising instance is no longer valid
Date: Wed,  1 Nov 2017 16:31:52 +0200
Message-Id: <20171101143152.30642-2-luiz.dentz@gmail.com>
In-Reply-To: <20171101143152.30642-1-luiz.dentz@gmail.com>
References: <20171101143152.30642-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the advertising interfaces is removed while registered it should be
considered unregistered.
---
 client/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/client/main.c b/client/main.c
index 5ce65ef02..3536c9524 100644
--- a/client/main.c
+++ b/client/main.c
@@ -678,9 +678,7 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface, "org.bluez.GattManager1")) {
 		gatt_remove_manager(proxy);
 	} else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
-		if(!dbus_conn){
-			ad_unregister(dbus_conn, NULL);
-		}
+		ad_unregister(dbus_conn, NULL);
 	}
 }
 
-- 
2.13.6

