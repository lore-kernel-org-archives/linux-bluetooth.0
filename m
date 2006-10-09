Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20610090457v2496098di62a90f63f1c13dc1@mail.gmail.com>
Date: Mon, 9 Oct 2006 19:57:59 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1160387263.4489.1.camel@localhost>
MIME-Version: 1.0
References: <3f5a9ba20609291930r5b4e4c97g8b33901666fef491@mail.gmail.com>
	<3f5a9ba20610020946v10c99300pee5cc04f3f2597e6@mail.gmail.com>
	<1159972670.1601.25.camel@localhost>
	<3f5a9ba20610072313w41cb4aa1qf0b5a21a7199f737@mail.gmail.com>
	<1160314144.4258.8.camel@aeonflux.holtmann.net>
	<3f5a9ba20610081957id1408a8m6f1648b8fae14e79@mail.gmail.com>
	<1160387263.4489.1.camel@localhost>
Subject: Re: [Bluez-devel] About the kernel 2.6.18
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1945475421=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1945475421==
Content-Type: multipart/alternative;
	boundary="----=_Part_172397_1118858.1160395079508"

------=_Part_172397_1118858.1160395079508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks, I will try to use a real machine to test it.

2006/10/9, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi,
>
> > I am just use the Bluetooth OBEX Object Push client (0.99 beta1).
> > ====================================
> > Host:
> >  Vmware 5.5
> >  OS: Suse 10.1
> >  bluetooth dongle: 1.2
> >  File pushed: testpkg whose size is 137956B
> >
> > Target:
> >   Nokia E61
> >
> >   kernel version: 2.6.16.13-4 (built from Suse 10.1) about 11-12s
> >   kernel version: 2.6.16.13-4 (rebuilt from above) about 11-12s
> >   kernel version: 2.6.17 (built from kernel.org)  about 11-12s
> >   kernel version: 2.6.18: about  145s
> >   kernel version: 2.6.18 with mh4 (built with the patch from bluez):
> > 143s  146s
>
> since you are using VMware. Which is running the 2.6.18 kernel. The host
> or the guest operating system. This could be bottleneck in the USB part
> and not Bluetooth.
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
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



-- 
With respects,
   Mingfan.Lu

------=_Part_172397_1118858.1160395079508
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks, I will try to use a real machine to test it.<br><br>
<div><span class="gmail_quote">2006/10/9, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>&gt; I am just use the Bluetooth OBEX Object Push client (0.99 beta1).<br>&gt; ====================================
<br>&gt; Host:<br>&gt;&nbsp;&nbsp;Vmware 5.5<br>&gt;&nbsp;&nbsp;OS: Suse 10.1<br>&gt;&nbsp;&nbsp;bluetooth dongle: 1.2<br>&gt;&nbsp;&nbsp;File pushed: testpkg whose size is 137956B<br>&gt;<br>&gt; Target:<br>&gt;&nbsp;&nbsp; Nokia E61<br>&gt;<br>&gt;&nbsp;&nbsp; kernel version: 2.6.16.13-4
 (built from Suse 10.1) about 11-12s<br>&gt;&nbsp;&nbsp; kernel version: 2.6.16.13-4 (rebuilt from above) about 11-12s<br>&gt;&nbsp;&nbsp; kernel version: 2.6.17 (built from <a href="http://kernel.org">kernel.org</a>)&nbsp;&nbsp;about 11-12s<br>&gt;&nbsp;&nbsp; kernel version: 
2.6.18: about&nbsp;&nbsp;145s<br>&gt;&nbsp;&nbsp; kernel version: 2.6.18 with mh4 (built with the patch from bluez):<br>&gt; 143s&nbsp;&nbsp;146s<br><br>since you are using VMware. Which is running the 2.6.18 kernel. The host<br>or the guest operating system. This could be bottleneck in the USB part
<br>and not Bluetooth.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys -- and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br><br clear="all"><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu 

------=_Part_172397_1118858.1160395079508--


--===============1945475421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1945475421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1945475421==--
