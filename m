Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20604060554h42e1b958i99a629c0cebf50ab@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: Re: [Bluez-devel] SCO transparent transmission
In-Reply-To: <9ec07a230604060110s7fa9c5fax46562d4fb0397543@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3817_27209309.1144328087584"
References: <9ec07a230604060110s7fa9c5fax46562d4fb0397543@mail.gmail.com>
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
Date: Thu, 6 Apr 2006 18:24:47 +0530

------=_Part_3817_27209309.1144328087584
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI....
How do i change it to PCM using hciconfig ?? I think as you said the defaul=
t
is CVSD... how can I change the voice setting from CVSD to PCM??

regards
Soumya

On 4/6/06, Israel Gu=EDo <israzar@gmail.com> wrote:
>
> Hi Sowmya.
>
> I don't use /dev/dsp to get audio samples. I use ALSA project library and
> it works (I suggest you should look for code samples about it, specially
> those regarding to headsets).
>
> CVSD is the default on-the-air coding for SCO packets but you can change
> it by means of "hciconfig".
>
> For SCO transmission, just open a socket as in scotest.c(bluez-utils/test=
) and use write and read on it.
>
> There is no documentation about BlueZ and, if you want to use it, you mus=
t
> read and undestand the code.
>
> Bye!
>
>
>
> >Hey Israel,
> >How did u use CVSD when transmitting over sco?? U mean u used some sort
> of
> >function to convert the voice you input from /dev/dsp into CVSD codec??
> >Can u also throw some light on CVSD and SCO... I mean how are u
> transmittin=3D
> >g
>
> >the packets over SCO??
>
> >Soumya
>

------=_Part_3817_27209309.1144328087584
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI.... <br>How do i change it to PCM using hciconfig ?? I think as you said=
 the default is CVSD... how can I change the voice setting from CVSD to PCM=
?? <br><br>regards<br>Soumya<br><br><div><span class=3D"gmail_quote">On 4/6=
/06,=20
<b class=3D"gmail_sendername">Israel Gu=EDo</b> &lt;<a href=3D"mailto:israz=
ar@gmail.com">israzar@gmail.com</a>&gt; wrote:</span><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
<div style=3D"direction: ltr;"><div>Hi Sowmya.</div>
<div>&nbsp;</div>
<div>I don't use /dev/dsp to get audio samples. I use ALSA project library =
and it works (I suggest you should look for code samples about it, speciall=
y those regarding to headsets). </div>
<div>&nbsp;</div>
<div>CVSD is the default on-the-air coding for SCO packets but you can chan=
ge it by means of &quot;hciconfig&quot;. </div>
<div>&nbsp;</div>
<div>For SCO transmission, just open a socket as in scotest.c (bluez-utils/=
test) and use write and read on it.</div>
<div>&nbsp;</div>
<div>There is no documentation about BlueZ and, if you want to use it, you =
must read and undestand the code.</div>
<div>&nbsp;</div>
<div>Bye!</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div></div><div style=3D"direction: ltr;"><span class=3D"q">&gt;Hey Israel,=
<br>&gt;How did u use CVSD when transmitting over sco?? U mean u used some =
sort of<br>&gt;function to convert the voice you input from /dev/dsp into C=
VSD codec??
<br></span></div><div style=3D"direction: ltr;">&gt;Can u also throw some l=
ight on CVSD and SCO... I mean how are u transmittin=3D
<br>&gt;g</div><div style=3D"direction: ltr;"><span class=3D"q"><br>&gt;the=
 packets over SCO??<br><br>&gt;Soumya</span></div><div style=3D"direction: =
ltr;"></div>

</div></blockquote></div><br>

------=_Part_3817_27209309.1144328087584--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
