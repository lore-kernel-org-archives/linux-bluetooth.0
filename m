Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5d240eb0710050552h25d923a0hd1de3c0cec71aeb7@mail.gmail.com>
Date: Fri, 5 Oct 2007 18:22:51 +0530
From: "rohit puri" <rohitpuri.rohit@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] DBus error <dbus/dbus-arch-deps.h> is missing
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0073415695=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0073415695==
Content-Type: multipart/alternative;
	boundary="----=_Part_35046_20145638.1191588771797"

------=_Part_35046_20145638.1191588771797
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all

whenever I am compiling my program of
dbus for interprocess communication .i am getting following error .I have
downloaded a latest version of dbus 1.1.2


Here I am writing the program and all the errors I am facing
#include <stdio.h>
#include <stdlib.h>
#include <dbus-1.0/dbus/dbus.h>
int main(int argc, char **argv)
{
    DBusConnection *conn;
    DBusMessage *msg, *reply;
    const char *name;
    conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
    msg = dbus_message_new_method_call("org.bluez", "/org/bluez/hci0",
                                                   "org.bluez.Adapter ",
"GetName");
    reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, NULL);
    dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &name,
DBUS_TYPE_INVALID);
    printf("%s\n", name);
    dbus_message_unref(msg);
    dbus_message_unref(reply);
    dbus_connection_close(conn);
    return 0;
}


errors
In file included from dbus2.c:3:
/usr/include/dbus-1.0/dbus/dbus.h:29:33: error: dbus/dbus- arch-deps.h: No
such file or directory
/usr/include/dbus-1.0/dbus/dbus.h:30:31: error: dbus/dbus-address.h: No such
file or directory
/usr/include/dbus-1.0/dbus/dbus.h:31:27: error: dbus/dbus-bus.h: No such
file or directory
/usr/include/dbus-1.0/dbus/dbus.h:32:34: error: dbus/dbus-connection.h: No
such file or directory
/usr/include/dbus-1.0/dbus/dbus.h:33:30: error: dbus/dbus-errors.h: No such
file or directory
/usr/include/dbus-1.0 /dbus/dbus.h:34:30: error: dbus/dbus-macros.h: No such
file or directory
/usr/include/dbus-1.0/dbus/dbus.h:35:31: error: dbus/dbus-message.h: No such
file or directory
/usr/include/dbus-1.0/dbus/dbus.h:36:28: error: dbus/dbus- misc.h: No such
file or directory
/usr/include/dbus-1.0/dbus/dbus.h:37:36: error: dbus/dbus-pending-call.h: No
such file or directory
/usr/include/dbus-1.0/dbus/dbus.h:38:32: error: dbus/dbus-protocol.h: No
such file or directory
/usr/include/dbus-1.0/dbus/dbus.h:39:30: error: dbus/dbus-server.h: No such
file or directory
/usr/include/dbus-1.0/dbus/dbus.h:40:30: error: dbus/dbus-shared.h: No such
file or directory
/usr/include/dbus-1.0/dbus/dbus.h:41:33: error: dbus/dbus- signature.h: No
such file or directory
/usr/include/dbus-1.0/dbus/dbus.h:42:31: error: dbus/dbus-threads.h: No such
file or directory
/usr/include/dbus-1.0/dbus/dbus.h:43:29: error: dbus/dbus-types.h: No such
file or directory
dbus2.c: In function 'main':
dbus2.c:10: error: 'DBusConnection' undeclared (first use in this function)
dbus2.c:10: error: (Each undeclared identifier is reported only once
dbus2.c:10: error: for each function it appears in.)
dbus2.c:10: error: 'connection' undeclared (first use in this function)
dbus2.c:12: error: 'DBusMessage' undeclared (first use in this function)
dbus2.c:12: error: 'message' undeclared (first use in this function)
dbus2.c:12: error: 'reply' undeclared (first use in this function)
dbus2.c:16: error: 'DBUS_BUS_SYSTEM' undeclared (first use in this function)
dbus2.c:22: error: 'DBUS_TYPE_STRING' undeclared (first use in this
function)
dbus2.c:22: error: 'DBUS_TYPE_INVALID' undeclared (first use in this
function)



can somebody help me out



thanks in advance

------=_Part_35046_20145638.1191588771797
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all <br><br>whenever I am compiling my program of <br>dbus for interprocess communication .i am getting following error .I have downloaded a latest version of dbus 1.1.2<br><br><br>Here I am writing the program and all the errors I am facing
<br>#include &lt;stdio.h&gt;<br>#include &lt;stdlib.h&gt;<br>#include &lt;dbus-1.0/dbus/dbus.h&gt;<br>int main(int argc, char **argv)<br>{<br>&nbsp;&nbsp;&nbsp; DBusConnection *conn;<br>&nbsp;&nbsp;&nbsp; DBusMessage *msg, *reply;<br>&nbsp;&nbsp;&nbsp; const char *name;
<br>&nbsp;&nbsp;&nbsp; conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);<br>&nbsp;&nbsp;&nbsp; msg = dbus_message_new_method_call(&quot;org.bluez&quot;, &quot;/org/bluez/hci0&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div id="mb_0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;
org.bluez.Adapter
&quot;, &quot;GetName&quot;);<br>&nbsp;&nbsp;&nbsp; reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, NULL);<br>&nbsp;&nbsp;&nbsp; dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &amp;name, DBUS_TYPE_INVALID);<br>&nbsp;&nbsp;&nbsp; printf(&quot;%s\n&quot;, name);
<br>&nbsp;&nbsp;&nbsp; dbus_message_unref(msg);<br>&nbsp;&nbsp;&nbsp; dbus_message_unref(reply);<br>&nbsp;&nbsp;&nbsp; dbus_connection_close(conn);<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br><br>errors<br>In file included from dbus2.c:3:<br>/usr/include/dbus-1.0/dbus/dbus.h:29:33: error: dbus/dbus-
arch-deps.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:30:31: error: dbus/dbus-address.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:31:27: error: dbus/dbus-bus.h: No such file or directory
<br>/usr/include/dbus-1.0/dbus/dbus.h:32:34: error: dbus/dbus-connection.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:33:30: error: dbus/dbus-errors.h: No such file or directory<br>/usr/include/dbus-
1.0
/dbus/dbus.h:34:30: error: dbus/dbus-macros.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:35:31: error: dbus/dbus-message.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:36:28: error: dbus/dbus-
misc.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:37:36: error: dbus/dbus-pending-call.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:38:32: error: dbus/dbus-protocol.h: No such file or directory
<br>/usr/include/dbus-1.0/dbus/dbus.h:39:30: error: dbus/dbus-server.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:40:30: error: dbus/dbus-shared.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:41:33: error: dbus/dbus-
signature.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:42:31: error: dbus/dbus-threads.h: No such file or directory<br>/usr/include/dbus-1.0/dbus/dbus.h:43:29: error: dbus/dbus-types.h: No such file or directory
<br>dbus2.c: In function &#39;main&#39;:<br>dbus2.c:10: error: &#39;DBusConnection&#39; undeclared (first use in this function)<br>dbus2.c:10: error: (Each undeclared identifier is reported only once<br>dbus2.c:10: error: for each function it appears in.)
<br>dbus2.c:10: error: &#39;connection&#39; undeclared (first use in this function)<br>dbus2.c:12: error: &#39;DBusMessage&#39; undeclared (first use in this function)<br>dbus2.c:12: error: &#39;message&#39; undeclared (first use in this function)
<br>dbus2.c:12: error: &#39;reply&#39; undeclared (first use in this function)<br>dbus2.c:16: error: &#39;DBUS_BUS_SYSTEM&#39; undeclared (first use in this function)<br>dbus2.c:22: error: &#39;DBUS_TYPE_STRING&#39; undeclared (first use in this function)
<br>dbus2.c:22: error: &#39;DBUS_TYPE_INVALID&#39; undeclared (first use in this function)<br><br><br><br>can somebody help me out<br><br><br><br>thanks in advance</div>

------=_Part_35046_20145638.1191588771797--


--===============0073415695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0073415695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0073415695==--
