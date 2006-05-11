Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <6297d67c0605102037p3c89755er906dce79e8ca61c@mail.gmail.com>
From: "Mayank Batra" <mayankbatra@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP and VDP for BlueZ
In-Reply-To: <20060510151310.29728.qmail@web26907.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_33719_30008293.1147318638104"
References: <20060510151310.29728.qmail@web26907.mail.ukl.yahoo.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 11 May 2006 09:07:18 +0530

------=_Part_33719_30008293.1147318638104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Javier,


> >Thank you very much for your comments. I was wrong. I've already seen th=
e
> A2DP's implementation over ACL channels in the page >bluetooth-alsa.sf.ne=
t<http://bluetooth-alsa.sf.net/>
> .
>
> >On the other hand, I'd like to know if you had studied the Video
> Distribution Profile (VDP). At first, my objetives were to develop the
>
 >A2DP or, if it was already implemented, the VDP. Therefore, I'm
> interested in knowing if you have implemented something similar to >a2pla=
y
> for A2DP.
>
>

VDP also makes use of AVDTP, thus it is pretty much the same, protocol wise=
.
So connection establishment in case of 'vplay' / 'vrecv' should be more or
less the same as in a2play/a2recv.
Only difference might be the sink capabilities.
So you'll only have to read stuff about the H.263 codec.
To begin with you can directly send the encoded file and later on try
encoding video taken from a webcam to h.263 and then stream.

Mayank

------=_Part_33719_30008293.1147318638104
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Javier,<br><br>
<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div>&nbsp;</div>
<div>&gt;Thank you very much for your comments. I was&nbsp;wrong. I've alre=
ady seen the A2DP's implementation over ACL&nbsp;channels in&nbsp;the page =
<a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"http://=
bluetooth-alsa.sf.net/" target=3D"_blank">
&gt;bluetooth-alsa.sf.net</a>.</div>
<div>&nbsp;</div>
<div>&gt;On the other hand, I'd like to know if you had studied the Video D=
istribution Profile (VDP). At first, my objetives were to develop the</div>=
</div></blockquote>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div>&gt;A2DP or, if it&nbsp;was already implemented, the&nbsp;VDP. Therefo=
re, I'm interested&nbsp;in knowing if you have&nbsp;implemented something s=
imilar to &gt;a2play for A2DP.</div>
<div>&nbsp;</div></div></blockquote>
<div>&nbsp;</div>
<div>VDP also makes use of AVDTP, thus it is pretty much the same, protocol=
 wise.</div>
<div>So connection establishment in case of 'vplay' / 'vrecv' should be mor=
e or less the same as in a2play/a2recv.</div>
<div>Only difference might be the sink capabilities.</div>
<div>So you'll only have to read stuff about the H.263 codec.</div>
<div>To begin with you can directly send the encoded file and later on try =
encoding video taken from a webcam to h.263 and then stream.</div>
<div>&nbsp;</div>
<div>Mayank</div><br>&nbsp;</div>

------=_Part_33719_30008293.1147318638104--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
