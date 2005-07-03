Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c93f2a2905070219331de8b1a0@mail.gmail.com>
From: Embedded System <embed.sys@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HCID problem? (Help)
In-Reply-To: <1120315516.10273.0.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1558_25761435.1120358022432"
References: <c93f2a29050702074045ad46dd@mail.gmail.com>
	 <1120315516.10273.0.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 3 Jul 2005 02:33:42 +0000

------=_Part_1558_25761435.1120358022432
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi, Marcel

I am using arm-linux 2.4.27-vsr1 from atmel, and libs&utils I am using the=
=20
latest 2.17 version. The kernel version is hard to change. I just think=20
hcidump should also report the command status after inquire suceed. And=20
since from the hcidump output, the inquire has already suceeded, the hcitoo=
l=20
output should print the inquire result, but not"Inquiry failed.: Connection=
=20
timed out".

Below is more information:=20
1. I tried "hcitool inq", "hcitool scan", sdptool and l2ping, only l2ping=
=20
outputs correctly.
2. If I don't run hcidump, my Nokia 7650 can connect to the arm box via=20
Serial Profile every two times, but if I run hcidump, it can never connect=
=20
succefully.
3. Among two data sendings from Nokia to arm box, one succeed, one failed=
=20
(no data output from hcidump)
4. After about 5 times data sending from arm box to Nokia, it does not send=
=20
back data to Nokia any more, and also at that time no more output from=20
hcidump.

Everything seems to work perfectly between my linux PC and Nokia 7650.

Could you please give me more infomation for my next hacking? Thanks a lot!

If you need any information, please let me know. Looking forward to your=20
reply!

Regards,
Andy
On 7/2/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Andy,
>=20
> > HCI command do not complete after "inquiure request" completed
> > succesfully.
> >
> > I run "hcitool inq" & "hcidum", the output is as following:
> >
> > HCIDump - HCI packet analyzer ver 1.16
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > < HCI Command: Inquiry (0x01|0x0001) plen 5
> > 33 8B 9E 08 00
> > > HCI Event: Command Status (0x0f) plen 4
> > 00 01 01 04
> > > HCI Event: Inquiry Result (0x02) plen 15
> > 01 91 DC AC EE 02 00 01 00 00 04 22 50 C5 57
> > > HCI Event: Inquiry Complete (0x01) plen 1
> > 00
> >
> > (based on the packet dump, the inquery is succesful, and hcid should
> > complete), but hcitool output is:
> > Inquiring ...
> > Inquiry failed.: Connection timed out
> >
> > Is it a HCID problem? How can I fix it? I thought it will also cause
> > packet lost & program hang.
>=20
> what kernel and libs/utils are you using. And what do you think has hcid
> to do with an inquiry?
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net <http://SF.Net> email is sponsored by: Discover Easy Linux=20
> Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_1558_25761435.1120358022432
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi, Marcel<br>
<br>
I am using arm-linux 2.4.27-vsr1 from atmel, and libs&amp;utils I am
using the latest 2.17 version. The kernel version is hard to change. I
just think hcidump should also report the command status after inquire
suceed. And since from the hcidump output, the inquire has already
suceeded, the hcitool output should print the inquire result, but
not&quot;Inquiry failed.: Connection timed out&quot;.<br>
<br>
Below is more information: <br>
1. I tried &quot;hcitool inq&quot;, &quot;hcitool scan&quot;, sdptool and l=
2ping, only l2ping outputs correctly.<br>
2. If I don't run hcidump, my Nokia 7650 can connect to the arm box via
Serial Profile every two times, but if I run hcidump, it can never
connect succefully.<br>
3. Among two data sendings from Nokia to arm box,&nbsp; one succeed, one fa=
iled (no data output from hcidump)<br>
4. After about 5 times data sending from arm box to Nokia, it does not
send back data to Nokia any more, and also at that time no more output
from hcidump.<br>
<br>
Everything seems to work perfectly between my linux PC and Nokia 7650.<br>
<br>
Could you please give me more infomation for my next hacking? Thanks a lot!=
<br>
<br>
If you need any information, please let me know. Looking forward to your re=
ply!<br>
<br>
Regards,<br>
Andy<br><div><span class=3D"gmail_quote">On 7/2/05, <b class=3D"gmail_sende=
rname">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marce=
l@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Hi Andy,<br><br>&gt; HCI command do not complete after &quot;inquiure reque=
st&quot; completed<br>&gt; succesfully.<br>&gt;<br>&gt; I run &quot;hcitool=
 inq&quot; &amp; &quot;hcidum&quot;, the output is as following:<br>&gt;
<br>&gt; HCIDump - HCI packet analyzer ver 1.16<br>&gt; device: hci0 snap_l=
en: 1028 filter: 0xffffffff<br>&gt; &lt; HCI Command: Inquiry (0x01|0x0001)=
 plen 5<br>&gt;&nbsp;&nbsp; 33 8B 9E 08 00<br>&gt; &gt; HCI Event: Command =
Status (0x0f) plen 4
<br>&gt;&nbsp;&nbsp; 00 01 01 04<br>&gt; &gt; HCI Event: Inquiry Result (0x=
02) plen 15<br>&gt;&nbsp;&nbsp; 01 91 DC AC EE 02 00 01 00 00 04 22 50 C5 5=
7<br>&gt; &gt; HCI Event: Inquiry Complete (0x01) plen 1<br>&gt;&nbsp;&nbsp=
; 00<br>&gt;<br>&gt; (based on the packet dump, the inquery is succesful, a=
nd hcid should
<br>&gt; complete), but hcitool output is:<br>&gt; Inquiring ...<br>&gt; In=
quiry failed.: Connection timed out<br>&gt;<br>&gt; Is it a HCID problem? H=
ow can I fix it? I thought it will also cause<br>&gt; packet lost &amp; pro=
gram hang.
<br><br>what kernel and libs/utils are you using. And what do you think has=
 hcid<br>to do with an inquiry?<br><br>Regards<br><br>Marcel<br><br><br><br=
><br>-------------------------------------------------------<br><a href=3D"=
http://SF.Net">
SF.Net</a> email is sponsored by: Discover Easy Linux Migration Strategies<=
br>from IBM. Find simple to follow Roadmaps, straightforward articles,<br>i=
nformative Webcasts and more! Get everything you need to get up to<br>speed=
, fast.=20
<a href=3D"http://ads.osdn.com/?ad_id=3D7477&amp;alloc_id=3D16492&amp;op=3D=
click">http://ads.osdn.com/?ad_id=3D7477&amp;alloc_id=3D16492&amp;op=3Dclic=
k</a><br>_______________________________________________<br>Bluez-users mai=
ling list<br>
<a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sour=
ceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/=
bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><b=
r>
</blockquote></div><br>

------=_Part_1558_25761435.1120358022432--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
