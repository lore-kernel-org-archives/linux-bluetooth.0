Return-Path: <cyrus@holtmann.org>
Message-ID: <a8a143bd0808221123n58701677k2c7cae39809d857@mail.gmail.com>
Date: Fri, 22 Aug 2008 20:23:52 +0200
From: "Johannes Niederloehner" <johannes.niederloehner@gmail.com>
To: "bluez devel" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] bug/problem in 3.36 utils with non GLib (missing
	adapter info when registering a passkey-agent)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1466147568=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1466147568==
Content-Type: multipart/alternative;
	boundary="----=_Part_33825_24811982.1219429432398"

------=_Part_33825_24811982.1219429432398
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Posted this on bluez-users' list, sorry it better should be posted here:
I think t

---------- Forwarded message ----------
From: Johannes Niederloehner <johannes.niederloehner@gmail.com>
Date: Thu, Aug 21, 2008 at 1:24 AM
Subject: in 3.36 registering security interface without adapter?
To: bluez-users@lists.sourceforge.net



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

------=_Part_33825_24811982.1219429432398
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Posted this on bluez-users&#39; list, sorry it better should be posted here:<br>I think t<br><br><div class="gmail_quote">---------- Forwarded message ----------<br>From: <b class="gmail_sendername">Johannes Niederloehner</b> <span dir="ltr">&lt;<a href="mailto:johannes.niederloehner@gmail.com">johannes.niederloehner@gmail.com</a>&gt;</span><br>
Date: Thu, Aug 21, 2008 at 1:24 AM<br>Subject: in 3.36 registering security interface without adapter?<br>To: <a href="mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourceforge.net</a><br><br><br><div dir="ltr">
<table><tbody><tr><td><br></td></tr></tbody></table>Having some trouble after updating vom 3.31 to 3.36 with registering a passkeyagent.<br>
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
</div><br></div>

------=_Part_33825_24811982.1219429432398--


--===============1466147568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1466147568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1466147568==--
