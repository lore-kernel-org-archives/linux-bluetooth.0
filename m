Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50703151747p68921f33n95a9b82247e515e1@mail.gmail.com>
Date: Thu, 15 Mar 2007 21:47:45 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] error compiling code that uses dbus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1077112011=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1077112011==
Content-Type: multipart/alternative;
	boundary="----=_Part_84518_6763240.1174006065121"

------=_Part_84518_6763240.1174006065121
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,

i am trying to compile a simple program, from some presentation of Marcell,
but it seems that the dbus headers are someway broken.

The program is:

#include <stdio.h>
#include <stdlib.h>
#include <dbus/dbus.h>

int main( int argc, char **argv ) {
    return 0;
}


Yes, there is no body in the program, just the #include. When I compile this
code I get:

/usr/include/dbus/dbus.h:33:33: error: dbus/dbus-arch-deps.h: No such file
or directory
/usr/include/dbus/dbus-types.h:33: error: 'dbus_uint32_t' does not name a
type
/usr/include/dbus/dbus-types.h:35: error: 'dbus_uint32_t' does not name a
type
/usr/include/dbus/dbus-errors.h:66: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-errors.h:68: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-address.h:35: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:49: error: 'dbus_uint32_t' does not name a
type
/usr/include/dbus/dbus-message.h:85: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:88: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:90: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:93: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:95: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:98: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:100: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:103: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:106: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:111: error: 'dbus_bool_t' has not been
declared
/usr/include/dbus/dbus-message.h:112: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:113: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:116: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:119: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:121: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:123: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:125: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:127: error: 'dbus_uint32_t' does not name a
type
/usr/include/dbus/dbus-message.h:128: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:130: error: 'dbus_uint32_t' does not name a
type
/usr/include/dbus/dbus-message.h:133: error: 'dbus_bool_t' has not been
declared
/usr/include/dbus/dbus-message.h:134: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:136: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:139: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:142: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:145: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:149: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:155: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:157: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:158: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:174: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:177: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:181: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:185: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:189: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:193: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:194: error: variable or field
'dbus_message_free_data_slot' declared void
/usr/include/dbus/dbus-message.h:194: error: 'dbus_int32_t' was not declared
in this scope
/usr/include/dbus/dbus-message.h:194: error: 'slot_p' was not declared in
this scope
/usr/include/dbus/dbus-message.h:195: error: 'dbus_bool_t' does not name a
type
/usr/include/dbus/dbus-message.h:200: error: 'dbus_int32_t' has not been
declared
/usr/include/dbus/dbus-connection.h:62: error: typedef 'dbus_bool_t' is
initialized (use __typeof__ instead)
/usr/include/dbus/dbus-connection.h:62: error: 'DBusAddWatchFunction' was
not declared in this scope
/usr/include/dbus/dbus-connection.h:62: error: expected ',' or ';' before
'(' token
/usr/include/dbus/dbus-connection.h:118: error: 'dbus_uint32_t' has not been
declared
/usr/include/dbus/dbus-connection.h:128: error: 'DBusAddWatchFunction' has
not been declared
/usr/include/dbus/dbus-connection.h:187: error: 'dbus_int32_t' was not
declared in this scope
/usr/include/dbus/dbus-connection.h:187: error: 'slot_p' was not declared in
this scope
/usr/include/dbus/dbus-connection.h:188: error: variable or field
'dbus_connection_free_data_slot' declared void
/usr/include/dbus/dbus-connection.h:188: error: 'dbus_int32_t' was not
declared in this scope
/usr/include/dbus/dbus-connection.h:188: error: 'slot_p' was not declared in
this scope
/usr/include/dbus/dbus-connection.h:190: error: 'dbus_int32_t' has not been
declared
/usr/include/dbus/dbus-connection.h:194: error: 'dbus_int32_t' has not been
declared
/usr/include/dbus/dbus-connection.h:212: error: 'dbus_uint32_t' has not been
declared
/usr/include/dbus/dbus-bus.h:60: error: 'dbus_uint32_t' has not been
declared
/usr/include/dbus/dbus-bus.h:61: error: 'dbus_uint32_t' has not been
declared
/usr/include/dbus/dbus-pending-call.h:47: error: 'dbus_int32_t' was not
declared in this scope
/usr/include/dbus/dbus-pending-call.h:47: error: 'slot_p' was not declared
in this scope
/usr/include/dbus/dbus-pending-call.h:48: error: variable or field
'dbus_pending_call_free_data_slot' declared void
/usr/include/dbus/dbus-pending-call.h:48: error: 'dbus_int32_t' was not
declared in this scope
/usr/include/dbus/dbus-pending-call.h:48: error: 'slot_p' was not declared
in this scope
/usr/include/dbus/dbus-pending-call.h:50: error: 'dbus_int32_t' has not been
declared
/usr/include/dbus/dbus-pending-call.h:54: error: 'dbus_int32_t' has not been
declared
/usr/include/dbus/dbus-server.h:55: error: 'DBusAddWatchFunction' has not
been declared
/usr/include/dbus/dbus-server.h:69: error: 'dbus_int32_t' was not declared
in this scope
/usr/include/dbus/dbus-server.h:69: error: 'slot_p' was not declared in this
scope
/usr/include/dbus/dbus-server.h:70: error: variable or field
'dbus_server_free_data_slot' declared void
/usr/include/dbus/dbus-server.h:70: error: 'dbus_int32_t' was not declared
in this scope
/usr/include/dbus/dbus-server.h:70: error: 'slot_p' was not declared in this
scope

My "uname -a" returns:

loreno@teckiller:Testes$ uname -a
Linux teckiller 2.6.15-28-386 #1 PREEMPT Thu Feb 1 15:51:56 UTC 2007 i686
GNU/Linux
loreno@teckiller:Testes$

My installed dbus-related pakages are:

loreno@teckiller:Testes$ dpkg --list | grep dbus
ii  dbus                                   0.60-6ubuntu8.1
simple interprocess messaging system
ii  dbus-1-utils                           0.60-6ubuntu8.1
simple interprocess messaging system (utilit
ii  libdbus-1-2                            0.60-6ubuntu8.1
simple interprocess messaging system
ii  libdbus-1-dev                          0.60-6ubuntu8.1
simple interprocess messaging system (develo
ii  libdbus-glib-1-2                       0.60-6ubuntu8.1
simple interprocess messaging system (GLib-b
ii  libdbus-glib-1-dev                     0.60-6ubuntu8.1
simple interprocess messaging system (GLib i
ii  python2.4-dbus                         0.60-6ubuntu8.1
simple interprocess messaging system (Python
loreno@teckiller:Testes$


Does anybody can give me some direction over what I am doing wrong here??

Thanks for any help!

Loreno

------=_Part_84518_6763240.1174006065121
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,<br><br>i am trying to compile a simple program, from some presentation of Marcell, but it seems that the dbus headers are someway broken.<br><br>The program is:<br><br>#include &lt;stdio.h&gt;<br>#include &lt;stdlib.h
&gt;<br>#include &lt;dbus/dbus.h&gt;<br><br>int main( int argc, char **argv ) {<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br><br>Yes, there is no body in the program, just the #include. When I compile this code I get:<br><br>/usr/include/dbus/dbus.h:33:33: error: dbus/dbus-
arch-deps.h: No such file or directory<br>/usr/include/dbus/dbus-types.h:33: error: 'dbus_uint32_t' does not name a type<br>/usr/include/dbus/dbus-types.h:35: error: 'dbus_uint32_t' does not name a type<br>/usr/include/dbus/dbus-
errors.h:66: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-errors.h:68: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-address.h:35: error: 'dbus_bool_t' does not name a type<br>
/usr/include/dbus/dbus-message.h:49: error: 'dbus_uint32_t' does not name a type<br>/usr/include/dbus/dbus-message.h:85: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:88: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:90: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:93: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:95: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:98: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:100: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:103: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:106: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:111: error: 'dbus_bool_t' has not been declared<br>/usr/include/dbus/dbus-message.h:112: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:113: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:116: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:119: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:121: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:123: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:125: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:127: error: 'dbus_uint32_t' does not name a type<br>/usr/include/dbus/dbus-message.h:128: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:130: error: 'dbus_uint32_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:133: error: 'dbus_bool_t' has not been declared<br>/usr/include/dbus/dbus-message.h:134: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:136: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:139: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:142: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:145: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:149: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:155: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:157: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:158: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:174: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:177: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:181: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:185: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:189: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:193: error: 'dbus_bool_t' does not name a type<br>/usr/include/dbus/dbus-message.h:194: error: variable or field 'dbus_message_free_data_slot' declared void<br>/usr/include/dbus/dbus-message.h
:194: error: 'dbus_int32_t' was not declared in this scope<br>/usr/include/dbus/dbus-message.h:194: error: 'slot_p' was not declared in this scope<br>/usr/include/dbus/dbus-message.h:195: error: 'dbus_bool_t' does not name a type
<br>/usr/include/dbus/dbus-message.h:200: error: 'dbus_int32_t' has not been declared<br>/usr/include/dbus/dbus-connection.h:62: error: typedef 'dbus_bool_t' is initialized (use __typeof__ instead)<br>/usr/include/dbus/dbus-
connection.h:62: error: 'DBusAddWatchFunction' was not declared in this scope<br>/usr/include/dbus/dbus-connection.h:62: error: expected ',' or ';' before '(' token<br>/usr/include/dbus/dbus-connection.h:118: error: 'dbus_uint32_t' has not been declared
<br>/usr/include/dbus/dbus-connection.h:128: error: 'DBusAddWatchFunction' has not been declared<br>/usr/include/dbus/dbus-connection.h:187: error: 'dbus_int32_t' was not declared in this scope<br>/usr/include/dbus/dbus-connection.h
:187: error: 'slot_p' was not declared in this scope<br>/usr/include/dbus/dbus-connection.h:188: error: variable or field 'dbus_connection_free_data_slot' declared void<br>/usr/include/dbus/dbus-connection.h:188: error: 'dbus_int32_t' was not declared in this scope
<br>/usr/include/dbus/dbus-connection.h:188: error: 'slot_p' was not declared in this scope<br>/usr/include/dbus/dbus-connection.h:190: error: 'dbus_int32_t' has not been declared<br>/usr/include/dbus/dbus-connection.h:194: error: 'dbus_int32_t' has not been declared
<br>/usr/include/dbus/dbus-connection.h:212: error: 'dbus_uint32_t' has not been declared<br>/usr/include/dbus/dbus-bus.h:60: error: 'dbus_uint32_t' has not been declared<br>/usr/include/dbus/dbus-bus.h:61: error: 'dbus_uint32_t' has not been declared
<br>/usr/include/dbus/dbus-pending-call.h:47: error: 'dbus_int32_t' was not declared in this scope<br>/usr/include/dbus/dbus-pending-call.h:47: error: 'slot_p' was not declared in this scope<br>/usr/include/dbus/dbus-pending-call.h
:48: error: variable or field 'dbus_pending_call_free_data_slot' declared void<br>/usr/include/dbus/dbus-pending-call.h:48: error: 'dbus_int32_t' was not declared in this scope<br>/usr/include/dbus/dbus-pending-call.h:48: error: 'slot_p' was not declared in this scope
<br>/usr/include/dbus/dbus-pending-call.h:50: error: 'dbus_int32_t' has not been declared<br>/usr/include/dbus/dbus-pending-call.h:54: error: 'dbus_int32_t' has not been declared<br>/usr/include/dbus/dbus-server.h:55: error: 'DBusAddWatchFunction' has not been declared
<br>/usr/include/dbus/dbus-server.h:69: error: 'dbus_int32_t' was not declared in this scope<br>/usr/include/dbus/dbus-server.h:69: error: 'slot_p' was not declared in this scope<br>/usr/include/dbus/dbus-server.h:70: error: variable or field 'dbus_server_free_data_slot' declared void
<br>/usr/include/dbus/dbus-server.h:70: error: 'dbus_int32_t' was not declared in this scope<br>/usr/include/dbus/dbus-server.h:70: error: 'slot_p' was not declared in this scope<br><br>My &quot;uname -a&quot; returns:<br>
<br>loreno@teckiller:Testes$ uname -a<br>Linux teckiller 2.6.15-28-386 #1 PREEMPT Thu Feb 1 15:51:56 UTC 2007 i686 GNU/Linux<br>loreno@teckiller:Testes$<br><br>My installed dbus-related pakages are:<br><br>loreno@teckiller
:Testes$ dpkg --list | grep dbus<br>ii&nbsp; dbus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system<br>ii&nbsp; dbus-1-utils&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system (utilit
<br>ii&nbsp; libdbus-1-2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system<br>ii&nbsp; libdbus-1-dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system (develo
<br>ii&nbsp; libdbus-glib-1-2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system (GLib-b<br>ii&nbsp; libdbus-glib-1-dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system (GLib i
<br>ii&nbsp; python2.4-dbus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system (Python<br>loreno@teckiller:Testes$<br><br><br>Does anybody can give me some direction over what I am doing wrong here??
<br><br>Thanks for any help!<br><br>Loreno<br>

------=_Part_84518_6763240.1174006065121--


--===============1077112011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1077112011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1077112011==--
