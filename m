Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 1/2] Merge service UUIDs from different BR/EDR EIR data
Date: Fri, 19 Nov 2010 10:50:40 -0400
Message-Id: <1290178241-8358-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For LE devices, service UUIDs present in advertising data are merged
into a single list. This change makes the same thing for BR/EDR devices.
---
 src/adapter.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8136229..c650a63 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3004,12 +3004,6 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	} else
 		alias = g_strdup(dev->alias);
 
-	if (dev->services) {
-		g_slist_foreach(dev->services, (GFunc) g_free, NULL);
-		g_slist_free(dev->services);
-		dev->services = NULL;
-	}
-
 	emit_device_found(adapter->path, paddr,
 			"Address", DBUS_TYPE_STRING, &paddr,
 			"Class", DBUS_TYPE_UINT32, &dev->class,
-- 
1.7.0.4

