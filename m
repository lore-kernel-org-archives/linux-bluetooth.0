Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 BlueZ 1/3] thermometer: Fix device driver probe
Date: Wed, 15 Feb 2012 08:38:17 -0400
Message-Id: <1329309499-14454-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

The probe() function for GATT profiles should be transport agnostic.
There is a btd_device_get_primaries() method which can be used to return
a list of discovered GATT Primary Services, and it works for BR/EDR and
LE. It is already used for Proximity, for instance.

device_services_from_record() is BR/EDR specific and should not be used
by GATT profile code.

It also fixes a memory leak, given device_services_from_record() returns
a heap allocated GSList.
---
 thermometer/manager.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/thermometer/manager.c b/thermometer/manager.c
index 6b98bca..9dfbbe8 100644
--- a/thermometer/manager.c
+++ b/thermometer/manager.c
@@ -34,16 +34,27 @@
 
 static DBusConnection *connection = NULL;
 
+static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct att_primary *prim = a;
+	const char *uuid = b;
+
+	return g_strcmp0(prim->uuid, uuid);
+}
+
 static int thermometer_driver_probe(struct btd_device *device, GSList *uuids)
 {
 	struct att_primary *tattr;
-	GSList *list;
+	GSList *primaries, *l;
+
+	primaries = btd_device_get_primaries(device);
 
-	list = device_services_from_record(device, uuids);
-	if (list == NULL)
+	l = g_slist_find_custom(primaries, HEALTH_THERMOMETER_UUID,
+							primary_uuid_cmp);
+	if (l == NULL)
 		return -EINVAL;
 
-	tattr = list->data;
+	tattr = l->data;
 
 	return thermometer_register(connection, device, tattr);
 }
-- 
1.7.5.4

