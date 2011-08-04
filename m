Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 5/7] sap: disconnect RFCOMM when Disconnect gets called
Date: Thu,  4 Aug 2011 16:39:32 -0300
Message-Id: <1312486774-20350-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1312486774-20350-5-git-send-email-padovan@profusion.mobi>
References: <1312486774-20350-1-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-2-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-3-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-4-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 sap/client.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/sap/client.c b/sap/client.c
index 435a82f..93ba54d 100644
--- a/sap/client.c
+++ b/sap/client.c
@@ -121,6 +121,24 @@ static void change_state(struct client *client, int new_state)
 			DBUS_TYPE_STRING, &val);
 }
 
+static gboolean disconnect_rfcomm(gpointer data)
+{
+	struct client *client = data;
+	int sock;
+
+	if (!client->io)
+		return FALSE;
+
+	sock = g_io_channel_unix_get_fd(client->io);
+	shutdown(sock, SHUT_RDWR);
+
+	g_io_channel_unref(client->io);
+	g_io_channel_shutdown(client->io, TRUE, NULL);
+	client->io = NULL;
+
+	return FALSE;
+}
+
 static gboolean rfcomm_io(GIOChannel *io, GIOCondition cond, gpointer data)
 {
 	struct client *client = data;
@@ -230,7 +248,7 @@ static DBusMessage *client_disconnect(DBusConnection *conn,
 	if (client->msg)
 		return btd_error_in_progress(msg);
 
-	 /* TODO: exit from remote SIM mode */
+	disconnect_rfcomm(client);
 
 	return dbus_message_new_method_return(msg);
 }
-- 
1.7.6

