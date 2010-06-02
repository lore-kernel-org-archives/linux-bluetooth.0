Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 29/32] Call the agent when a new Health Link is created
Date: Wed,  2 Jun 2010 15:19:25 +0200
Message-Id: <1275484768-25838-30-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-29-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-21-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-22-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-23-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-24-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-25-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-26-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-27-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-28-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-29-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |   27 ++++++++++++++++++++++++---
 src/bluetooth.conf |    1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index e99e00a..f7146eb 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -760,14 +760,35 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 {
 	struct hdp_instance *hdpi = data;
 	struct hdp_link *hdpl;
+	DBusMessage* message;
 	GError *err = NULL;
 
 	debug("mcl_connected");
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

