Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20609270053o46cb0ebapaca698778f277c9b@mail.gmail.com>
Date: Wed, 27 Sep 2006 15:53:01 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1159304948.800.39.camel@localhost>
MIME-Version: 1.0
References: <3f5a9ba20609132122ue951876kcdfaacae30110f66@mail.gmail.com>
	<Pine.LNX.4.63.0609141101160.22339@redbean.intranet.gw-instruments.de>
	<450940DC.5080809@infitsrl.com>
	<Pine.LNX.4.63.0609141354070.22339@redbean.intranet.gw-instruments.de>
	<45094871.7010003@infitsrl.com>
	<Pine.LNX.4.63.0609141423350.22339@redbean.intranet.gw-instruments.de>
	<1158313465.5233.3.camel@localhost>
	<1159304948.800.39.camel@localhost>
Subject: Re: [Bluez-devel] About concurrency sdp_connect
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1869689503=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1869689503==
Content-Type: multipart/alternative;
	boundary="----=_Part_23173_15082219.1159343581618"

------=_Part_23173_15082219.1159343581618
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

holtman,
  I have test the pathc on 2.6.18-mh3
  When I use the dongle(bluetooth spec. 1.2), it seemed ok.
  but for the dongle (bluetooth spec. 1.1), it wasn't useful.


2006/9/27, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Peter,
>
> > my last attempt to make this work actually failed, but I didn't put much
> > energy into it. Feel free to come up with a working version. The path
> > how to handle this is clear.
>
> forget whatever I told you to handle this inside L2CAP. It is nearly
> impossible to get the locking for this right. I crashed my Quad G5
> multiple times today.
>
> So I went back to fix this inside the HCI layer. You can apply the
> attached patch on top of 2.6.18-mh3 and it should give you concurrent
> connect support for all protocols.
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
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>
>


-- 
With respects,
   Mingfan.Lu

------=_Part_23173_15082219.1159343581618
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>holtman, </div>
<div>&nbsp; I have test the pathc on 2.6.18-mh3</div>
<div>&nbsp;&nbsp;When I use the dongle(bluetooth spec. 1.2), it seemed ok.</div>
<div>&nbsp; but for the dongle (bluetooth spec. 1.1), it&nbsp;wasn't useful.</div>
<div>&nbsp;<br>&nbsp;</div>
<div><span class="gmail_quote">2006/9/27, Marcel Holtmann &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:marcel@holtmann.org" target="_blank">marcel@holtmann.org</a>&gt;:</span> 
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Peter,<br><br>&gt; my last attempt to make this work actually failed, but I didn't put much<br>&gt; energy into it. Feel free to come up with a working version. The path 
<br>&gt; how to handle this is clear.<br><br>forget whatever I told you to handle this inside L2CAP. It is nearly<br>impossible to get the locking for this right. I crashed my Quad G5<br>multiple times today.<br><br>So I went back to fix this inside the HCI layer. You can apply the 
<br>attached patch on top of 2.6.18-mh3 and it should give you concurrent<br>connect support for all protocols.<br><br>Regards<br><br>Marcel<br><br><br><br>------------------------------------------------------------------------- 
<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys -- and earn cash<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br><br>_______________________________________________<br>Bluez-devel mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank">
Bluez-devel@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br><br><br><br></blockquote></div><br><br clear="all"><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu 

------=_Part_23173_15082219.1159343581618--


--===============1869689503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1869689503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1869689503==--
