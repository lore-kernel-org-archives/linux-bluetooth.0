Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v7 2/6] proximity: reporter: save global D-Bus connection
Date: Mon,  2 Apr 2012 14:17:20 +0300
Message-Id: <1333365444-9029-2-git-send-email-arik@wizery.com>
In-Reply-To: <1333365444-9029-1-git-send-email-arik@wizery.com>
References: <1333365444-9029-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This connection will be used by reporter GATT sub-profiles.
---
 proximity/reporter.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index bbb97ea..87242d2 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -40,6 +40,7 @@
 #include "attrib-server.h"
 #include "reporter.h"
 
+static DBusConnection *connection;
 #define IMMEDIATE_ALERT_SVC_UUID	0x1802
 #define LINK_LOSS_SVC_UUID		0x1803
 #define TX_POWER_SVC_UUID		0x1804
@@ -179,6 +180,9 @@ int reporter_init(struct btd_adapter *adapter)
 		return -ENOTSUP;
 	}
 
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
 	DBG("Proximity Reporter for adapter %p", adapter);
 
 	register_link_loss(adapter);
@@ -190,4 +194,5 @@ int reporter_init(struct btd_adapter *adapter)
 
 void reporter_exit(struct btd_adapter *adapter)
 {
+	dbus_connection_unref(connection);
 }
-- 
1.7.5.4

