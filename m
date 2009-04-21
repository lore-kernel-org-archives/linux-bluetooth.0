Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 21 Apr 2009 09:27:01 +0800
Message-ID: <6edf6b480904201827n5049a614se097643adeba9932@mail.gmail.com>
Subject: dbus of c program for adapter get/set properties
From: yesir yao <yesiryao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi, all:

I need to use dbus api to control my bluetooth adapter in my C program.
After I had read doc/adapter-api.txt and writed the codes, It can't work.

my question is:
what is the different between:
dbus_connection_send_with_reply_and_block
and
dbus_connection_send_with_reply ?

in src/adapter.c, I found two methods defined:
static GDBusMethodTable adapter_methods[] = {
{ "GetProperties", "",	"a{sv}",  get_properties  },
{ "SetProperty", "sv", "",   set_property,
	G_DBUS_METHOD_FLAG_ASYNC },

For Methods dict GetProperties(), we should use
dbus_connection_send_with_reply_and_block ?
For Methods void SetProperty(..), we should use
dbus_connection_send_with_reply ?
is it right or not? (because of the flag: G_DBUS_METHOD_FLAG_ASYNC ?

===================================
static LRESULT OnAdapterSetDiscov()
{
	DBusConnection *conn;
	DBusMessage *dmsg, *reply;
	DBusError err;
	int bOn = TRUE;
	const char *PropName = "Discoverable";

	conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
	if (!conn) {
		print("Can't get on session bus");
		exit(1);
	}

	dmsg = dbus_message_new_method_call("org.bluez", "/org/bluez/hci0",
					"org.bluez.Adapter", "SetProperty");
	if (!dmsg) {
		print("Can't allocate new method call");
		return -1;
	}

	dbus_message_append_args(dmsg, DBUS_TYPE_STRING, &PropName,
					DBUS_TYPE_BOOLEAN, &bOn,
					DBUS_TYPE_INVALID);
#if 1
// can't SetProperty of Discoverable
	if (dbus_connection_send_with_reply(conn, dmsg, NULL, -1) == FALSE) {
		print("D-Bus send failed");
		return (LRESULT)0;
	}

#else
// print error: Method "SetProperty" with signature "sb" on interface
" org.bluez.Adapter" doesn't exist

	dbus_error_init(&err);
	reply = dbus_connection_send_with_reply_and_block(conn, dmsg, -1, &err);	
	if (!reply) {
		if (dbus_error_is_set(&err)) {
			print("%s", err.message);
			dbus_error_free(&err);
		}
		return (LRESULT)0;
	}
#endif

	dbus_message_unref(dmsg);
	dbus_message_unref(reply);
	dbus_connection_flush(conn);

	return (LRESULT)0;
}
