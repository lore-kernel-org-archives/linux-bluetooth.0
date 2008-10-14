Return-Path: <cyrus@holtmann.org>
Message-ID: <223378410810132136w3374d1c8mec7c3f181694c35e@mail.gmail.com>
Date: Tue, 14 Oct 2008 10:06:15 +0530
From: "rakesh agarwal" <zen.raj@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] audio service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2121744727390147339=="
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2121744727390147339==
Content-Type: multipart/alternative;
	boundary="----=_Part_146493_13400732.1223958975514"

------=_Part_146493_13400732.1223958975514
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
I was trying to write simple program for a2dp in C language. This is the
program that I m trying to run......



#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <glib.h>
#include <dbus/dbus-glib.h>
#include <dbus/dbus-glib-lowlevel.h>
#include <dbus/dbus-glib-bindings.h>

#include <bluetooth/bluetooth.h>

#include "marshal.h"
#include "marshal.c"


GMainLoop *loop;

static void
session_created ()
{
    g_message ("a2dp device created");
}

static void
session_removed (DBusGProxy *proxy, const char *session_object, gpointer
user_data)
{
    g_message ("playing");

}


int
main ()
{


    char* address = "00:19:63:EF:83:17";

    DBusGConnection *dbus_connection;
    DBusGProxy *dbus_proxy;
    GError *error = NULL;
    int ret;
    char *id;
    gchar *object_path = NULL;

    g_type_init ();
    id = (char*) g_malloc0(50);
    dbus_connection = dbus_g_bus_get (DBUS_BUS_SYSTEM, &error);
    if (error) {
        g_warning ("%s", error->message);
        g_clear_error (&error);
    }
    error = NULL;

    dbus_proxy = dbus_g_proxy_new_for_name (dbus_connection, "org.bluez",
"/org/bluez", "org.bluez.Manager");
    dbus_g_object_register_marshaller (marshal_STRING__STRING,
G_TYPE_NONE,
                                                    G_TYPE_STRING,
                                                    G_TYPE_STRING);

    dbus_g_proxy_call (dbus_proxy,
"ActivateService",&error,G_TYPE_STRING,"audio",G_TYPE_INVALID,G_TYPE_STRING,id,G_TYPE_INVALID);
    if(error != NULL){
        g_print("ERROR : %s",error->message);
        //exit(0);
    }
    else
        g_print("id = %s",id);

    error = NULL;

    dbus_proxy = dbus_g_proxy_new_for_name (dbus_connection,id,
                                 "/org/bluez/audio",
                                 "org.bluez.audio.Manager");

    ret = dbus_g_proxy_call (dbus_proxy, "CreateDevice", &error,
                            G_TYPE_STRING, address,
                            G_TYPE_INVALID,
                            DBUS_TYPE_G_OBJECT_PATH, &object_path,
                            G_TYPE_INVALID);
    if (!ret) {
        g_warning ("Error1: %s", error->message);
        g_clear_error (&error);
        return FALSE;
    } else
        g_message ("Object path: %s", object_path);

    dbus_proxy = dbus_g_proxy_new_for_name (dbus_connection,
"org.bluez",
                                 object_path,
                                 "org.bluez.audio.Sink");

    dbus_g_proxy_add_signal (dbus_proxy, "Connected", G_TYPE_INVALID,
G_TYPE_INVALID);
    dbus_g_proxy_connect_signal (dbus_proxy, "Connected", G_CALLBACK
(session_created),
                   NULL, NULL);

    dbus_g_proxy_add_signal (dbus_proxy, "Playing", G_TYPE_INVALID,
G_TYPE_INVALID);
    dbus_g_proxy_connect_signal (dbus_proxy, "Playing", G_CALLBACK
(session_removed),
                       NULL, NULL);


    dbus_g_proxy_call (dbus_proxy, "Connect", &error,
                            G_TYPE_INVALID,
                            G_TYPE_INVALID);
    dbus_g_proxy_call (dbus_proxy, "Play", &error,
                            G_TYPE_INVALID,
                            G_TYPE_INVALID);

    loop = g_main_loop_new (NULL, FALSE);
    g_main_loop_run (loop);


    return 0;
}


But getting these error message while running........

[Invalid UTF-8] id = \xb0\xe1\x04\x08
** (process:6157): WARNING **: Error1: Method "CreateDevice" with signature
"s" on interface "org.bluez.audio.Manager" doesn't exist


PLz help me out......

Thanks in advance.....

Rakesh

------=_Part_146493_13400732.1223958975514
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi all,<br>I was trying to write simple program for a2dp in C language. This is the program that I m trying to run......<br><br><br><br>#include &lt;string.h&gt;<br>#include &lt;ctype.h&gt;<br>#include &lt;unistd.h&gt;<br>
#include &lt;glib.h&gt;<br>#include &lt;dbus/dbus-glib.h&gt;<br>#include &lt;dbus/dbus-glib-lowlevel.h&gt;<br>#include &lt;dbus/dbus-glib-bindings.h&gt;<br><br>#include &lt;bluetooth/bluetooth.h&gt;<br><br>#include &quot;marshal.h&quot;<br>
#include &quot;marshal.c&quot;<br><br><br>GMainLoop *loop;<br><br>static void<br>session_created ()<br>{<br>&nbsp;&nbsp;&nbsp; g_message (&quot;a2dp device created&quot;);<br>}<br><br>static void<br>session_removed (DBusGProxy *proxy, const char *session_object, gpointer user_data)<br>
{<br>&nbsp;&nbsp;&nbsp; g_message (&quot;playing&quot;);<br>&nbsp;&nbsp;&nbsp; <br>}<br><br><br>int<br>main ()<br>{<br><br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; char* address = &quot;00:19:63:EF:83:17&quot;;<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; DBusGConnection *dbus_connection;<br>&nbsp;&nbsp;&nbsp; DBusGProxy *dbus_proxy;<br>
&nbsp;&nbsp;&nbsp; GError *error = NULL;<br>&nbsp;&nbsp;&nbsp; int ret;<br>&nbsp;&nbsp;&nbsp; char *id;<br>&nbsp;&nbsp;&nbsp; gchar *object_path = NULL;<br><br>&nbsp;&nbsp;&nbsp; g_type_init ();<br>&nbsp;&nbsp;&nbsp; id = (char*) g_malloc0(50);<br>&nbsp;&nbsp;&nbsp; dbus_connection = dbus_g_bus_get (DBUS_BUS_SYSTEM, &amp;error);<br>
&nbsp;&nbsp;&nbsp; if (error) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; g_warning (&quot;%s&quot;, error-&gt;message);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; g_clear_error (&amp;error);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; error = NULL;<br><br>&nbsp;&nbsp;&nbsp; dbus_proxy = dbus_g_proxy_new_for_name (dbus_connection, &quot;org.bluez&quot;, &quot;/org/bluez&quot;, &quot;org.bluez.Manager&quot;);<br>
&nbsp;&nbsp;&nbsp; dbus_g_object_register_marshaller (marshal_STRING__STRING,&nbsp;&nbsp;&nbsp; G_TYPE_NONE,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; G_TYPE_STRING,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; G_TYPE_STRING);<br>
<br>&nbsp;&nbsp;&nbsp; dbus_g_proxy_call (dbus_proxy, &quot;ActivateService&quot;,&amp;error,G_TYPE_STRING,&quot;audio&quot;,G_TYPE_INVALID,G_TYPE_STRING,id,G_TYPE_INVALID);<br>&nbsp;&nbsp;&nbsp; if(error != NULL){<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; g_print(&quot;ERROR : %s&quot;,error-&gt;message);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //exit(0);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; else&nbsp; &nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; g_print(&quot;id = %s&quot;,id);<br><br>&nbsp;&nbsp;&nbsp; error = NULL;<br><br>&nbsp;&nbsp;&nbsp; dbus_proxy = dbus_g_proxy_new_for_name (dbus_connection,id,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&quot;/org/bluez/audio&quot;, <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&quot;org.bluez.audio.Manager&quot;);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; ret = dbus_g_proxy_call (dbus_proxy, &quot;CreateDevice&quot;, &amp;error, <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; G_TYPE_STRING, address,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; G_TYPE_INVALID,<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; DBUS_TYPE_G_OBJECT_PATH, &amp;object_path,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; G_TYPE_INVALID);<br>&nbsp;&nbsp;&nbsp; if (!ret) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; g_warning (&quot;Error1: %s&quot;, error-&gt;message);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; g_clear_error (&amp;error);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return FALSE;<br>&nbsp;&nbsp;&nbsp; } else &nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; g_message (&quot;Object path: %s&quot;, object_path);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; dbus_proxy = dbus_g_proxy_new_for_name (dbus_connection, &quot;org.bluez&quot;,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; object_path, <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&quot;org.bluez.audio.Sink&quot;);<br><br>&nbsp;&nbsp;&nbsp; dbus_g_proxy_add_signal (dbus_proxy, &quot;Connected&quot;, G_TYPE_INVALID, G_TYPE_INVALID);<br>&nbsp;&nbsp;&nbsp; dbus_g_proxy_connect_signal (dbus_proxy, &quot;Connected&quot;, G_CALLBACK (session_created),<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL);<br><br>&nbsp;&nbsp;&nbsp; dbus_g_proxy_add_signal (dbus_proxy, &quot;Playing&quot;, G_TYPE_INVALID, G_TYPE_INVALID);<br>&nbsp;&nbsp;&nbsp; dbus_g_proxy_connect_signal (dbus_proxy, &quot;Playing&quot;, G_CALLBACK (session_removed),<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; NULL, NULL);<br>&nbsp;&nbsp;&nbsp; <br><br>&nbsp;&nbsp;&nbsp; dbus_g_proxy_call (dbus_proxy, &quot;Connect&quot;, &amp;error, <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; G_TYPE_INVALID,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; G_TYPE_INVALID);<br>&nbsp;&nbsp;&nbsp; dbus_g_proxy_call (dbus_proxy, &quot;Play&quot;, &amp;error, <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; G_TYPE_INVALID,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; G_TYPE_INVALID);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; loop = g_main_loop_new (NULL, FALSE);<br>&nbsp;&nbsp;&nbsp; g_main_loop_run (loop);<br><br><br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br><br>But getting these error message while running........<br>
<br>[Invalid UTF-8] id = \xb0\xe1\x04\x08<br>** (process:6157): WARNING **: Error1: Method &quot;CreateDevice&quot; with signature &quot;s&quot; on interface &quot;org.bluez.audio.Manager&quot; doesn&#39;t exist<br>&nbsp;<br><br>
PLz help me out......<br><br>Thanks in advance.....<br><br>Rakesh<br><br></div>

------=_Part_146493_13400732.1223958975514--


--===============2121744727390147339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============2121744727390147339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2121744727390147339==--
