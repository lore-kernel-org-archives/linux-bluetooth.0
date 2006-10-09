Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20610081957id1408a8m6f1648b8fae14e79@mail.gmail.com>
Date: Mon, 9 Oct 2006 10:57:53 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1160314144.4258.8.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <3f5a9ba20609291930r5b4e4c97g8b33901666fef491@mail.gmail.com>
	<3f5a9ba20610020946v10c99300pee5cc04f3f2597e6@mail.gmail.com>
	<1159972670.1601.25.camel@localhost>
	<3f5a9ba20610072313w41cb4aa1qf0b5a21a7199f737@mail.gmail.com>
	<1160314144.4258.8.camel@aeonflux.holtmann.net>
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
Content-Type: multipart/mixed; boundary="===============0000204813=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0000204813==
Content-Type: multipart/alternative;
	boundary="----=_Part_165931_29887188.1160362673490"

------=_Part_165931_29887188.1160362673490
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I am just use the Bluetooth OBEX Object Push client (0.99 beta1).
====================================
Host:
 Vmware 5.5
 OS: Suse 10.1
 bluetooth dongle: 1.2
 File pushed: testpkg whose size is 137956B

Target:
  Nokia E61

  kernel version: 2.6.16.13-4 (built from Suse 10.1) about 11-12s   kernel
version: 2.6.16.13-4 (rebuilt from above) about 11-12s
  kernel version: 2.6.17 (built from kernel.org)  about 11-12s
  kernel version: 2.6.18: about  145s
  kernel version: 2.6.18 with mh4 (built with the patch from bluez):   143s
146s

Too terrible!!!
====================================

using other RFCOMM applications, 2.6.18 is slower too.

2006/10/8, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi,
>
> >   I have rebuilt the 2.6.17, the speed is good. so, I don't know why
> > 2.6.18 makes the RFCOMM socket communication slower.
> > Who can have a try to compare the speed using different kernel ?
> > Need your nice help. :)
>
> do you have a nice and simple test program and some results of your
> testing. I like to run it by myself.
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

------=_Part_165931_29887188.1160362673490
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi, </div>
<div>I am just use the Bluetooth OBEX Object Push client (0.99 beta1).</div>
<div>====================================</div>
<div>Host:</div>
<div>&nbsp;Vmware 5.5 </div>
<div>&nbsp;OS: Suse 10.1 </div>
<div>&nbsp;bluetooth dongle: 1.2 </div>
<div>&nbsp;File pushed: testpkg whose size is 137956B</div>
<div>&nbsp;</div>
<div>Target: </div>
<div>&nbsp; Nokia E61&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp; kernel version: 2.6.16.13-4 (built from Suse 10.1) about 11-12s 
<div>&nbsp; kernel version: 2.6.16.13-4 (rebuilt from above) about 11-12s </div>
<div>&nbsp; kernel version: 2.6.17 (built from <a href="http://kernel.org">kernel.org</a>)&nbsp; about 11-12s</div>
<div>&nbsp; kernel version: 2.6.18: about&nbsp; 145s</div>
<div>&nbsp;&nbsp;kernel version: 2.6.18 with mh4 (built with the patch from bluez):&nbsp;&nbsp; 143s&nbsp; 146s</div>
<div>&nbsp;</div>
<div>Too terrible!!!</div></div>
<div>====================================</div>
<div><br>using other RFCOMM applications, 2.6.18 is slower too.<br>&nbsp;</div>
<div><span class="gmail_quote">2006/10/8, Marcel Holtmann &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:marcel@holtmann.org" target="_blank">marcel@holtmann.org</a>&gt;:</span> 
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>&gt;&nbsp;&nbsp; I have rebuilt the 2.6.17, the speed is good. so, I don't know why<br>&gt; 2.6.18 makes the RFCOMM socket communication slower. 
<br>&gt; Who can have a try to compare the speed using different kernel ?<br>&gt; Need your nice help. :)<br><br>do you have a nice and simple test program and some results of your<br>testing. I like to run it by myself.<br>
<br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your 
<br>opinions on IT &amp; business topics through brief surveys -- and earn cash<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV </a><br>_______________________________________________<br>Bluez-devel mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank">
Bluez-devel@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br></blockquote></div><br><br clear="all"><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu 

------=_Part_165931_29887188.1160362673490--


--===============0000204813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0000204813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0000204813==--
