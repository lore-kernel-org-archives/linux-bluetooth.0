Return-Path: <cyrus@holtmann.org>
Message-ID: <a8a143bd0808201624u5b5b5fc0p2f35cccfbfd8e63@mail.gmail.com>
Date: Thu, 21 Aug 2008 01:24:57 +0200
From: "Johannes Niederloehner" <johannes.niederloehner@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] in 3.36 registering security interface without
	adapter?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0187503161=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0187503161==
Content-Type: multipart/alternative;
	boundary="----=_Part_19794_10305767.1219274697647"

------=_Part_19794_10305767.1219274697647
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Having some trouble after updating vom 3.31 to 3.36 with registering a
passkeyagent.
Taking a look at the sources I'm wondering couple of things.

in 3.31:

after adding a new adapter...hcid_dbus_register_device calls
dbus_connection_create_object_path and this function of dbus-hci.c adds in
data->user_data the adapter name/path (e.g /org/bluez/hci0)

When a new passkeyagent registers calling the method register_passkey_agent
from the method table security_methods (via the generic_table from
dbus-helper.c)
 the following doesn't fail, since data isnt null:

if (!data) {
        error("register_passkey_agent called without any adapter info!");
        return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
    }



In contrary in 3.36 dbus-helper.c is removed and you are more using GLib
stuff.

the mentioned function hcid_dbus_register_device of dbus-hci.c calls
security_init without passing the adapter name. security_init finally calls
g_dbus_register_interface without providing adapter name.

finally if register_passkey_agent gets called,   the following,  _does
fails_ :

if (!data) {
        error("register_passkey_agent called without any adapter info!");
        return NULL;
    }

since the user_data was never filled.

Everything seems also to be related with the usage of GLib or I mean because
I disabled the usage of that Lib and your own implementation is used instead

Is this a problem, isn't it?
Sorry if I have demonstrated the problem not clearly. In that case just drop
me a line I'll try again tomorrow after having some more sleep.


Thanks,
Johannes N.

------=_Part_19794_10305767.1219274697647
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><table class="NQNkZd"><tbody><tr class="lW3BFe"><td class="Cipym"><br></td></tr></tbody></table>Having some trouble after updating vom 3.31 to 3.36 with registering a passkeyagent.<br>
Taking a look at the sources I&#39;m wondering couple of things.<br>
<br>
in 3.31:<br>
<br>
after adding a new adapter...hcid_dbus_register_device calls
dbus_connection_create_object_path and this function of dbus-hci.c adds
in data-&gt;user_data the adapter name/path (e.g /org/bluez/hci0)<br>
<br>
When a new passkeyagent registers calling the method
register_passkey_agent from the method table security_methods (via the
generic_table from dbus-helper.c) <br>
&nbsp;the following doesn&#39;t fail, since data isnt null:<br>
<br>
if (!data) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; error(&quot;register_passkey_agent called without any adapter info!&quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
<br>
<br>
In contrary in 3.36 dbus-helper.c is removed and you are more using GLib stuff.<br>
<br>
the mentioned function hcid_dbus_register_device of dbus-hci.c calls
security_init without passing the adapter name. security_init finally
calls g_dbus_register_interface without providing adapter name.<br>
<br>
finally if register_passkey_agent gets called, &nbsp; the following,&nbsp; _does fails_ :<br>
<br>
if (!data) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; error(&quot;register_passkey_agent called without any adapter info!&quot;);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
since the user_data was never filled.<br>
<br>
Everything seems also to be related with the usage of GLib or I mean
because I disabled the usage of that Lib and your own implementation is
used instead<br>
<br>
Is this a problem, isn&#39;t it?<br>
Sorry if I have demonstrated the problem not clearly. In that case just
drop me a line I&#39;ll try again tomorrow after having some more sleep.<br>
<br>
<br>
Thanks,<br>
Johannes N.</div>

------=_Part_19794_10305767.1219274697647--


--===============0187503161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0187503161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0187503161==--
