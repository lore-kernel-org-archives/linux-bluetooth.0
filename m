Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 5/8] attrib: Fix missing Discovery reply when disconnected
Date: Wed, 21 Mar 2012 13:00:52 -0400
Message-Id: <1332349255-15764-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch fixes missing reply for DiscoverCharacteristics method on
Generic Attribute. If link is disconnected reply message is not sent.
---
 attrib/client.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index a4e7d4c..bbb7de3 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -355,6 +355,20 @@ static void attio_disconnected(gpointer user_data)
 {
 	struct gatt_service *gatt = user_data;
 
+	if (gatt->query) {
+		if (gatt->query->msg) {
+			DBusMessage *reply;
+
+			reply = btd_error_failed(gatt->query->msg,
+						strerror(ECONNRESET));
+			g_dbus_send_message(gatt->conn, reply);
+			dbus_message_unref(gatt->query->msg);
+		}
+
+		g_slist_free_full(gatt->query->list, g_free);
+		gatt->query = NULL;
+	}
+
 	if (gatt->attrib) {
 		g_attrib_unref(gatt->attrib);
 		gatt->attrib = NULL;
-- 
1.7.5.4

