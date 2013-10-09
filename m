Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] obexd/MAP: Fix sending \0 after filler byte
Date: Wed,  9 Oct 2013 14:11:40 +0300
Message-Id: <1381317105-10729-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
References: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It is not necessary to append \0 after the filler byte (0x30), the spec
just talk about the a byte not bytes.
---
 obexd/client/map.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 4373d74..9d90a92 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -729,7 +729,7 @@ static void set_status(const GDBusPropertyTable *property,
 	gboolean value;
 	GError *err = NULL;
 	GObexApparam *apparam;
-	char contents[2];
+	char contents[1];
 	char handle[21];
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN) {
@@ -742,7 +742,6 @@ static void set_status(const GDBusPropertyTable *property,
 	dbus_message_iter_get_basic(iter, &value);
 
 	contents[0] = FILLER_BYTE;
-	contents[1] = '\0';
 
 	if (snprintf(handle, sizeof(handle), "%" PRIu64, msg->handle) < 0)
 		goto fail;
@@ -1612,13 +1611,12 @@ static DBusMessage *map_update_inbox(DBusConnection *connection,
 {
 	struct map_data *map = user_data;
 	DBusMessage *reply;
-	char contents[2];
+	char contents[1];
 	struct obc_transfer *transfer;
 	GError *err = NULL;
 	struct pending_request *request;
 
 	contents[0] = FILLER_BYTE;
-	contents[1] = '\0';
 
 	transfer = obc_transfer_put("x-bt/MAP-messageUpdate", NULL, NULL,
 						contents, sizeof(contents),
@@ -1935,7 +1933,7 @@ static bool set_notification_registration(struct map_data *map, bool status)
 	struct obc_transfer *transfer;
 	GError *err = NULL;
 	GObexApparam *apparam;
-	char contents[2];
+	char contents[1];
 	const char *address;
 
 	address = obc_session_get_destination(map->session);
@@ -1951,7 +1949,6 @@ static bool set_notification_registration(struct map_data *map, bool status)
 	}
 
 	contents[0] = FILLER_BYTE;
-	contents[1] = '\0';
 
 	transfer = obc_transfer_put("x-bt/MAP-NotificationRegistration", NULL,
 					NULL, contents, sizeof(contents), &err);
-- 
1.8.3.1

