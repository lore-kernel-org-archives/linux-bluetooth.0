Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 07/13] dbus: Add UUID property to org.bluez.Service1
Date: Mon,  6 May 2013 10:43:24 +0200
Message-Id: <1367829810-8262-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Expose in D-Bus the remote UUID corresponding to each service instance.
---
 src/service.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/service.c b/src/service.c
index b5b0a8e..9487c1a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -359,8 +359,20 @@ static gboolean service_get_device(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean service_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_service *service = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+						&service->profile->remote_uuid);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable service_properties[] = {
 	{ "Device", "o", service_get_device },
+	{ "UUID", "s", service_get_uuid },
 	{ }
 };
 
-- 
1.8.1.4

