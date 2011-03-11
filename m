Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/4] Fix not returning an error when Discover() fails
Date: Fri, 11 Mar 2011 14:53:00 -0300
Message-Id: <1299865982-13601-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1299865982-13601-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1299865982-13601-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the connection fails an error should be returned to inform
the user.

This adds a field to store the DBusMessage that caused the error,
so we can send the correct reply.
---
 attrib/client.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 47c5d4d..e67edc2 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -59,6 +59,7 @@ struct gatt_service {
 	char *path;
 	GSList *primary;
 	GAttrib *attrib;
+	DBusMessage *msg;
 	int psm;
 	gboolean listen;
 };
@@ -335,6 +336,12 @@ static void connect_cb(GIOChannel *chan, GError *gerr, gpointer user_data)
 	struct gatt_service *gatt = user_data;
 
 	if (gerr) {
+		if (gatt->msg) {
+			DBusMessage *reply = btd_error_failed(gatt->msg,
+							gerr->message);
+			g_dbus_send_message(connection, reply);
+		}
+
 		error("%s", gerr->message);
 		goto fail;
 	}
-- 
1.7.4.1

