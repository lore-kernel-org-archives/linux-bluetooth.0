Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60703161237w6996f428i5a3d2e947f4b9112@mail.gmail.com>
Date: Fri, 16 Mar 2007 12:37:46 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <c49421c50703151747p68921f33n95a9b82247e515e1@mail.gmail.com>
MIME-Version: 1.0
References: <c49421c50703151747p68921f33n95a9b82247e515e1@mail.gmail.com>
Subject: Re: [Bluez-users] error compiling code that uses dbus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1472686273=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1472686273==
Content-Type: multipart/alternative;
	boundary="----=_Part_59259_25450819.1174073866745"

------=_Part_59259_25450819.1174073866745
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Loreno:

I had no problem compiling your code but I am using an older version of DBUS
(0.6.2)

I did this to compile:
  g++ -I/usr/local/dbus0.62 -L/usr/local/lib -o test test.c -ldbus-1


Mark




On 3/15/07, Loreno Oliveira <lorenooliveira@gmail.com> wrote:
>
> Hi there,
>
> i am trying to compile a simple program, from some presentation of
> Marcell, but it seems that the dbus headers are someway broken.
>
> The program is:
>
> #include <stdio.h>
> #include <stdlib.h >
> #include <dbus/dbus.h>
>
> int main( int argc, char **argv ) {
>     return 0;
> }
>
>
> Yes, there is no body in the program, just the #include. When I compile
> this code I get:
>
> /usr/include/dbus/dbus.h:33:33: error: dbus/dbus- arch-deps.h: No such
> file or directory
> /usr/include/dbus/dbus-types.h:33: error: 'dbus_uint32_t' does not name a
> type
> /usr/include/dbus/dbus-types.h:35: error: 'dbus_uint32_t' does not name a
> type
> /usr/include/dbus/dbus- errors.h:66: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-errors.h:68: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-address.h:35: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:49: error: 'dbus_uint32_t' does not name
> a type
> /usr/include/dbus/dbus-message.h:85: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:88: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:90: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:93: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:95: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:98: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:100: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:103: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:106: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:111: error: 'dbus_bool_t' has not been
> declared
> /usr/include/dbus/dbus-message.h:112: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:113: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:116: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:119: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:121: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:123: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:125: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:127: error: 'dbus_uint32_t' does not name
> a type
> /usr/include/dbus/dbus-message.h:128: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:130: error: 'dbus_uint32_t' does not name
> a type
> /usr/include/dbus/dbus-message.h:133: error: 'dbus_bool_t' has not been
> declared
> /usr/include/dbus/dbus-message.h:134: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:136: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:139: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:142: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:145: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:149: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:155: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:157: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:158: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:174: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:177: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:181: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:185: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:189: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:193: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:194: error: variable or field
> 'dbus_message_free_data_slot' declared void
> /usr/include/dbus/dbus-message.h :194: error: 'dbus_int32_t' was not
> declared in this scope
> /usr/include/dbus/dbus-message.h:194: error: 'slot_p' was not declared in
> this scope
> /usr/include/dbus/dbus-message.h:195: error: 'dbus_bool_t' does not name a
> type
> /usr/include/dbus/dbus-message.h:200: error: 'dbus_int32_t' has not been
> declared
> /usr/include/dbus/dbus-connection.h:62: error: typedef 'dbus_bool_t' is
> initialized (use __typeof__ instead)
> /usr/include/dbus/dbus- connection.h:62: error: 'DBusAddWatchFunction' was
> not declared in this scope
> /usr/include/dbus/dbus-connection.h:62: error: expected ',' or ';' before
> '(' token
> /usr/include/dbus/dbus-connection.h:118: error: 'dbus_uint32_t' has not
> been declared
> /usr/include/dbus/dbus-connection.h:128: error: 'DBusAddWatchFunction' has
> not been declared
> /usr/include/dbus/dbus-connection.h:187: error: 'dbus_int32_t' was not
> declared in this scope
> /usr/include/dbus/dbus-connection.h :187: error: 'slot_p' was not declared
> in this scope
> /usr/include/dbus/dbus-connection.h:188: error: variable or field
> 'dbus_connection_free_data_slot' declared void
> /usr/include/dbus/dbus-connection.h:188: error: 'dbus_int32_t' was not
> declared in this scope
> /usr/include/dbus/dbus-connection.h:188: error: 'slot_p' was not declared
> in this scope
> /usr/include/dbus/dbus-connection.h:190: error: 'dbus_int32_t' has not
> been declared
> /usr/include/dbus/dbus-connection.h:194: error: 'dbus_int32_t' has not
> been declared
> /usr/include/dbus/dbus-connection.h:212: error: 'dbus_uint32_t' has not
> been declared
> /usr/include/dbus/dbus-bus.h:60: error: 'dbus_uint32_t' has not been
> declared
> /usr/include/dbus/dbus-bus.h:61: error: 'dbus_uint32_t' has not been
> declared
> /usr/include/dbus/dbus-pending-call.h:47: error: 'dbus_int32_t' was not
> declared in this scope
> /usr/include/dbus/dbus-pending-call.h:47: error: 'slot_p' was not declared
> in this scope
> /usr/include/dbus/dbus-pending-call.h :48: error: variable or field
> 'dbus_pending_call_free_data_slot' declared void
> /usr/include/dbus/dbus-pending-call.h:48: error: 'dbus_int32_t' was not
> declared in this scope
> /usr/include/dbus/dbus-pending-call.h:48: error: 'slot_p' was not declared
> in this scope
> /usr/include/dbus/dbus-pending-call.h:50: error: 'dbus_int32_t' has not
> been declared
> /usr/include/dbus/dbus-pending-call.h:54: error: 'dbus_int32_t' has not
> been declared
> /usr/include/dbus/dbus-server.h:55: error: 'DBusAddWatchFunction' has not
> been declared
> /usr/include/dbus/dbus-server.h:69: error: 'dbus_int32_t' was not declared
> in this scope
> /usr/include/dbus/dbus-server.h:69: error: 'slot_p' was not declared in
> this scope
> /usr/include/dbus/dbus-server.h:70: error: variable or field
> 'dbus_server_free_data_slot' declared void
> /usr/include/dbus/dbus-server.h:70: error: 'dbus_int32_t' was not declared
> in this scope
> /usr/include/dbus/dbus-server.h:70: error: 'slot_p' was not declared in
> this scope
>
> My "uname -a" returns:
>
> loreno@teckiller:Testes$ uname -a
> Linux teckiller 2.6.15-28-386 #1 PREEMPT Thu Feb 1 15:51:56 UTC 2007 i686
> GNU/Linux
> loreno@teckiller:Testes$
>
> My installed dbus-related pakages are:
>
> loreno@teckiller :Testes$ dpkg --list | grep dbus
> ii  dbus                                   0.60-6ubuntu8.1
> simple interprocess messaging system
> ii  dbus-1-utils                           0.60-6ubuntu8.1
> simple interprocess messaging system (utilit
> ii  libdbus-1-2                            0.60-6ubuntu8.1
> simple interprocess messaging system
> ii  libdbus-1-dev                          0.60-6ubuntu8.1
> simple interprocess messaging system (develo
> ii  libdbus-glib-1-2                       0.60-6ubuntu8.1
> simple interprocess messaging system (GLib-b
> ii  libdbus-glib-1-dev                     0.60-6ubuntu8.1
> simple interprocess messaging system (GLib i
> ii  python2.4-dbus                         0.60-6ubuntu8.1
> simple interprocess messaging system (Python
> loreno@teckiller:Testes$
>
>
> Does anybody can give me some direction over what I am doing wrong here??
>
> Thanks for any help!
>
> Loreno
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>

------=_Part_59259_25450819.1174073866745
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Loreno:<br><br>I had no problem compiling your code but I am using an older version of DBUS (0.6.2)<br><br>I did this to compile:<br>&nbsp; g++ -I/usr/local/dbus0.62 -L/usr/local/lib -o test test.c -ldbus-1<br><br><br>Mark<br><br>
<br><br><br><div><span class="gmail_quote">On 3/15/07, <b class="gmail_sendername">Loreno Oliveira</b> &lt;<a href="mailto:lorenooliveira@gmail.com">lorenooliveira@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi there,<br><br>i am trying to compile a simple program, from some presentation of Marcell, but it seems that the dbus headers are someway broken.<br><br>The program is:<br><br>#include &lt;stdio.h&gt;<br>#include &lt;stdlib.h

&gt;<br>#include &lt;dbus/dbus.h&gt;<br><br>int main( int argc, char **argv ) {<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br><br>Yes, there is no body in the program, just the #include. When I compile this code I get:<br><br>/usr/include/dbus/dbus.h:33:33: error: dbus/dbus-
arch-deps.h: No such file or directory<br>/usr/include/dbus/dbus-types.h:33: error: &#39;dbus_uint32_t&#39; does not name a type<br>/usr/include/dbus/dbus-types.h:35: error: &#39;dbus_uint32_t&#39; does not name a type<br>
/usr/include/dbus/dbus-
errors.h:66: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-errors.h:68: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-address.h:35: error: &#39;dbus_bool_t&#39; does not name a type
<br>
/usr/include/dbus/dbus-message.h:49: error: &#39;dbus_uint32_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:85: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:88: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:90: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:93: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:95: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:98: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:100: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:103: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:106: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:111: error: &#39;dbus_bool_t&#39; has not been declared<br>/usr/include/dbus/dbus-message.h:112: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:113: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:116: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:119: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:121: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:123: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:125: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:127: error: &#39;dbus_uint32_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:128: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h
:130: error: &#39;dbus_uint32_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:133: error: &#39;dbus_bool_t&#39; has not been declared<br>/usr/include/dbus/dbus-message.h:134: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:136: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:139: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:142: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:145: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:149: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:155: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:157: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:158: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:174: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:177: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:181: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:185: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:189: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:193: error: &#39;dbus_bool_t&#39; does not name a type<br>/usr/include/dbus/dbus-message.h:194: error: variable or field &#39;dbus_message_free_data_slot&#39; declared void<br>/usr/include/dbus/dbus-
message.h
:194: error: &#39;dbus_int32_t&#39; was not declared in this scope<br>/usr/include/dbus/dbus-message.h:194: error: &#39;slot_p&#39; was not declared in this scope<br>/usr/include/dbus/dbus-message.h:195: error: &#39;dbus_bool_t&#39; does not name a type
<br>/usr/include/dbus/dbus-message.h:200: error: &#39;dbus_int32_t&#39; has not been declared<br>/usr/include/dbus/dbus-connection.h:62: error: typedef &#39;dbus_bool_t&#39; is initialized (use __typeof__ instead)<br>/usr/include/dbus/dbus-
connection.h:62: error: &#39;DBusAddWatchFunction&#39; was not declared in this scope<br>/usr/include/dbus/dbus-connection.h:62: error: expected &#39;,&#39; or &#39;;&#39; before &#39;(&#39; token<br>/usr/include/dbus/dbus-
connection.h:118: error: &#39;dbus_uint32_t&#39; has not been declared
<br>/usr/include/dbus/dbus-connection.h:128: error: &#39;DBusAddWatchFunction&#39; has not been declared<br>/usr/include/dbus/dbus-connection.h:187: error: &#39;dbus_int32_t&#39; was not declared in this scope<br>/usr/include/dbus/dbus-
connection.h
:187: error: &#39;slot_p&#39; was not declared in this scope<br>/usr/include/dbus/dbus-connection.h:188: error: variable or field &#39;dbus_connection_free_data_slot&#39; declared void<br>/usr/include/dbus/dbus-connection.h
:188: error: &#39;dbus_int32_t&#39; was not declared in this scope
<br>/usr/include/dbus/dbus-connection.h:188: error: &#39;slot_p&#39; was not declared in this scope<br>/usr/include/dbus/dbus-connection.h:190: error: &#39;dbus_int32_t&#39; has not been declared<br>/usr/include/dbus/dbus-
connection.h:194: error: &#39;dbus_int32_t&#39; has not been declared
<br>/usr/include/dbus/dbus-connection.h:212: error: &#39;dbus_uint32_t&#39; has not been declared<br>/usr/include/dbus/dbus-bus.h:60: error: &#39;dbus_uint32_t&#39; has not been declared<br>/usr/include/dbus/dbus-bus.h:61: error: &#39;dbus_uint32_t&#39; has not been declared
<br>/usr/include/dbus/dbus-pending-call.h:47: error: &#39;dbus_int32_t&#39; was not declared in this scope<br>/usr/include/dbus/dbus-pending-call.h:47: error: &#39;slot_p&#39; was not declared in this scope<br>/usr/include/dbus/dbus-
pending-call.h
:48: error: variable or field &#39;dbus_pending_call_free_data_slot&#39; declared void<br>/usr/include/dbus/dbus-pending-call.h:48: error: &#39;dbus_int32_t&#39; was not declared in this scope<br>/usr/include/dbus/dbus-pending-call.h
:48: error: &#39;slot_p&#39; was not declared in this scope
<br>/usr/include/dbus/dbus-pending-call.h:50: error: &#39;dbus_int32_t&#39; has not been declared<br>/usr/include/dbus/dbus-pending-call.h:54: error: &#39;dbus_int32_t&#39; has not been declared<br>/usr/include/dbus/dbus-
server.h:55: error: &#39;DBusAddWatchFunction&#39; has not been declared
<br>/usr/include/dbus/dbus-server.h:69: error: &#39;dbus_int32_t&#39; was not declared in this scope<br>/usr/include/dbus/dbus-server.h:69: error: &#39;slot_p&#39; was not declared in this scope<br>/usr/include/dbus/dbus-
server.h:70: error: variable or field &#39;dbus_server_free_data_slot&#39; declared void
<br>/usr/include/dbus/dbus-server.h:70: error: &#39;dbus_int32_t&#39; was not declared in this scope<br>/usr/include/dbus/dbus-server.h:70: error: &#39;slot_p&#39; was not declared in this scope<br><br>My &quot;uname -a&quot; returns:
<br>
<br>loreno@teckiller:Testes$ uname -a<br>Linux teckiller 2.6.15-28-386 #1 PREEMPT Thu Feb 1 15:51:56 UTC 2007 i686 GNU/Linux<br>loreno@teckiller:Testes$<br><br>My installed dbus-related pakages are:<br><br>loreno@teckiller

:Testes$ dpkg --list | grep dbus<br>ii&nbsp; dbus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system<br>ii&nbsp; dbus-1-utils&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system (utilit
<br>ii&nbsp; libdbus-1-2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system<br>ii&nbsp; libdbus-1-dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system (develo
<br>ii&nbsp; libdbus-glib-1-2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system (GLib-b<br>ii&nbsp; libdbus-glib-1-dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system (GLib i
<br>ii&nbsp; python2.4-dbus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.60-6ubuntu8.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; simple interprocess messaging system (Python<br>loreno@teckiller:Testes$<br><br><br>Does anybody can give me some direction over what I am doing wrong here??
<br><br>Thanks for any help!<br><span class="sg"><br>Loreno<br>
</span><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-users mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br><br></blockquote></div><br>

------=_Part_59259_25450819.1174073866745--


--===============1472686273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1472686273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1472686273==--
