Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Ajay Parashar <ajay.parasha@gmail.com>
Date: Wed, 3 Aug 2016 15:44:53 +0530
Message-ID: <CAMj0Yyv0LEjLSspsMP7MosNGbah376ncaY0Jmw6RR=41gVB4EA@mail.gmail.com>
Subject: Connect method of org.bluez.Network1 interface throws error "Connect
 with signature "s" doesn't exist"
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using bluez 5.35 and developing an application using Glib DBUS binding.

As per network-api.txt documentation, my code calls connect API with
String type parameter but while execution it prompts below error.
Can you please let me know why is it giving this error and how can i
resolve this.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Unable to connect with network :
GDBus.Error:org.freedesktop.DBus.Error.UnknownObject: Method "Connect"
with signature "s" on interface "org.bluez.Network1" doesn't exist
////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* For reference please find my code as below*/

int connect_network(char *interface)
{
  int       ret       = 0;
  GError   *error     = NULL;
  GVariant *reply     = NULL;

  GVariant **t = NULL;
  t    = g_new(GVariant *, 1);
  t[0] = g_variant_new_string ("nap");

  GVariant *tuple_variant = g_variant_new_tuple(t, 1);

  /* connect with network */
  reply = g_dbus_connection_call_sync(dbus_conn,
    BLUEZ_BUS_NAME,
    "/org/bluez/hci0",
    "org.bluez.Network1",
    "Connect",
    tuple_variant,
    G_VARIANT_TYPE_STRING,
    G_DBUS_CALL_FLAGS_NONE,
    -1,
    NULL,
    &error);

if (error) {
    printf("Unable to connect with network : %s\n", error->message);
g_free(t);
    return -3;
  }

   g_variant_get(reply, "(s)", &interface);
   printf("interface from connect is = %s\n", interface);
  g_free(t);

  return ret;
}
