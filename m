Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <80236d750703270544g12df0f26w2547ed8cc4a3649@mail.gmail.com>
Date: Tue, 27 Mar 2007 14:44:43 +0200
From: "Emanuele Novelli" <ema.novelli@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1174991523.5815.41.camel@violet>
MIME-Version: 1.0
References: <80236d750703270300y3497df0et16f6f1a1d3ce53e0@mail.gmail.com>
	<1174991523.5815.41.camel@violet>
Subject: Re: [Bluez-users] clearing remote name cache
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0767678276=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0767678276==
Content-Type: multipart/alternative;
	boundary="----=_Part_5304_2361830.1174999483218"

------=_Part_5304_2361830.1174999483218
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/3/27, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Emanuele,
>
> > Hi using the hints about reading remote names from various threads I
> > got on this ML time ago I started experiments with D-Bus API for
> > bluez.
> >
> > I tried to read a remotename in a thread called from another thread
> > who does inquiry.
> > Each time he found a bdaddress he ask for a name
> > (snipped code)
> >
> > msg = dbus_message_new_method_call("org.bluez", "/org/bluez/hci0",
> > "org.bluez.Adapter", "GetRemoteName");
> > dbus_message_append_args(msg, DBUS_TYPE_STRING,
> > &bdaddress,DBUS_TYPE_INVALID);
> > reply = dbus_connection_send_with_reply_and_block(conn, msg, -1,
> > &err);
> >  if (reply == NULL) {
> >  printf("Error %s\n", err.message);
> >
> >   }
> >  else {
> >  dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &name,
> > DBUS_TYPE_INVALID);
> >                 PBLOG_INFO("%s\n", name);
> > }
> >
> > all works well till I change the name of the remote device (a phone).
> > Each time I run the program I still get the old name, no matter how
> > can try.
> > Only workaround I got to solve this is to manually invoke hcitool name
> > <bdaddress> to change the actual name in cache.
>
> the name resolving operation is an expensive operation. It always
> involves a low-level baseband page. So we try to avoid these kind of
> operation whenever possible. This means that we return the cached name
> all the time. However the cache will be automatically updated when you
> actually connect to the remote device or if extended inquiry (a new
> Bluetooth 2.1 feature) is used.


Ok thanks for  answer,  I'd like  more info about this.
 Are  2.1 compliance dongles already available on the market for end users?
And even if I'll got one of those I guess the remote devices should be
2.1too to answer to an extended inquiry.
What about the Bluez support about the new features of Bluetooth 2.1? (both
low level HCI api and D-bus)

------=_Part_5304_2361830.1174999483218
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/3/27, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Emanuele,<br><br>&gt; Hi using the hints about reading remote names from various threads I<br>&gt; got on this ML time ago I started experiments with D-Bus API for<br>&gt; bluez.<br>&gt;<br>&gt; I tried to read a remotename in a thread called from another thread
<br>&gt; who does inquiry.<br>&gt; Each time he found a bdaddress he ask for a name<br>&gt; (snipped code)<br>&gt;<br>&gt; msg = dbus_message_new_method_call(&quot;org.bluez&quot;, &quot;/org/bluez/hci0&quot;,<br>&gt; &quot;
org.bluez.Adapter&quot;, &quot;GetRemoteName&quot;);<br>&gt; dbus_message_append_args(msg, DBUS_TYPE_STRING,<br>&gt; &amp;bdaddress,DBUS_TYPE_INVALID);<br>&gt; reply = dbus_connection_send_with_reply_and_block(conn, msg, -1,
<br>&gt; &amp;err);<br>&gt;&nbsp;&nbsp;if (reply == NULL) {<br>&gt;&nbsp;&nbsp;printf(&quot;Error %s\n&quot;, err.message);<br>&gt;<br>&gt;&nbsp;&nbsp; }<br>&gt;&nbsp;&nbsp;else {<br>&gt;&nbsp;&nbsp;dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &amp;name,<br>&gt; DBUS_TYPE_INVALID);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PBLOG_INFO(&quot;%s\n&quot;, name);<br>&gt; }<br>&gt;<br>&gt; all works well till I change the name of the remote device (a phone).<br>&gt; Each time I run the program I still get the old name, no matter how
<br>&gt; can try.<br>&gt; Only workaround I got to solve this is to manually invoke hcitool name<br>&gt; &lt;bdaddress&gt; to change the actual name in cache.<br><br>the name resolving operation is an expensive operation. It always
<br>involves a low-level baseband page. So we try to avoid these kind of<br>operation whenever possible. This means that we return the cached name<br>all the time. However the cache will be automatically updated when you<br>
actually connect to the remote device or if extended inquiry (a new<br>Bluetooth 2.1 feature) is used.</blockquote><div><br>Ok thanks for&nbsp; answer,&nbsp; I&#39;d like&nbsp; more info about this. <br>&nbsp;Are&nbsp; 2.1 compliance dongles already available on the market for end users? 
<br>And even if I&#39;ll got one of those I guess the remote devices should be 2.1 too to answer to an extended inquiry.<br>What about the Bluez support about the new features of Bluetooth 2.1? (both low level HCI api and D-bus)
<br></div><br></div><br>

------=_Part_5304_2361830.1174999483218--


--===============0767678276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0767678276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0767678276==--
