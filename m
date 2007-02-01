Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <2e9fc96f0702010155w44422a1dp407db8c125f2744e@mail.gmail.com>
Date: Thu, 1 Feb 2007 15:25:55 +0530
From: "Prabhu nath" <gprabhunath@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <ef9938ec0701301404o42c00599mf12770f8141027f4@mail.gmail.com>
MIME-Version: 1.0
References: <2e9fc96f0701252321k59b0320cld9eef725a6cc06ac@mail.gmail.com>
	<20070127035832.4aecaae8@localhost.localdomain>
	<2e9fc96f0701270326g37539095s2c533407439ec8bc@mail.gmail.com>
	<ef9938ec0701271824i65a6a58ejf43d3b02cffe6dff@mail.gmail.com>
	<2e9fc96f0701290848j39544depaad1def88a36d161@mail.gmail.com>
	<ef9938ec0701301404o42c00599mf12770f8141027f4@mail.gmail.com>
Subject: Re: [Bluez-users] Obex File Transfers between Nokia and BlueZ
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1190110277=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1190110277==
Content-Type: multipart/alternative;
	boundary="----=_Part_4113_2320.1170323755969"

------=_Part_4113_2320.1170323755969
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There you go !!!. Thanks a ton. This will work and worked.

Thanks for all your replies.

Cheers,
Prabhu



On 1/31/07, Albert Huang <albert@csail.mit.edu> wrote:
>
> obexftpd is old and outdated.  Additionally, I think it hardcodes the
> RFCOMM channel number to 10, so if you're going to use it, you'll
> probably need to use sdptool --channel=10 instead of --channel=9.
> It's better if you use an obex server that does SDP registration
> automatically.  I think collin mulliner's sobexsrv does this, although
> I haven't tried it myself.
> http://www.mulliner.org/bluetooth/sobexsrv.php
>
> In the past, I've had success with obexserver (
> http://packages.debian.org/stable/comm/obexserver ) which is just as
> old and outdated as obexftpd, but it works.  To use obexserver, you'll
> also need to register a service with sdptool:  sdptool add
> --channel=10 OPUSH ; obexserver.
>
> -albert
>
> On 1/29/07, Prabhu nath <gprabhunath@gmail.com> wrote:
> > Oops.. I am running an headless Linux (without X). Is there obex-server
> > which will work without X.  I browsed over to get obexserver-apps, which
> is
> > no more works for latest openobex lib.
> >
> > I am using obexftpd, I am not sure why it is not working for Nokia but
> works
> > for MotoQ.
> >
> >
> > Thanks,
> > Prabhu
> >
> >
> >
> >
> > On 1/28/07, Albert Huang <albert@csail.mit.edu> wrote:
> > > Are you sure you're actually running an obex server?  If you're using
> > > fedora, then you can use the obexserver that comes with
> > > gnome-bluetooth.  From the foot menu thing, you should find a menu
> > > option that allows you to receive files via bluetooth.  If your
> > > machine is advertising OPUSH but you're not actually running a server,
> > > then it's not going to work.  If you ever used the sdptool command,
> > > then you probably did something wrong.  This is a fairly standard
> > > usage of bluez and nokia phones.
> > >
> > > -albert
> > >
> > > On 1/27/07, Prabhu nath <gprabhunath@gmail.com> wrote:
> > > > I enabled piscan and again no luck.
> > > > I am able to push from BlueZ to Nokia, but vice-versa is not
> possible.
> > i.e.
> > > > Pushing an object/file from Nokia to BlueZ. I do the following on
> the
> > NOkia
> > > > cell phone to push a file.
> > > >
> > > > Select an image, and options->send->via Bluetooth->Select BT Device.
> > > > Once I do, the messsage, sending failed is displayed on the cell
> phone.
> > > >
> > > > -Prabhu
> > > >
> > > >
> > > >
> > > >
> >
> -------------------------------------------------------------------------
> > > > Take Surveys. Earn Cash. Influence the Future of IT
> > > > Join SourceForge.net's Techsay panel and you'll get the chance to
> share
> > your
> > > > opinions on IT & business topics through brief surveys - and earn
> cash
> > > >
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > > >
> > > > _______________________________________________
> > > > Bluez-users mailing list
> > > > Bluez-users@lists.sourceforge.net
> > > >
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > > >
> > > >
> > > >
> > >
> > >
> >
> -------------------------------------------------------------------------
> > > Take Surveys. Earn Cash. Influence the Future of IT
> > > Join SourceForge.net's Techsay panel and you'll get the chance to
> share
> > your
> > > opinions on IT & business topics through brief surveys - and earn cash
> > >
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >
> >
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > opinions on IT & business topics through brief surveys - and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> >
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
> >
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_4113_2320.1170323755969
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>There you go !!!. Thanks a ton. This will work and worked. </div>
<div>&nbsp;</div>
<div>Thanks for all your replies.</div>
<div><br>Cheers,<br>Prabhu</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 1/31/07, <b class="gmail_sendername">Albert Huang</b> &lt;<a href="mailto:albert@csail.mit.edu">albert@csail.mit.edu</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">obexftpd is old and outdated.&nbsp;&nbsp;Additionally, I think it hardcodes the<br>RFCOMM channel number to 10, so if you&#39;re going to use it, you&#39;ll
<br>probably need to use sdptool --channel=10 instead of --channel=9.<br>It&#39;s better if you use an obex server that does SDP registration<br>automatically.&nbsp;&nbsp;I think collin mulliner&#39;s sobexsrv does this, although<br>
I haven&#39;t tried it myself.<br><a href="http://www.mulliner.org/bluetooth/sobexsrv.php">http://www.mulliner.org/bluetooth/sobexsrv.php</a><br><br>In the past, I&#39;ve had success with obexserver (<br><a href="http://packages.debian.org/stable/comm/obexserver">
http://packages.debian.org/stable/comm/obexserver</a> ) which is just as<br>old and outdated as obexftpd, but it works.&nbsp;&nbsp;To use obexserver, you&#39;ll<br>also need to register a service with sdptool:&nbsp;&nbsp;sdptool add<br>--channel=10 OPUSH ; obexserver.
<br><br>-albert<br><br>On 1/29/07, Prabhu nath &lt;<a href="mailto:gprabhunath@gmail.com">gprabhunath@gmail.com</a>&gt; wrote:<br>&gt; Oops.. I am running an headless Linux (without X). Is there obex-server<br>&gt; which will work without X.&nbsp;&nbsp;I browsed over to get obexserver-apps, which is
<br>&gt; no more works for latest openobex lib.<br>&gt;<br>&gt; I am using obexftpd, I am not sure why it is not working for Nokia but works<br>&gt; for MotoQ.<br>&gt;<br>&gt;<br>&gt; Thanks,<br>&gt; Prabhu<br>&gt;<br>&gt;
<br>&gt;<br>&gt;<br>&gt; On 1/28/07, Albert Huang &lt;<a href="mailto:albert@csail.mit.edu">albert@csail.mit.edu</a>&gt; wrote:<br>&gt; &gt; Are you sure you&#39;re actually running an obex server?&nbsp;&nbsp;If you&#39;re using<br>
&gt; &gt; fedora, then you can use the obexserver that comes with<br>&gt; &gt; gnome-bluetooth.&nbsp;&nbsp;From the foot menu thing, you should find a menu<br>&gt; &gt; option that allows you to receive files via bluetooth.&nbsp;&nbsp;If your
<br>&gt; &gt; machine is advertising OPUSH but you&#39;re not actually running a server,<br>&gt; &gt; then it&#39;s not going to work.&nbsp;&nbsp;If you ever used the sdptool command,<br>&gt; &gt; then you probably did something wrong.&nbsp;&nbsp;This is a fairly standard
<br>&gt; &gt; usage of bluez and nokia phones.<br>&gt; &gt;<br>&gt; &gt; -albert<br>&gt; &gt;<br>&gt; &gt; On 1/27/07, Prabhu nath &lt;<a href="mailto:gprabhunath@gmail.com">gprabhunath@gmail.com</a>&gt; wrote:<br>&gt; &gt; &gt; I enabled piscan and again no luck.
<br>&gt; &gt; &gt; I am able to push from BlueZ to Nokia, but vice-versa is not possible.<br>&gt; i.e.<br>&gt; &gt; &gt; Pushing an object/file from Nokia to BlueZ. I do the following on the<br>&gt; NOkia<br>&gt; &gt; &gt; cell phone to push a file.
<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Select an image, and options-&gt;send-&gt;via Bluetooth-&gt;Select BT Device.<br>&gt; &gt; &gt; Once I do, the messsage, sending failed is displayed on the cell phone.<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; -Prabhu<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; &gt; &gt; Take Surveys. Earn Cash. Influence the Future of IT
<br>&gt; &gt; &gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share<br>&gt; your<br>&gt; &gt; &gt; opinions on IT &amp; business topics through brief surveys - and earn cash<br>&gt; &gt; &gt;
<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>&gt; &gt; &gt;<br>&gt; &gt; &gt; _______________________________________________
<br>&gt; &gt; &gt; Bluez-users mailing list<br>&gt; &gt; &gt; <a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>&gt; &gt; &gt;<br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; -------------------------------------------------------------------------
<br>&gt; &gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; &gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share<br>&gt; your<br>&gt; &gt; opinions on IT &amp; business topics through brief surveys - and earn cash
<br>&gt; &gt;<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>&gt; &gt; _______________________________________________
<br>&gt; &gt; Bluez-users mailing list<br>&gt; &gt; <a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>&gt; &gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt; &gt;<br>&gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT
<br>&gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>&gt; opinions on IT &amp; business topics through brief surveys - and earn cash<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>&gt;<br>&gt; _______________________________________________<br>&gt; Bluez-users mailing list<br>&gt; <a href="mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt;<br>&gt;<br>&gt;<br><br>-------------------------------------------------------------------------
<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash
<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________
<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_4113_2320.1170323755969--


--===============1190110277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1190110277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1190110277==--
