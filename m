Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] device: Reply ATT requests during bonding
Date: Wed,  8 Feb 2012 14:55:08 -0300
Message-Id: <1328723708-21731-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328723708-21731-1-git-send-email-andre.guedes@openbossa.org>
References: <1328723708-21731-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unlike BR/EDR which has a dynamically allocated L2CAP data
channel, LE has a fix L2CAP channel where data are transmitted
(CID 4). This means that once the LE link is established the
remote device is able to send data (ATT messages) to the local
device.

Due to the ATT sequential request-response protocol, once a
client sends a request to a server, that client shall send
no other request to the same server until a response PDU has
been received. If the response PDU arrives in 30 secs the
remote device disconnects.

This way, in order to be able to reply ATT requests which may
come through channel ID 4 during the pairing, we first
establish an ATT connection and then we start the pairing
process.

That issue was discovered during test sessions in UPF. We
found some LE devices sending ATT Requests in CID 4 while
pairing was still in progress
---
 src/device.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 36d07ca..763c79c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2324,6 +2324,29 @@ static void create_bond_req_exit(DBusConnection *conn, void *user_data)
 	}
 }
 
+static void bonding_connect_cb(GIOChannel *io, GError *gerr,
+							gpointer user_data)
+{
+	struct btd_device *device = user_data;
+
+	g_io_channel_unref(device->att_io);
+	device->att_io = NULL;
+
+	if (gerr) {
+		DBusMessage *reply = btd_error_failed(device->bonding->msg,
+								gerr->message);
+
+		g_dbus_send_message(device->bonding->conn, reply);
+		DBG("%s", gerr->message);
+		return;
+	}
+
+	device->attrib = g_attrib_new(io);
+	device->attachid = attrib_channel_attach(device->attrib, TRUE);
+	if (device->attachid == 0)
+		error("Attribute server attach failure!");
+}
+
 DBusMessage *device_create_bonding(struct btd_device *device,
 					DBusConnection *conn,
 					DBusMessage *msg,
@@ -2340,6 +2363,30 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	if (device_is_bonded(device))
 		return btd_error_already_exists(msg);
 
+	if (device_is_le(device)) {
+		GError *gerr = NULL;
+		bdaddr_t sba;
+
+		adapter_get_address(adapter, &sba);
+
+		device->att_io = bt_io_connect(BT_IO_L2CAP, bonding_connect_cb,
+					device, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, &sba,
+					BT_IO_OPT_DEST_BDADDR,&device->bdaddr,
+					BT_IO_OPT_CID, ATT_CID,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+
+		if (device->att_io == NULL) {
+			DBusMessage *reply = btd_error_failed(msg,
+								gerr->message);
+
+			error("Bonding bt_io_connect(): %s", gerr->message);
+			g_error_free(gerr);
+			return reply;
+		}
+	}
+
 	err = adapter_create_bonding(adapter, &device->bdaddr,
 					device->type, capability);
 	if (err < 0)
-- 
1.7.9

