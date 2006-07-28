Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c5cec3110607272048n5caaa944me0fc4bf74a58591@mail.gmail.com>
Date: Fri, 28 Jul 2006 11:48:47 +0800
From: bees <guoqibi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1153898826.746.16.camel@localhost>
MIME-Version: 1.0
References: <c5cec3110607192037w3d5a3086ib00ff4d6c8b5c93@mail.gmail.com>
	<1153898826.746.16.camel@localhost>
Subject: Re: [Bluez-users] usb device problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0202101228=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0202101228==
Content-Type: multipart/alternative;
	boundary="----=_Part_79049_7678552.1154058527454"

------=_Part_79049_7678552.1154058527454
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel:
thank you for reply.
my kernel is 2.4.20, and proecssor is imx21 of freescale.
According your reply, if i use the 2.6 kernel , the usb device will be ok?

Best Regards

Bees


2006/7/26, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Bees,
>
> >     I ported the bluez-libs-2.25 and bluez-utils-2.25 to an embedded
> > system last week, but when I plug my usb bluetooth dongle into the
> > board, it says"usb device not accepting new address", so I can't use
> > my bluetooth dongle in this embedded system.
> >     I'sure my usb bluetooth is well, it worked normally on PC
> > (FedoraCore4).
> >     And the usb interface on board is well too, because when I pluged
> > my U-disk into it ,the U-disk worked normally.
> >     Then why my usb dongle didn't work on the embedded system board?
>
> what kernel version are you using? The recent 2.6 kernels are a little
> bit more robust when it comes to cheap USB hardware.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_79049_7678552.1154058527454
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Marcel:</div>
<div>thank you for reply.</div>
<div>my kernel is 2.4.20, and proecssor is imx21 of freescale.</div>
<div>According your reply, if i use the 2.6 kernel ,&nbsp;the usb device&nbsp;will be ok?</div>
<div>&nbsp;</div>
<div>Best Regards</div>
<div>&nbsp;</div>
<div>Bees<br><br>&nbsp;</div>
<div><span class="gmail_quote">2006/7/26, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Bees,<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; I ported the bluez-libs-2.25 and bluez-utils-2.25 to an embedded<br>&gt; system last week, but when I plug my usb bluetooth dongle into the
<br>&gt; board, it says&quot;usb device not accepting new address&quot;, so I can't use<br>&gt; my bluetooth dongle in this embedded system.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; I'sure my usb bluetooth is well, it worked normally on PC<br>&gt; (FedoraCore4).
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; And the usb interface on board is well too, because when I pluged<br>&gt; my U-disk into it ,the U-disk worked normally.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Then why my usb dongle didn't work on the embedded system board?<br><br>what kernel version are you using? The recent 
2.6 kernels are a little<br>bit more robust when it comes to cheap USB hardware.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT
<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys -- and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_79049_7678552.1154058527454--


--===============0202101228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0202101228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0202101228==--
