Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5d240eb0710090507i71fadfb0n88ac6e8d5dcec0a3@mail.gmail.com>
Date: Tue, 9 Oct 2007 17:37:55 +0530
From: "rohit puri" <rohitpuri.rohit@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] problem in discovering device using dbus APIs
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0503700748=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0503700748==
Content-Type: multipart/alternative;
	boundary="----=_Part_4897_16807576.1191931675315"

------=_Part_4897_16807576.1191931675315
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all,

I have trimmed the program comes with gnome. The program compiles  but
doesnt give any output.There may be some problem.here I am attaching the
code.

#include<stdlib.h>
#include<stdio.h>
#include<dbus-1.0/dbus/dbus.h>
#include <dbus/dbus-glib.h>
#include <string.h>
#include<glib-object.h>
#include "marshal.h"

extern void marshal_VOID__STRING_UINT_INT (GClosure     *closure,
                GValue       *return_value,
                guint         n_param_values,
                const GValue *param_values,
                gpointer      invocation_hint,
                gpointer      marshal_data);



extern void marshal_VOID__STRING_STRING (GClosure     *closure,
                GValue       *return_value,
                guint         n_param_values,
                const GValue *param_values,
                gpointer      invocation_hint,
                gpointer      marshal_data);

static void remote_device_found(DBusGProxy *object, const char *address,
                const unsigned int class, const int rssi, gpointer
user_data)
{
        //DBusGConnection *conn = user_data;

        /* bluetooth_device_store_add_device(BLUETOOTH_DEVICE_STORE(store),
address, class, rssi);*/


        printf("(%s )\n :Remote device address  found",address);
#if 0
        object = dbus_g_proxy_new_for_name(conn, "org.bluez",
                        "/org/bluez/hci0", "org.bluez.Test");

        dbus_g_proxy_call(object, "AuditRemoteDevice", NULL, G_TYPE_STRING,
address, G_TYPE_INVALID);
#endif
}

static void discovery_started(DBusGProxy *object, gpointer user_data)
{
        printf("devices discovered: DiscoveryStarted()\n");
}


static void setup_dbus(DBusGConnection *conn)
{
        /*creating the proxy object*/
        DBusGProxy *object;
        /*creating a message and sending a message to the remote object
blocking call*/
        object = dbus_g_proxy_new_for_name(conn, "org.bluez",
"/org/bluez/hci0", "org.bluez.Adapter");
        /*registering a marshal */
        dbus_g_object_register_marshaller(marshal_VOID__STRING_UINT_INT,
G_TYPE_NONE, G_TYPE_STRING, G_TYPE_UINT, G_TYPE_INT, G_TYPE_INVALID);

        dbus_g_proxy_add_signal(object, "RemoteDeviceFound", G_TYPE_STRING,
G_TYPE_UINT, G_TYPE_INT, G_TYPE_INVALID);

        dbus_g_proxy_connect_signal(object, "RemoteDeviceFound",
G_CALLBACK(remote_device_found), conn, NULL);

        dbus_g_proxy_add_signal(object, "DiscoveryStarted", G_TYPE_INVALID);

        dbus_g_proxy_connect_signal(object, "DiscoveryStarted",
G_CALLBACK(discovery_started), NULL, NULL);
}

int main(int argc, char *argv[])
{
        DBusGConnection *conn;
        GError *error = NULL;
        g_type_init();

        /*getting the system bus connection*/

 conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
        if (error != NULL) {
                g_printerr("Connecting to system bus failed: %s\n",
                                error->message);
                g_error_free(error);
                exit(EXIT_FAILURE);
        }
        setup_dbus(conn);
        DBusGProxy *object;
        object = dbus_g_proxy_new_for_name(conn, "org.bluez",
                        "/org/bluez/hci0", "org.bluez.Adapter");

        dbus_g_proxy_call(object, "DiscoverDevices", &error,
                                G_TYPE_INVALID, G_TYPE_INVALID);

        if (error != NULL) {
                printf ("\n Error ... message is %s",error->message);
        }
        dbus_g_connection_unref(conn);
        return 0;
can some one figure out the problem.


Thanks
Rohit

------=_Part_4897_16807576.1191931675315
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all,<br><br>I have trimmed the program comes with gnome. The program compiles&nbsp; but doesnt give any output.There may be some problem.here I am attaching the code.<br><br>#include&lt;stdlib.h&gt;<br>#include&lt;stdio.h&gt;
<br>#include&lt;dbus-1.0/dbus/dbus.h&gt;<br>#include &lt;dbus/dbus-glib.h&gt;<br>#include &lt;string.h&gt;<br>#include&lt;glib-object.h&gt;<br>#include &quot;marshal.h&quot;<br><br>extern void marshal_VOID__STRING_UINT_INT (GClosure&nbsp;&nbsp;&nbsp;&nbsp; *closure,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GValue&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *return_value,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; guint&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n_param_values,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const GValue *param_values,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpointer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; invocation_hint,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpointer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; marshal_data);
<br><br><br><br>extern void marshal_VOID__STRING_STRING (GClosure&nbsp;&nbsp;&nbsp;&nbsp; *closure,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GValue&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *return_value,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; guint&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n_param_values,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const GValue *param_values,
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpointer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; invocation_hint,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpointer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; marshal_data);<br><br>static void remote_device_found(DBusGProxy *object, const char *address,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const unsigned int class, const int rssi, gpointer user_data)
<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //DBusGConnection *conn = user_data;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bluetooth_device_store_add_device(BLUETOOTH_DEVICE_STORE(store), address, class, rssi);*/<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;(%s )\n :Remote device address&nbsp; found&quot;,address);
<br>#if 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object = dbus_g_proxy_new_for_name(conn, &quot;org.bluez&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;/org/bluez/hci0&quot;, &quot;org.bluez.Test&quot;);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_proxy_call(object, &quot;AuditRemoteDevice&quot;, NULL, G_TYPE_STRING, address, G_TYPE_INVALID);
<br>#endif<br>}<br><br>static void discovery_started(DBusGProxy *object, gpointer user_data)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;devices discovered: DiscoveryStarted()\n&quot;);<br>}<br><br><br>static void setup_dbus(DBusGConnection *conn)
<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*creating the proxy object*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DBusGProxy *object;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*creating a message and sending a message to the remote object blocking call*/<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object = dbus_g_proxy_new_for_name(conn, &quot;
org.bluez&quot;, &quot;/org/bluez/hci0&quot;, &quot;org.bluez.Adapter&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*registering a marshal */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_object_register_marshaller(marshal_VOID__STRING_UINT_INT, G_TYPE_NONE, G_TYPE_STRING, G_TYPE_UINT, G_TYPE_INT, G_TYPE_INVALID);
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_proxy_add_signal(object, &quot;RemoteDeviceFound&quot;, G_TYPE_STRING, G_TYPE_UINT, G_TYPE_INT, G_TYPE_INVALID);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_proxy_connect_signal(object, &quot;RemoteDeviceFound&quot;, G_CALLBACK(remote_device_found), conn, NULL);
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_proxy_add_signal(object, &quot;DiscoveryStarted&quot;, G_TYPE_INVALID);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_proxy_connect_signal(object, &quot;DiscoveryStarted&quot;, G_CALLBACK(discovery_started), NULL, NULL);<br>
}<br><br>int main(int argc, char *argv[])<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DBusGConnection *conn;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GError *error = NULL;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_type_init();<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*getting the system bus connection*/<br><br>&nbsp;conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &amp;error);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error != NULL) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_printerr(&quot;Connecting to system bus failed: %s\n&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error-&gt;message);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_error_free(error);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(EXIT_FAILURE);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_dbus(conn);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DBusGProxy *object;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object = dbus_g_proxy_new_for_name(conn, &quot;org.bluez&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;/org/bluez/hci0&quot;, &quot;org.bluez.Adapter
&quot;);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_proxy_call(object, &quot;DiscoverDevices&quot;, &amp;error,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G_TYPE_INVALID, G_TYPE_INVALID);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error != NULL) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf (&quot;\n Error ... message is %s&quot;,error-&gt;message);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_connection_unref(conn);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>can some one figure out the problem.<br><br><br>Thanks <br>Rohit<br><br><br><br><br>

------=_Part_4897_16807576.1191931675315--


--===============0503700748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0503700748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0503700748==--
