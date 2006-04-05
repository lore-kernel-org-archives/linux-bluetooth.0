Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20604042219s80d0c52hf12a96bb7f29a345@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Service Classes-unspecified....
In-Reply-To: <6297d67c0604040645s3e26f3a0x84c4b2cac1e42217@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12148_32293331.1144214356352"
References: <fe0a97c20603270203k53b20d7cx6be47e19c8d1f253@mail.gmail.com>
	 <fe0a97c20604040600k105581f1i96aa8334894218a@mail.gmail.com>
	 <6297d67c0604040645s3e26f3a0x84c4b2cac1e42217@mail.gmail.com>
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
Date: Wed, 5 Apr 2006 10:49:16 +0530

------=_Part_12148_32293331.1144214356352
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

No luck Mayank... I have installed knoppix into harddisk... (hd install)
any incompatibilities with Debian platform like this??

initially it was I had Red hat in my hard disk... and I used to get atleast
3 service classes like Networkin rendering and capturing... and when I
installed knoppix in hd... Iam facin this problem...

Am I the only specimen who is facin this problem or what??

On 4/4/06, Mayank Batra <mayankbatra@gmail.com> wrote:
>
> Sowmya,
>
> Can you try restarting the whole process i.e. remove all bluez modules,
> kill hcid and sdpd, remove your bluetooth adapter and reinsert it.
> Now insert all modules and start hcid and sdpd.
>
> Mayank
>
>
> On 4/4/06, Sowmya Gattupalli <sowmya.gattupalli@gmail.com> wrote:
> >
> >
> >
> > Guys I think mine is a lil peculiar problem,,,, hope to get a solution
> > for here,.....
> >
> > Initially when I was running the knoppix live CD.... my "hcicongig -a".
> > had all the service classes including Networking,Rendering,Capturing an=
d
> > Audio... I was delighted... but now it shows in this way!!
> >
> > (and I didn't even change hcid.conf)
> > root@bluetooth:~# hciconfig -a
> > hci0:   Type: USB
> >         BD Address: 00:09:DD:10:00:CC ACL MTU: 192:8  SCO MTU: 64:8
> >         UP RUNNING PSCAN ISCAN
> >         RX bytes:63 acl:0 sco:0 events:7 errors:0
> >         TX bytes:27 acl:0 sco:0 commands:7 errors:0
> >         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> >         Link policy:
> >         Link mode: SLAVE ACCEPT
> >         Name: 'Soumya-0'
> >         Class: 0x000100
> >         Service Classes: Unspecified
> >         Device Class: Computer, Uncategorized
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver=
:
> > 0x175
> >         Manufacturer: Cambridge Silicon Radio (10)
> >
> >
> > How come are my Service classes "unspecified" ??
> > ne ideas??
> >
> >
>
>

------=_Part_12148_32293331.1144214356352
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

No luck Mayank... I have installed knoppix into harddisk... (hd install) <b=
r>any incompatibilities with Debian platform like this?? <br><br>initially =
it was I had Red hat in my hard disk... and I used to get atleast 3 service=
 classes like Networkin rendering and capturing... and when I installed kno=
ppix in hd... Iam facin this problem...=20
<br><br>Am I the only specimen who is facin this problem or what??<br><br><=
div><span class=3D"gmail_quote">On 4/4/06, <b class=3D"gmail_sendername">Ma=
yank Batra</b> &lt;<a href=3D"mailto:mayankbatra@gmail.com">mayankbatra@gma=
il.com
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;"><div style=3D"direction: ltr;"><div>Sowmya,</div>
<div>&nbsp;</div>
<div>Can you try restarting the whole process i.e. remove all bluez modules=
, kill hcid and sdpd, remove your bluetooth adapter and reinsert it.</div>
<div>Now insert all modules and start hcid and sdpd.</div></div><div style=
=3D"direction: ltr;"><span class=3D"sg">
<div>&nbsp;</div>
<div>Mayank<br><br>&nbsp;</div></span></div><div style=3D"direction: ltr;">=
<span class=3D"e" id=3D"q_10a65274533a100c_2">
<div><span class=3D"gmail_quote">On 4/4/06, <b class=3D"gmail_sendername">S=
owmya Gattupalli</b> &lt;<a href=3D"mailto:sowmya.gattupalli@gmail.com" tar=
get=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">sow=
mya.gattupalli@gmail.com
</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0px 0px 0px 0.8ex; padding-left: 1ex;">
<div style=3D"direction: ltr;"><br><span class=3D"gmail_quote"><br></span>
<div style=3D"direction: ltr;">Guys I think mine is a lil peculiar problem,=
,,, hope to get a solution for here,..... <br><br>Initially when I was runn=
ing the knoppix live CD.... my &quot;hcicongig -a&quot;. had all the servic=
e classes including Networking,Rendering,Capturing and Audio... I was delig=
hted... but now it shows in this way!!=20
<br><br>(and I didn't even change hcid.conf)<br>root@bluetooth:~# hciconfig=
 -a<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; BD Address: 00:09:DD:10:00:CC ACL MTU: 192:8&nbsp; SCO MTU: 64:8<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:63 acl:0 sco:0 events:7 errors=
:0=20
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:27 acl:0 sco:0 comm=
ands:7 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xf=
f 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; Link mode: SLAVE ACCEPT=20
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'Soumya-0'<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000100<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1=
.1 (0x1) LMP Subver: 0x175=20
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Sili=
con Radio (10)<br><br><br>How come are my Service classes &quot;unspecified=
&quot; ?? <br>ne ideas??<br>&nbsp;</div></div></blockquote></div><br>

</span></div></blockquote></div><br>

------=_Part_12148_32293331.1144214356352--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
