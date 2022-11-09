Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEA1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 15:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiKIPSI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiKIPSH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 10:18:07 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25841CFF5
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 07:18:05 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 9F2761C000D
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 15:18:04 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ 2/2] hostname: Fallback to transient hostname
Date:   Wed,  9 Nov 2022 16:17:56 +0100
Message-Id: <20221109151756.96673-2-hadess@hadess.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221109151756.96673-1-hadess@hadess.net>
References: <20221109151756.96673-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After pretty hostname, and static hostname, also support transient
hostname as a last resort before 'BlueZ X.XX'.

This happens on Fedora's Workstation installation as it calls
"hostnamectl set-hostname" on startup. In Fedora Silverblue, the default
hostname is set as fedora in /etc/os-release.

In both cases, we should fall back to that transient hostname, as bad as
it could be.

Note that the transient hostname needs to be monitored through the
kernel directly, as explained in:
https://www.freedesktop.org/software/systemd/man/org.freedesktop.hostname1.html
---
 plugins/hostname.c | 53 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/plugins/hostname.c b/plugins/hostname.c
index 14b6450b5..a12afb282 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -16,6 +16,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/utsname.h>
 
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
@@ -44,8 +45,10 @@
 static uint8_t major_class = MAJOR_CLASS_MISCELLANEOUS;
 static uint8_t minor_class = MINOR_CLASS_UNCATEGORIZED;
 
-static char *pretty_hostname = NULL;
-static char *static_hostname = NULL;
+static char *pretty_hostname    = NULL;
+static char *static_hostname    = NULL;
+static char *transient_hostname = NULL;
+static guint hostname_id = 0;
 
 /*
  * Fallback to static hostname only if empty pretty hostname was already
@@ -60,6 +63,10 @@ static const char *get_hostname(void)
 		if (static_hostname &&
 				g_str_equal(static_hostname, "") == FALSE)
 			return static_hostname;
+
+		if (transient_hostname &&
+				g_str_equal(transient_hostname, "") == FALSE)
+			return transient_hostname;
 	}
 
 	return NULL;
@@ -181,6 +188,32 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 	}
 }
 
+static void read_transient_hostname(void)
+{
+	struct utsname u;
+
+	if (uname(&u) != 0) {
+		g_free(transient_hostname);
+		transient_hostname = NULL;
+		DBG("failed to read transient hostname");
+		return;
+	}
+
+	g_free(transient_hostname);
+	transient_hostname = g_strdup(u.nodename);
+
+	DBG("read transient hostname: '%s'", transient_hostname);
+}
+
+static gboolean hostname_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	DBG("transient hostname changed");
+	read_transient_hostname();
+	adapter_foreach(update_class, NULL);
+	return TRUE;
+}
+
 static int hostname_probe(struct btd_adapter *adapter)
 {
 	DBG("");
@@ -261,9 +294,11 @@ static GDBusProxy *hostname_proxy = NULL;
 static int hostname_init(void)
 {
 	DBusConnection *conn = btd_get_dbus_connection();
+	GIOChannel *hostname_io;
 	int err;
 
 	read_dmi_fallback();
+	read_transient_hostname();
 
 	hostname_client = g_dbus_client_new(conn, "org.freedesktop.hostname1",
 						"/org/freedesktop/hostname1");
@@ -289,6 +324,14 @@ static int hostname_init(void)
 		hostname_client = NULL;
 	}
 
+	hostname_io = g_io_channel_new_file("/proc/sys/kernel/hostname", "r", NULL);
+	if (hostname_io) {
+		hostname_id = g_io_add_watch(hostname_io, G_IO_ERR, hostname_cb, NULL);
+		g_io_channel_unref(hostname_io);
+	} else {
+		DBG("failed to open /proc/sys/kernel/hostname");
+	}
+
 	return err;
 }
 
@@ -306,8 +349,14 @@ static void hostname_exit(void)
 		hostname_client = NULL;
 	}
 
+	if (hostname_id != 0) {
+		g_source_remove(hostname_id);
+		hostname_id = 0;
+	}
+
 	g_free(pretty_hostname);
 	g_free(static_hostname);
+	g_free(transient_hostname);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(hostname, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.37.3

