Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v8 2/6] proximity: reporter: save global D-Bus connection
Date: Mon,  2 Apr 2012 22:12:38 +0300
Message-Id: <1333393962-21394-2-git-send-email-arik@wizery.com>
In-Reply-To: <1333393962-21394-1-git-send-email-arik@wizery.com>
References: <1333393962-21394-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This connection will be used by reporter GATT sub-profiles.
---
 proximity/reporter.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index bbb97ea..c5a3bb8 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -52,6 +52,8 @@ enum {
 	HIGH_ALERT = 0x02,
 };
 
+static DBusConnection *connection;
+
 static void register_link_loss(struct btd_adapter *adapter)
 {
 	uint16_t start_handle, h;
@@ -179,6 +181,9 @@ int reporter_init(struct btd_adapter *adapter)
 		return -ENOTSUP;
 	}
 
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
 	DBG("Proximity Reporter for adapter %p", adapter);
 
 	register_link_loss(adapter);
@@ -190,4 +195,5 @@ int reporter_init(struct btd_adapter *adapter)
 
 void reporter_exit(struct btd_adapter *adapter)
 {
+	dbus_connection_unref(connection);
 }
-- 
1.7.5.4

