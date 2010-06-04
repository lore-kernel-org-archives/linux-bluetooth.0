Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 29/32] Call the agent when a new Health Link is created
Date: Fri,  4 Jun 2010 10:30:22 +0200
Message-Id: <1275640225-4186-30-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-29-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-5-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-6-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-8-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-9-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-10-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-11-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-12-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-13-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-14-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-15-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-16-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-17-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-18-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-19-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-20-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-21-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-22-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-23-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-24-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-25-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-26-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-27-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-28-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-29-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |   27 ++++++++++++++++++++++++---
 src/bluetooth.conf |    1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 58d0394..1fc1cb9 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -760,14 +760,35 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 {
 	struct hdp_instance *hdpi = data;
 	struct hdp_link *hdpl;
+	DBusMessage* message;
 	GError *err = NULL;
 
 	DBG("mcl_connected");
+
+	message = dbus_message_new_method_call(hdpi->aname, hdpi->apath,
+						HEALTH_AGENT, "LinkConnected");
+	if (!message) {
+		error("Couldn't allocate D-Bus message");
+		return;
+	}
+
 	hdpl = create_health_link(hdpi, mcl, &err);
-	if (err)
+	if (err) {
+		dbus_message_unref(message);
 		return;
-	/* TODO: Send the notification to the Agent */
-	hdpi->hlink = g_slist_prepend(hdpi->hlink, hdpl);
+	}
+
+	dbus_message_append_args(message,
+				DBUS_TYPE_OBJECT_PATH, &hdpl->path,
+				DBUS_TYPE_INVALID);
+
+	if (g_dbus_send_message(hdpi->adapter->conn, message)) {
+		hdpi->hlink = g_slist_prepend(hdpi->hlink, hdpl);
+		return;
+	}
+	error("D-Bus send failed");
+	health_link_free(hdpl);
+	dbus_message_unref(message);
 }
 
 static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 56e7a83..4471da5 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -12,6 +12,7 @@
     <allow send_destination="org.bluez"/>
     <allow send_interface="org.bluez.Agent"/>
     <allow send_interface="org.bluez.HandsfreeAgent"/>
+    <allow send_interface="org.bluez.HealthAgent"/>
   </policy>
 
   <policy at_console="true">
-- 
1.6.3.3

