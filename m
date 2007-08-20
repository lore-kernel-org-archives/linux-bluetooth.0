Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <79be12f70708201025o57287cfeu43a86231220571fe@mail.gmail.com>
Date: Mon, 20 Aug 2007 11:25:01 -0600
From: "John Sample" <john.m.sample@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <79be12f70708200908k48717fd4w2baa95824304733c@mail.gmail.com>
MIME-Version: 1.0
References: <79be12f70708200908k48717fd4w2baa95824304733c@mail.gmail.com>
Subject: [Bluez-users] HCI Daemon Unable to get on D-Bus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1737455088=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1737455088==
Content-Type: multipart/alternative;
	boundary="----=_Part_76143_12141875.1187630701996"

------=_Part_76143_12141875.1187630701996
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Umesh,

I did a ./configure --prefix=/usr followed by make and make install for both
libs and utils.

John


> Hi Mr.John, Can i get the compilation procedure for bluez libs and utils
>
> Regards
> Umesh
>
>
> On 8/20/07, John Sample <john.m.sample@gm...> wrote:
> >
> > I've been working on getting Bluez up an running on an embedded platform
> > and am having some problems getting hcid to run. I'm using the
> 2.6.23kernel, but I've also tested on an old
> > 2.6.10 kernel and run into the same problem. I start D-Bus using
> > dbus-daemon-1 --system, and it starts ok without any error messages. I
> then
> > start hcid, but it immediately exits and I get the following in my
> syslog:
> >
> > hcid[1021]: Bluetooth HCI daemon
> > hcid[1021]: Can't connect to system message bus: Did not receive a
> reply.
> > Possible causes include: the remote application did not send a reply,
> the
> > message bus security policy blocked the reply, the reply timeout
> expired, or
> > the network connection was broken.
> > hcid[1021]: Unable to get on D-Bus
> > Do I need to modify bluetooth.conf or system.conf in any way to get the
> > security policy to allow the connection? I saw a similar post a while
> ago
> > on this same topic but I couldn't find a resolution anywhere.
> >
> > Thanks,
> >
> > --
> > John Sample
>

------=_Part_76143_12141875.1187630701996
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Umesh,</div>
<div>&nbsp;</div>
<div>I did a ./configure --prefix=/usr followed by make and make install for both libs and utils.</div>
<div>&nbsp;</div>
<div>John</div>
<div>&nbsp;</div>
<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Hi Mr.John, Can i get the compilation procedure for bluez libs and utils<br><br>Regards<br>Umesh<br><br><br>On 8/20/07, John Sample &lt;john.m.sample@gm...&gt; wrote:<br>&gt;<br>&gt; I&#39;ve been working on getting Bluez up an running on an embedded platform
<br>&gt; and am having some problems getting hcid to run. I&#39;m using the 2.6.23kernel, but I&#39;ve also tested on an old<br>&gt; 2.6.10 kernel and run into the same problem. I start D-Bus using<br>&gt; dbus-daemon-1 --system, and it starts ok without any error messages. I then
<br>&gt; start hcid, but it immediately exits and I get the following in my syslog:<br>&gt;<br>&gt; hcid[1021]: Bluetooth HCI daemon<br>&gt; hcid[1021]: Can&#39;t connect to system message bus: Did not receive a reply.<br>
&gt; Possible causes include: the remote application did not send a reply, the<br>&gt; message bus security policy blocked the reply, the reply timeout expired, or<br>&gt; the network connection was broken.<br>&gt; hcid[1021]: Unable to get on D-Bus
<br>&gt; Do I need to modify bluetooth.conf or system.conf in any way to get the<br>&gt; security policy to allow the connection? I saw a similar post a while ago<br>&gt; on this same topic but I couldn&#39;t find a resolution anywhere.
<br>&gt;<br>&gt; Thanks,<br>&gt;<br>&gt; --<br>&gt; John Sample</div></blockquote></div>

------=_Part_76143_12141875.1187630701996--


--===============1737455088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1737455088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1737455088==--
