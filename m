Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 1/2] obexd: Emit file information for client
Message-ID: <abac898f-8f93-7a35-06b7-d23186895818@jp.fujitsu.com>
Date: Fri, 12 Jan 2018 15:23:40 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When running obexctl and then starting to transfer a file, obexctl does
not retrieve the "Size" property. Thus it outputs the huge remaining time
as below:

  [NEW] Transfer /org/bluez/obex/server/session1/transfer0
  [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Status: active
  [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 32683 (@32KB/s 4286681714:4294967273)
  [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 65444 (@32KB/s 428259:59)

This change makes obexd emit the file information including the "Size"
property, since obexctl may output the huge remaining time first if
obexctl calls g_dbus_proxy_refresh_property(). As the result, obexctl can
retrieve the "Size" property and the info command of obexctl can output
the filename of the transferring file.
---
 obexd/src/manager.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 78b138c85..6c83479f4 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -533,10 +533,15 @@ void manager_cleanup(void)
 
 void manager_emit_transfer_started(struct obex_transfer *transfer)
 {
+	const GDBusPropertyTable *property;
+
 	transfer->status = TRANSFER_STATUS_ACTIVE;
 
-	g_dbus_emit_property_changed(connection, transfer->path,
-					TRANSFER_INTERFACE, "Status");
+	for (property = transfer_properties;
+				property && property->name; property++)
+		g_dbus_emit_property_changed(connection, transfer->path,
+						TRANSFER_INTERFACE,
+						property->name);
 }
 
 static void emit_transfer_completed(struct obex_transfer *transfer,
-- 
2.14.1

