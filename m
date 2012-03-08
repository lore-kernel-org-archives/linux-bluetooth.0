Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 4/8] proximity: reporter: save global D-Bus connection
Date: Thu,  8 Mar 2012 15:57:08 +0200
Message-Id: <1331215032-27695-5-git-send-email-arik@wizery.com>
In-Reply-To: <1331215032-27695-1-git-send-email-arik@wizery.com>
References: <1331215032-27695-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This connection will be used by reporter GATT sub-profiles.
---
 proximity/reporter.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index 9777574..f7744f5 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -29,6 +29,7 @@
 #include <glib.h>
 #include <bluetooth/uuid.h>
 #include <adapter.h>
+#include <errno.h>
 
 #include "log.h"
 
@@ -38,6 +39,7 @@
 #include "attrib-server.h"
 #include "reporter.h"
 
+static DBusConnection *connection;
 #define IMMEDIATE_ALERT_SVC_UUID	0x1802
 #define LINK_LOSS_SVC_UUID		0x1803
 #define TX_POWER_SVC_UUID		0x1804
@@ -177,6 +179,9 @@ int reporter_init(struct btd_adapter *adapter)
 		return -1;
 	}
 
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
 	DBG("Proximity Reporter for adapter %p", adapter);
 
 	register_link_loss(adapter);
@@ -188,4 +193,5 @@ int reporter_init(struct btd_adapter *adapter)
 
 void reporter_exit(struct btd_adapter *adapter)
 {
+	dbus_connection_unref(connection);
 }
-- 
1.7.5.4

