Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <80236d750703270300y3497df0et16f6f1a1d3ce53e0@mail.gmail.com>
Date: Tue, 27 Mar 2007 12:00:23 +0200
From: "Emanuele Novelli" <ema.novelli@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] clearing remote name cache
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1719224359=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1719224359==
Content-Type: multipart/alternative;
	boundary="----=_Part_2810_5973706.1174989623745"

------=_Part_2810_5973706.1174989623745
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi using the hints about reading remote names from various threads I got on
this ML time ago I started experiments with D-Bus API for bluez.

I tried to read a remotename in a thread called from another thread who does
inquiry.
Each time he found a bdaddress he ask for a name
(snipped code)

msg = dbus_message_new_method_call("org.bluez", "/org/bluez/hci0", "
org.bluez.Adapter", "GetRemoteName");
dbus_message_append_args(msg, DBUS_TYPE_STRING,
&bdaddress,DBUS_TYPE_INVALID);
reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
 if (reply == NULL) {
 printf("Error %s\n",err.message);

  }
 else {
 dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &name,
DBUS_TYPE_INVALID);
                PBLOG_INFO("%s\n", name);
}

all works well till I change the name of the remote device (a phone). Each
time I run the program I still get the old name, no matter how can try.
Only workaround I got to solve this is to manually invoke hcitool name
<bdaddress> to change the actual name in cache.


P.S.
I'm rather new to dbus, but everywhere I read advices about dont using the
low level api but use an high level bindings (G-lib, Java, python) but most
of examples I found in bluez source codes use low leve apis, so I guess is
correct using that or not ?

------=_Part_2810_5973706.1174989623745
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi using the hints about reading remote names from various threads I got on this ML time ago I started experiments with D-Bus API for bluez.<br><br>I tried to read a remotename in a thread called from another thread who does inquiry.
<br>Each time he found a bdaddress he ask for a name<br>(snipped code)<br><br>msg = dbus_message_new_method_call(&quot;org.bluez&quot;, &quot;/org/bluez/hci0&quot;, &quot;org.bluez.Adapter&quot;, &quot;GetRemoteName&quot;);
<br>dbus_message_append_args(msg, DBUS_TYPE_STRING, &amp;bdaddress,DBUS_TYPE_INVALID);<br>reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &amp;err);<br>&nbsp;if (reply == NULL) {<br>&nbsp;printf(&quot;Error %s\n&quot;,
err.message);<br><br>&nbsp; }<br>&nbsp;else {<br>&nbsp;dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &amp;name, DBUS_TYPE_INVALID);<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; PBLOG_INFO(&quot;%s\n&quot;, name);<br>}<br><br>all works well till I change the name of the remote device (a phone). Each time I run the program I still get the old name, no matter how can try.
<br>Only workaround I got to solve this is to manually invoke hcitool name &lt;bdaddress&gt; to change the actual name in cache.<br><br><br>P.S.<br>I&#39;m rather new to dbus, but everywhere I read advices about dont using the low level api but use an high level bindings (G-lib, Java, python) but most of examples I found in bluez source codes use low leve apis, so I guess is correct using that or not ?
<br>

------=_Part_2810_5973706.1174989623745--


--===============1719224359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1719224359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1719224359==--
