Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <55cd79280604241614m5da5e078s6374f8218d834656@mail.gmail.com>
From: "Marcos P" <mparedesx@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Fwd: Help with l2cap broadcast programming
In-Reply-To: <444D0164.5000505@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_24743_15769528.1145920483316"
References: <55cd79280604231728s788eb97bi76e9998816181dd3@mail.gmail.com>
	 <55cd79280604240416m634b1aa7j27e2cabedbb81239@mail.gmail.com>
	 <444CF59F.5020003@xmission.com> <444CF957.6080203@xmission.com>
	 <444D0164.5000505@xmission.com>
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
Date: Tue, 25 Apr 2006 00:14:43 +0100

------=_Part_24743_15769528.1145920483316
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thank you Brad, for your answer.  I am not using AVDTP, we have our own
algorithm to deliver video. The video stream is sent by modifying the
packetization and delivery scheme. For example sending 1 video slice per
packet and delivering each packet with times closer to a Real time
streamming.  In this case the broadcast scheme in the bluetooth standard [*=
]
seems like a good way to stream video to different clients. In this case th=
e
clients performance will be observed at different distances, and because
they are only in a listening state and the broadcast delivery is not
dependant to the buffer in the client; it is a good case study to analyse
the degradation of service at different positions.



at this time, I was starting to analyse how to use raw sockets in HCI and
l2cap to see if I was able to activate the broadcast mode, however if the
broadcast support is not in the bluez stack shall I then move to the AFFIX
stack???

It is really a pity that the bluez  lacks the support for broadcast.  I
kindly like the TCP/IP sockets similarity of socket programming with bluez.



Regards Marcos




*
http://www.bluetooth.com/Bluetooth/Learn/Works/Data_Transport_Architecture.=
htm

On 4/24/06, Brad Midgley <bmidgley@xmission.com> wrote:
>
> Hey
>
> >>The core spec talks about broadcast... lt_addr is all 0, llid =3D 10, p=
tt
> >>=3D 0. I looked around for examples using bluez but couldn't find any.
>
> If bluez really can't do this now, you can get it using the affix stack.
> We just can't discuss affix here unless it's in the context of improving
> bluez.
>
> (There's a special place in hell reserved for replying to myself twice
> here :)
>
> Brad
>
>

------=_Part_24743_15769528.1145920483316
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



<p class=3D"MsoNormal"><span lang=3D"EN-GB">Thank you Brad, for your answer=
.<span style=3D"">&nbsp; </span>I am not using AVDTP, we have our own
algorithm to deliver video. The video stream is sent by modifying the packe=
tization and delivery scheme. For example sending 1 video
slice per packet and delivering each packet with times closer to a Real tim=
e streamming.<span style=3D"">&nbsp; </span>In this case the
broadcast scheme in the bluetooth standard [*] seems like a good way to str=
eam
video to different clients. In this case the clients performance will be ob=
served at different distances, and because they are only in a listening sta=
te and the broadcast delivery is not dependant to the buffer in the client;=
 it is a good case study to analyse the degradation of service at different=
 positions.
<br>
</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-GB">&nbsp;</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-GB">at this time, I was starting to=
 analyse how to use raw
sockets in HCI and l2cap to see if I was able to activate the broadcast mod=
e,
however if the broadcast support is not in the bluez stack shall I then mov=
e to
the AFFIX stack???</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-GB">It is really a pity that the bl=
uez <span style=3D"">&nbsp;</span>lacks the support for broadcast. <span st=
yle=3D"">&nbsp;</span>I kindly like the TCP/IP sockets similarity
of socket programming with bluez. </span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-GB"><span style=3D"">&nbsp;</span><=
span style=3D"">&nbsp;</span><span style=3D"">&nbsp;</span></span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-GB">Regards Marcos </span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-GB">&nbsp;</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-GB">&nbsp;</span></p>

<span style=3D"font-size: 12pt; font-family: &quot;Times New Roman&quot;;" =
lang=3D"EN-GB">*
<a href=3D"http://www.bluetooth.com/Bluetooth/Learn/Works/Data_Transport_Ar=
chitecture.htm">http://www.bluetooth.com/Bluetooth/Learn/Works/Data_Transpo=
rt_Architecture.htm</a></span><br><br><div><span class=3D"gmail_quote">On 4=
/24/06,=20
<b class=3D"gmail_sendername">Brad Midgley</b> &lt;<a href=3D"mailto:bmidgl=
ey@xmission.com">bmidgley@xmission.com</a>&gt; wrote:</span><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hey<br><br>&gt;&gt;The core spec talks about broadcast... lt_addr is all 0,=
 llid =3D 10, ptt<br>&gt;&gt;=3D 0. I looked around for examples using blue=
z but couldn't find any.<br><br>If bluez really can't do this now, you can =
get it using the affix stack.
<br>We just can't discuss affix here unless it's in the context of improvin=
g<br>bluez.<br><br>(There's a special place in hell reserved for replying t=
o myself twice<br>here :)<br><br>Brad<br><br></blockquote></div><br>

------=_Part_24743_15769528.1145920483316--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
