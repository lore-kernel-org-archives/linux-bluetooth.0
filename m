Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 14/17] sap-dummy: Fix initialization if multiple adapters are present
Date: Wed, 6 Jun 2012 15:19:24 +0200
Message-ID: <1338988767-19467-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sap-dummy is a SAP server backend so its init function is called for
each adapter registered and not only on start. Without this patch
sap-dummy interface was only registered for first adapter.
---
 sap/sap-dummy.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index 2ad8af4..dab5acc 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -43,6 +43,7 @@ enum {
 };
 
 static DBusConnection *connection = NULL;
+static unsigned int init_cnt = 0;
 
 static int sim_card_conn_status = SIM_DISCONNECTED;
 static void *sap_data = NULL; /* SAP server private data. */
@@ -355,6 +356,9 @@ static const GDBusMethodTable dummy_methods[] = {
 
 int sap_init(void)
 {
+	if (init_cnt++)
+		return 0;
+
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 
 	if (g_dbus_register_interface(connection, SAP_DUMMY_PATH,
@@ -362,8 +366,11 @@ int sap_init(void)
 				NULL, NULL) == FALSE) {
 		error("sap-dummy interface %s init failed on path %s",
 					SAP_DUMMY_IFACE, SAP_DUMMY_PATH);
-		dbus_connection_unref(connection);
-		connection = NULL;
+
+		if (init_cnt--) {
+			dbus_connection_unref(connection);
+			connection = NULL;
+		}
 		return -1;
 	}
 
@@ -372,6 +379,9 @@ int sap_init(void)
 
 void sap_exit(void)
 {
+	if (--init_cnt)
+		return;
+
 	g_dbus_unregister_interface(connection, SAP_DUMMY_PATH,
 							SAP_DUMMY_IFACE);
 
-- 
on behalf of ST-Ericsson

