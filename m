Return-Path: <cyrus@holtmann.org>
Message-ID: <49f5aca0804070731j7d3a7349ta29461fad6808231@mail.gmail.com>
Date: Mon, 7 Apr 2008 16:31:14 +0200
From: "Pedro Vivancos" <pedro.vivancos@vocali.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] C program for capturing AnswerRequested signal
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1804525839=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1804525839==
Content-Type: multipart/alternative;
	boundary="----=_Part_1615_3372406.1207578674928"

------=_Part_1615_3372406.1207578674928
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear friends,

I wrote a C program to capture the "AnswerRequested" signal from a bluetooth
headset but it doesn't work. It is based on the DeviceDiscover Howto of the
wiki audio section but it doesn't do anything.

Can you help me to find the error?

Thanks in advance

/* Build with: */
/* glib-genmarshal --prefix=marshal marshal.list --header > marshal.h */
/* glib-genmarshal --prefix=marshal marshal.list --body > marshal.c */
/* gcc `pkg-config --libs --cflags glib-2.0 dbus-1 dbus-glib-1` bluetooth.c
marshal.c -o bluetooth */

#include <stdlib.h>
#include <dbus/dbus.h>
#include <dbus/dbus-glib.h>
#include <glib-object.h>

#include "marshal.h"

static GMainLoop *loop = NULL;

static void answer_requested(DBusGProxy *object, gpointer user_data)
{
        g_print("Signal: AnswerRequested()\n");
}


static void run_mainloop (void)
{
        GMainContext *ctx;

        ctx = g_main_loop_get_context (loop);

        while (g_main_context_pending (ctx))
                g_main_context_iteration (ctx, FALSE);
}

int main(int argc, char* argv[])
{
        GError *error = NULL;
        DBusGConnection * bus = NULL;
        DBusGProxy * obj = NULL;

        g_type_init();
        g_log_set_always_fatal (G_LOG_LEVEL_WARNING);
        loop = g_main_loop_new (NULL, FALSE);

        bus = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
        if (error != NULL)
        {
                g_printerr("Connecting to system bus failed: %s\n",
error->message);
                g_error_free(error);
                exit(EXIT_FAILURE);
        }

        // o probar con /org/bluez/audio
        obj = dbus_g_proxy_new_for_name(bus, "org.bluez",
"00:16:94:03:60:1B", "org.bluez.audio.Headset");

        dbus_g_proxy_add_signal(obj, "AnswerRequested", G_TYPE_INVALID);
        dbus_g_proxy_connect_signal(obj, "AnswerRequested",
G_CALLBACK(answer_requested), bus, NULL);

        run_mainloop ();
        dbus_g_connection_flush (bus);
        g_main_loop_run (loop);
        dbus_g_connection_unref(bus);

        return 0;
}

------=_Part_1615_3372406.1207578674928
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear friends,<br><br>I wrote a C program to capture the &quot;AnswerRequested&quot; signal from a bluetooth headset but it doesn&#39;t work. It is based on the DeviceDiscover Howto of the wiki audio section but it doesn&#39;t do anything.<br>
<br>Can you help me to find the error?<br><br>Thanks in advance<br><br>/* Build with: */<br>/* glib-genmarshal --prefix=marshal marshal.list --header &gt; marshal.h */<br>/* glib-genmarshal --prefix=marshal marshal.list --body &gt; marshal.c */<br>
/* gcc `pkg-config --libs --cflags glib-2.0 dbus-1 dbus-glib-1` bluetooth.c marshal.c -o bluetooth */<br><br>#include &lt;stdlib.h&gt;<br>#include &lt;dbus/dbus.h&gt;<br>#include &lt;dbus/dbus-glib.h&gt;<br>#include &lt;glib-object.h&gt;<br>
<br>#include &quot;marshal.h&quot;<br><br>static GMainLoop *loop = NULL;<br><br>static void answer_requested(DBusGProxy *object, gpointer user_data)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_print(&quot;Signal: AnswerRequested()\n&quot;);<br>}<br>
<br><br>static void run_mainloop (void)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GMainContext *ctx;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx = g_main_loop_get_context (loop);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (g_main_context_pending (ctx))<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_main_context_iteration (ctx, FALSE);<br>
}<br><br>int main(int argc, char* argv[])<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GError *error = NULL;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DBusGConnection * bus = NULL;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DBusGProxy * obj = NULL;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_type_init();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_log_set_always_fatal (G_LOG_LEVEL_WARNING);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loop = g_main_loop_new (NULL, FALSE);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bus = dbus_g_bus_get(DBUS_BUS_SYSTEM, &amp;error);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error != NULL)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_printerr(&quot;Connecting to system bus failed: %s\n&quot;, error-&gt;message);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_error_free(error);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(EXIT_FAILURE);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // o probar con /org/bluez/audio<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj = dbus_g_proxy_new_for_name(bus, &quot;org.bluez&quot;, &quot;00:16:94:03:60:1B&quot;, &quot;org.bluez.audio.Headset&quot;);<br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_proxy_add_signal(obj, &quot;AnswerRequested&quot;, G_TYPE_INVALID);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_proxy_connect_signal(obj, &quot;AnswerRequested&quot;, G_CALLBACK(answer_requested), bus, NULL);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; run_mainloop ();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_connection_flush (bus);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_main_loop_run (loop);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dbus_g_connection_unref(bus);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br>

------=_Part_1615_3372406.1207578674928--


--===============1804525839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1804525839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1804525839==--
