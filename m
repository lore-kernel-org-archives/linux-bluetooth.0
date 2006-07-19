Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <28c817710607182109l7518990fqc45ea07198919363@mail.gmail.com>
Date: Wed, 19 Jul 2006 12:09:56 +0800
From: ifq <ifqqfi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151516020.26495.10.camel@localhost>
MIME-Version: 1.0
References: <loom.20060628T033626-329@post.gmane.org>
	<1151479698.9544.1.camel@localhost>
	<loom.20060628T190947-394@post.gmane.org>
	<1151516020.26495.10.camel@localhost>
Subject: Re: [Bluez-devel] cross-compiling bluez-utils.3.1
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1549437704=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1549437704==
Content-Type: multipart/alternative;
	boundary="----=_Part_29435_17707867.1153282196807"

------=_Part_29435_17707867.1153282196807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,marcel:
I have a stupid question:can Bluez 3.1 run on ARM system?
I cross-compiled the 3.1.and got lots of error.
is there anyone have success cross-compile 3.1 to ARM?could you give me some
advice?
thanks very much.

2006/6/29, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Steve,
>
> > D-Bus seems like a useful tool for desktops, but possibly overkill
> > and/or unnecessary for embedded systems. Also, as noted before, D-Bus
> > will not build out of the box for cross-compiled systems such as ARM.
> > Since a lot of embedded systems use Bluetooth, this seems problematic.
>
> I am aware of embedded systems and a long time this was the reason for
> keeping D-Bus optional. In the long run it is not worth it and it would
> only increase the complexity. Devices like the Nokia 770 proved that we
> can handle D-Bus in the embedded area and if there are problems, they
> must be addressed in D-Bus.
>
> > What exactly does D-Bus supply in terms of necessary/useful
> functionality for
> > Bluetooth, and how difficult would it be to work around having to use
> it? (I
> > have not taken a serious look at the new release yet, as I'm still
> working
> > on a basic understanding of the 2.21 version).
>
> D-Bus is a message bus (IPC based). Something like RPC and it makes
> writing client applications a lot easier. The BlueZ D-Bus API provides a
> clean interface to basic Bluetooth tasks. You don't need any knowledge
> about HCI anymore. You can also write your application in C, C++, Java,
> Python, C# etc. and they don't need to be put under GPL.
>
> Trying to implement your own message bus to avoid the D-Bus dependency
> is not worth it. We considered it in the beginning, but this would
> increase the complexity without any real benefit.
>
> Regards
>
> Marcel
>
>
>
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_29435_17707867.1153282196807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,marcel:<br>I have a stupid question:can Bluez 3.1 run on ARM system?<br>I cross-compiled the 3.1.and got lots of error.<br>is there anyone have success cross-compile 3.1 to ARM?could you give me some advice?<br>thanks very much.
<br><br><div><span class="gmail_quote">2006/6/29, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Steve,<br><br>&gt; D-Bus seems like a useful tool for desktops, but possibly overkill<br>&gt; and/or unnecessary for embedded systems. Also, as noted before, D-Bus<br>&gt; will not build out of the box for cross-compiled systems such as ARM.
<br>&gt; Since a lot of embedded systems use Bluetooth, this seems problematic.<br><br>I am aware of embedded systems and a long time this was the reason for<br>keeping D-Bus optional. In the long run it is not worth it and it would
<br>only increase the complexity. Devices like the Nokia 770 proved that we<br>can handle D-Bus in the embedded area and if there are problems, they<br>must be addressed in D-Bus.<br><br>&gt; What exactly does D-Bus supply in terms of necessary/useful functionality for
<br>&gt; Bluetooth, and how difficult would it be to work around having to use it? (I<br>&gt; have not taken a serious look at the new release yet, as I'm still working<br>&gt; on a basic understanding of the 2.21 version).
<br><br>D-Bus is a message bus (IPC based). Something like RPC and it makes<br>writing client applications a lot easier. The BlueZ D-Bus API provides a<br>clean interface to basic Bluetooth tasks. You don't need any knowledge
<br>about HCI anymore. You can also write your application in C, C++, Java,<br>Python, C# etc. and they don't need to be put under GPL.<br><br>Trying to implement your own message bus to avoid the D-Bus dependency<br>is not worth it. We considered it in the beginning, but this would
<br>increase the complexity without any real benefit.<br><br>Regards<br><br>Marcel<br><br><br><br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_29435_17707867.1153282196807--


--===============1549437704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1549437704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1549437704==--
