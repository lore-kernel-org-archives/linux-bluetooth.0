Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ v2 1/2] obexd: Emit file information for client
Message-ID: <20a39652-482a-9fde-6d44-0a8147f156fe@jp.fujitsu.com>
Date: Mon, 15 Jan 2018 21:46:06 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When running obexctl and then starting to transfer a file, it does not
retrieve the Size property correctly. Thus it prints out the huge
remaining time as below:

  [NEW] Transfer /org/bluez/obex/server/session1/transfer0
  [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Status: active
  [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 32683 (@32KB/s 4286681714:4294967273)
  [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 65444 (@32KB/s 428259:59)

And the info command only prints out the Session/Status/Size/Transferred
properties and does not print out the others as below:

  # info /org/bluez/obex/server/session1/transfer0
  Transfer /org/bluez/obex/server/session1/transfer0
          Session: /org/bluez/obex/server/session1
          Status: active
          Size: 18446744073709551614
          Transferred: 262010
  [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 294771 (@32KB/s 428259:52)

This change makes obexd emit the all properties, including the Size
property, since the first info command may not print out the all
properties if changing obexctl.
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

