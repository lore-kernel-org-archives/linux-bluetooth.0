Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Get IEEE1284 for a single printer
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100608092621.GA8254@jh-x301>
References: <1275849744.7994.38.camel@localhost.localdomain>
	 <20100608070935.GA22068@jh-x301>
	 <1275988881.2458.12112.camel@localhost.localdomain>
	 <20100608092621.GA8254@jh-x301>
Content-Type: multipart/mixed; boundary="=-YAl0Vwaqdkqr+UKBiaJ2"
Date: Wed, 01 Sep 2010 15:35:41 +0100
Message-ID: <1283351741.2361.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-YAl0Vwaqdkqr+UKBiaJ2
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Tue, 2010-06-08 at 17:26 +0800, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Tue, Jun 08, 2010, Bastien Nocera wrote:
> > > I have nothing against pushing the patch upstream as long as its coding
> > > style issues are fixed:
> > <snip>
> > > Mixed tabs and spaces.
> > 
> > You do realise that all those are cut'n'paste from another function in
> > the same source file?
> 
> Nope, didn't realize that. So the whole file needs coding style cleanups
> then.

I've only fixed the style problems in the patch itself. I'm happy to do
the rest of the file, if you have a "indent" magic incantation for it.

> > > > +			fprintf(stderr, "Invalid Bluetooth address '%s'\n", argv[2]);
> > > 
> > > Too long line.
> > 
> > Right, I'll fix that.

Done.

Updated patch attached.

--=-YAl0Vwaqdkqr+UKBiaJ2
Content-Disposition: attachment; filename="0001-cups-Add-ability-to-print-IEEE1284-device-ID.patch"
Content-Type: text/x-patch; name="0001-cups-Add-ability-to-print-IEEE1284-device-ID.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 35c984cfbe0a17bb3dd7231450f72854b3ffb7d0 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 6 Jun 2010 15:48:26 +0100
Subject: [PATCH] (cups) Add ability to print IEEE1284 device ID

Add ability to print IEEE1284 device ID for Bluetooth
printers to allow auto-configuration once paired.
---
 cups/main.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/cups/main.c b/cups/main.c
index 9659a11..b420643 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -605,6 +605,79 @@ static gboolean list_printers(void)
 	return TRUE;
 }
 
+static gboolean print_ieee1284(const char *bdaddr)
+{
+	DBusMessage *message, *reply, *adapter_reply;
+	DBusMessageIter iter;
+	char *object_path = NULL;
+	char *adapter;
+	char *id;
+
+	adapter_reply = NULL;
+
+	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	if (conn == NULL)
+		return FALSE;
+
+	message = dbus_message_new_method_call("org.bluez", "/",
+			"org.bluez.Manager",
+			"DefaultAdapter");
+
+	adapter_reply = dbus_connection_send_with_reply_and_block(conn,
+			message, -1, NULL);
+
+	dbus_message_unref(message);
+
+	if (dbus_message_get_args(adapter_reply, NULL,
+			DBUS_TYPE_OBJECT_PATH, &adapter,
+			DBUS_TYPE_INVALID) == FALSE)
+		return FALSE;
+
+	message = dbus_message_new_method_call("org.bluez", adapter,
+			"org.bluez.Adapter",
+			"FindDevice");
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+
+	if (adapter_reply != NULL)
+		dbus_message_unref(adapter_reply);
+
+	reply = dbus_connection_send_with_reply_and_block(conn,
+			message, -1, NULL);
+
+	dbus_message_unref(message);
+
+	if (!reply) {
+		message = dbus_message_new_method_call("org.bluez", adapter,
+				"org.bluez.Adapter",
+				"CreateDevice");
+		dbus_message_iter_init_append(message, &iter);
+		dbus_message_iter_append_basic(&iter,
+				DBUS_TYPE_STRING, &bdaddr);
+
+		reply = dbus_connection_send_with_reply_and_block(conn,
+				message, -1, NULL);
+
+		dbus_message_unref(message);
+
+		if (!reply)
+			return FALSE;
+	}
+	if (dbus_message_get_args(reply, NULL,
+			DBUS_TYPE_OBJECT_PATH, &object_path,
+			DBUS_TYPE_INVALID) == FALSE) {
+		return FALSE;
+	}
+
+	id = device_get_ieee1284_id(adapter, object_path);
+	if (id == NULL)
+		return FALSE;
+	printf("%s", id);
+	g_free(id);
+
+	return TRUE;
+}
+
 /*
  *  Usage: printer-uri job-id user title copies options [file]
  *
@@ -642,10 +715,20 @@ int main(int argc, char *argv[])
 			return CUPS_BACKEND_OK;
 		else
 			return CUPS_BACKEND_FAILED;
+	} else if (argc == 3 && strcmp(argv[1], "--get-deviceid") == 0) {
+		if (bachk(argv[2]) < 0) {
+			fprintf(stderr, "Invalid Bluetooth address '%s'\n",
+					argv[2]);
+			return CUPS_BACKEND_FAILED;
+		}
+		if (print_ieee1284(argv[2]) == FALSE)
+			return CUPS_BACKEND_FAILED;
+		return CUPS_BACKEND_OK;
 	}
 
 	if (argc < 6 || argc > 7) {
 		fprintf(stderr, "Usage: bluetooth job-id user title copies options [file]\n");
+		fprintf(stderr, "       bluetooth --get-deviceid [bdaddr]\n");
 		return CUPS_BACKEND_FAILED;
 	}
 
-- 
1.7.0.1


--=-YAl0Vwaqdkqr+UKBiaJ2--

