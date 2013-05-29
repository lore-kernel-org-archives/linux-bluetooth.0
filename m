Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 1/2] cyclingspeed: Fix D-Bus registration error case
Date: Wed, 29 May 2013 14:38:23 +0200
Message-Id: <1369831104-23363-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

If g_dbus_register_interface() fails, the struct csc_adapter memory will
be freed and therefore the csc_adapters list cannot contain such an
invalid pointer.
---
 profiles/cyclingspeed/cyclingspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 76be234..ea6076c 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -964,8 +964,6 @@ static int csc_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 	cadapter = g_new0(struct csc_adapter, 1);
 	cadapter->adapter = adapter;
 
-	csc_adapters = g_slist_prepend(csc_adapters, cadapter);
-
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 						adapter_get_path(adapter),
 						CYCLINGSPEED_MANAGER_INTERFACE,
@@ -978,6 +976,8 @@ static int csc_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 		return -EIO;
 	}
 
+	csc_adapters = g_slist_prepend(csc_adapters, cadapter);
+
 	return 0;
 }
 
-- 
1.8.1.4

