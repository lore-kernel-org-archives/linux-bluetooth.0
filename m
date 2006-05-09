Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <6297d67c0605082039jd29956bne749c08ef86fbfae@mail.gmail.com>
From: "Mayank Batra" <mayankbatra@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re:Advanced Audio Distribution Profile for BlueZ
In-Reply-To: <20060508153458.88001.qmail@web26908.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4330_32481693.1147145992665"
References: <20060508153458.88001.qmail@web26908.mail.ukl.yahoo.com>
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
Date: Tue, 9 May 2006 09:09:52 +0530

------=_Part_4330_32481693.1147145992665
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Javier,

I think that you did not read the page bluetooth-alsa.sf.net completely.
Both SCO and ACL implementations have been done.
Maybe you can add some new feature to the existing A2DP. (a2play or
pcm_a2dp).
I think support for the mp3 codec (making a choice at run time between SBC
and MP3 codec) could be handy.
Also, the A2DP spec mentions briefly about RTP. Nobody has looked into that
till now.

Regards
Mayank


On 5/8/06, javier labella <javi_labella@yahoo.es> wrote:
>
>
>
> Fecha: Wed, 3 May 2006 18:18:27 +0200 (CEST)
> De: javier labella <javi_labella@yahoo.es>
> Asunto: Re:Advanced Audio Distribution Profile for
> Bluez
> Para: bluez-devel@lists.sourceforge.net
>
> >We have implemented some a2dp already. See bluetooth-alsa.sf.net. There
> >is still plenty to do, if you want to help integrate it with gstreamer
> >for example.
>
> >I think it's not totally clear how the a2dp profile gets "integrated"
> >since it really looks more like a bluez client that belongs in one or
> >more multimedia frameworks.
>
> >Brad
>
>
> Hi,
> I've visited bluetooth-alsa.sf.net and the project is very interesting bu=
t
> I think that the profile's implementation is based on SCO channels. If I'=
m
> making a mistake I apologize for it. On the other hand, I've read the A2D=
P
> profile specification and I think that an implementation should uses ACL
> channels: "The Advanced Audio Distribution Profile (A2DP) defines the
> protocols and procedures that realize distribution of audio content of
> high-quality in mono or stereo on ACL channels (Introduction of Advanced
> Audio Distribution Profile Specification)" So I'd like to develop an
> implementation using ACL channels instead of SCO channels.
>
> I'd like to know if you're interested in include this implementation in
> the BlueZ stack too.
> Thanks.
>
>
> Javier.
>
>
>  ------------------------------
>
> LLama Gratis a cualquier PC del Mundo.
> Llamadas a fijos y m=F3viles desde 1 c=E9ntimo por minuto.
> http://es.voice.yahoo.com<http://us.rd.yahoo.com/mail/es/tagline/messenge=
r/*http://es.voice.yahoo.com/>
>
>

------=_Part_4330_32481693.1147145992665
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Javier,</div>
<div>&nbsp;</div>
<div>I think that you did not read the page <a onclick=3D"return top.js.Ope=
nExtLink(window,event,this)" href=3D"http://bluetooth-alsa.sf.net/" target=
=3D"_blank">bluetooth-alsa.sf.net</a>&nbsp;completely.</div>
<div>Both SCO and ACL implementations have been done.</div>
<div>Maybe&nbsp;you can add some new feature to the existing A2DP. (a2play =
or pcm_a2dp).</div>
<div>I think support for the mp3 codec (making a choice at run time between=
 SBC and MP3 codec) could be handy.</div>
<div>Also, the A2DP spec mentions briefly about RTP. Nobody has looked into=
 that till now.</div>
<div>&nbsp;</div>
<div>Regards</div>
<div>Mayank<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 5/8/06, <b class=3D"gmail_sendername">j=
avier labella</b> &lt;<a href=3D"mailto:javi_labella@yahoo.es">javi_labella=
@yahoo.es</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div><br><br>
<blockquote style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #101=
0ff 2px solid">Fecha: Wed, 3 May 2006 18:18:27 +0200 (CEST)<br>De: javier l=
abella &lt;<a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=
=3D"mailto:javi_labella@yahoo.es" target=3D"_blank">
javi_labella@yahoo.es</a>&gt;<br>Asunto: Re:Advanced Audio Distribution Pro=
file for <br>Bluez<br>Para: <a onclick=3D"return top.js.OpenExtLink(window,=
event,this)" href=3D"mailto:bluez-devel@lists.sourceforge.net" target=3D"_b=
lank">
bluez-devel@lists.sourceforge.net</a><br><br><pre><tt>&gt;We have implement=
ed some a2dp already. See <a onclick=3D"return top.js.OpenExtLink(window,ev=
ent,this)" href=3D"http://bluetooth-alsa.sf.net/" target=3D"_blank">bluetoo=
th-alsa.sf.net
</a>. There<br>&gt;is still plenty to do, if you want to help integrate it =
with gstreamer<br>&gt;for example.<br><br>&gt;I think it's not totally clea=
r how the a2dp profile gets &quot;integrated&quot;<br>&gt;since it really l=
ooks more like a bluez client that belongs in one or
<br>&gt;more multimedia frameworks.<br><br>&gt;Brad</tt></pre><br>Hi,<br>I'=
ve visited <a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=
=3D"http://bluetooth-alsa.sf.net/" target=3D"_blank">bluetooth-alsa.sf.net<=
/a>
 and the project is very interesting but I think that the profile's impleme=
ntation is based on SCO channels. If I'm making a mistake I apologize for i=
t. On the other hand, I've read the A2DP profile specification and I think =
that an implementation should uses ACL channels: &quot;The Advanced Audio D=
istribution Profile (A2DP) defines the protocols and procedures that realiz=
e distribution of audio content of high-quality in mono or stereo on ACL ch=
annels (Introduction of Advanced Audio Distribution Profile Specification)&=
quot; So I'd like to develop an implementation using ACL channels instead o=
f SCO channels.
<br><br>I'd like to know if you're interested in include this implementatio=
n in the BlueZ stack too.&nbsp; <br>Thanks.<br></blockquote></div>
<div><span class=3D"sg"><br>Javier.<br></span></div>
<div><span class=3D"ad">
<div></div></span></div>
<div>
<blockquote></blockquote></div>
<div><span class=3D"ad"><br>
<p>
<hr size=3D"1">
<br><font face=3D"Verdana" size=3D"-2">LLama Gratis a cualquier PC del Mund=
o.<br>Llamadas a fijos y m=F3viles desde 1 c=E9ntimo por minuto.<br><a oncl=
ick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"http://us.rd.y=
ahoo.com/mail/es/tagline/messenger/*http://es.voice.yahoo.com/" target=3D"_=
blank">
http://es.voice.yahoo.com</a></font>=20
<p></p></p></span></div></blockquote></div><br>

------=_Part_4330_32481693.1147145992665--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
