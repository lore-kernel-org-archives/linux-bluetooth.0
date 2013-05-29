Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 2/2] heartrate: Fix D-Bus registration error case
Date: Wed, 29 May 2013 14:38:24 +0200
Message-Id: <1369831104-23363-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369831104-23363-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369831104-23363-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

If g_dbus_register_interface() fails, the struct heartrate_adapter
memory will be freed and therefore the heartrate_adapters list cannot
contain such an invalid pointer.
---
 profiles/heartrate/heartrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 8de81bb..34ec9bc 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -730,8 +730,6 @@ static int heartrate_adapter_register(struct btd_adapter *adapter)
 	hradapter = g_new0(struct heartrate_adapter, 1);
 	hradapter->adapter = adapter;
 
-	heartrate_adapters = g_slist_prepend(heartrate_adapters, hradapter);
-
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 						adapter_get_path(adapter),
 						HEART_RATE_MANAGER_INTERFACE,
@@ -744,6 +742,8 @@ static int heartrate_adapter_register(struct btd_adapter *adapter)
 		return -EIO;
 	}
 
+	heartrate_adapters = g_slist_prepend(heartrate_adapters, hradapter);
+
 	return 0;
 }
 
-- 
1.8.1.4

