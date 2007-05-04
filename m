Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <22b6c3510705032158m535caf05n7da9af356700bd7a@mail.gmail.com>
Date: Fri, 4 May 2007 12:58:33 +0800
From: "Benjamin Fong" <benjamin.backup@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4639D5E2.3090703@gmail.com>
MIME-Version: 1.0
References: <22b6c3510704292334q49fbce17s5f07f564bf38098f@mail.gmail.com>
	<1ab01fb50705012238j36bd3f96u8baccf9bf4eb3ee1@mail.gmail.com>
	<22b6c3510705022305s522c254fy511ee6e9db90c44c@mail.gmail.com>
	<4639D350.2020606@gmail.com>
	<2EB6297382462046A9427D7324788A4801D5E78A@MCLNEXVS06.resource.ds.bah.com>
	<4639D5E2.3090703@gmail.com>
Subject: Re: [Bluez-devel] finding the least busy hci device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1997320176=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1997320176==
Content-Type: multipart/alternative;
	boundary="----=_Part_49195_18370628.1178254713885"

------=_Part_49195_18370628.1178254713885
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm afraid the logic we'd both employed is pretty identical. Instead of
using bash script, I've a method within my obex application which will
iteratively examine each hci device and return the first hci device which
has less than X amount of connected device to it.


static int is_dev_available(int dev_id)
{
 struct hci_conn_list_req *cl;
 struct hci_conn_info *ci;

 if (!(cl =3D malloc(10 * sizeof(*ci) + sizeof(*cl)))) {
  printf("Can't allocate memory");
  exit(1);
 }

 cl->dev_id =3D dev_id;
 cl->conn_num =3D 10;
 ci =3D cl->conn_info;

 if (ioctl(-1, HCIGETCONNLIST, (void *) cl)) {
  printf("Can't get connection list");
  exit(1);
 }

 if ( cl->conn_num <=3D 5 )
 {
  return 1;
 }

 return 0;
}

I've set the maximum allowed connection per dongle to 5 because of hardware
limitation, is there any other way which I can inquire the maximum allowed
connection per hci device via codes instead of using a magic number? Thanks



Regards,

Ben




On 5/3/07, Manuel Naranjo <naranjo.manuel@gmail.com> wrote:
>
> Williams, Richard escribi=F3:
> > I think the solution is pretty simple, and is done entirely at the
> > application level. I wrote an app that uses multiple dongles, for HCI
> > commands, SDP and OBEX. I have an array of hci control objects that I
> > "alloc" and "free" just as you would any other shared resource.
> >
> > Whenever I need to do a BT operation, the app goes to the pool of HCI
> > devices and requests one with "hci_alloc()". If one is free, that "hciX=
"
> > is returned. If none is free, then NULL is returned. When the app is
> > done with the operation, I do an "hci_free()".
> >
> That's what I'm doing so far, I'm doing it all from a bash script, I
> keep the count of hci dongles I have and then open one connection one
> per hci. And I count how many hci connections each hci has.
> But that's not the best for sure.
> Thanks,
> Manuel
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_49195_18370628.1178254713885
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>I&#39;m afraid the logic we&#39;d both employed is pretty identical. I=
nstead of using bash script, I&#39;ve a method within my obex application w=
hich will iteratively examine each hci device and return the first hci devi=
ce which has less than X amount of connected device to it.
</div>
<div>&nbsp;</div>
<div>
<p>static int is_dev_available(int dev_id)<br>{<br>&nbsp;struct hci_conn_li=
st_req *cl;<br>&nbsp;struct hci_conn_info *ci;</p>
<p>&nbsp;if (!(cl =3D malloc(10 * sizeof(*ci) + sizeof(*cl)))) {<br>&nbsp;&=
nbsp;printf(&quot;Can&#39;t allocate memory&quot;);<br>&nbsp;&nbsp;exit(1);=
<br>&nbsp;}<br>&nbsp;<br>&nbsp;cl-&gt;dev_id =3D dev_id;<br>&nbsp;cl-&gt;co=
nn_num =3D 10;<br>&nbsp;ci =3D cl-&gt;conn_info;</p>
<p>&nbsp;if (ioctl(-1, HCIGETCONNLIST, (void *) cl)) {<br>&nbsp;&nbsp;print=
f(&quot;Can&#39;t get connection list&quot;);<br>&nbsp;&nbsp;exit(1);<br>&n=
bsp;}<br>&nbsp;<br>&nbsp;if ( cl-&gt;conn_num &lt;=3D 5 )<br>&nbsp;{<br>&nb=
sp;&nbsp;return 1;<br>&nbsp;}</p>
<p>&nbsp;return 0;<br>}</p>
<p>I&#39;ve set the maximum allowed connection per dongle to 5 because of h=
ardware limitation, is there any other way which I can inquire the maximum =
allowed connection per hci device via codes instead of using a magic number=
? Thanks
</p>
<p>&nbsp;</p>
<p>Regards,</p>
<p>Ben</p></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 5/3/07, <b class=3D"gmail_sendername">M=
anuel Naranjo</b> &lt;<a href=3D"mailto:naranjo.manuel@gmail.com">naranjo.m=
anuel@gmail.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Williams, Richard escribi=F3:<br=
>&gt; I think the solution is pretty simple, and is done entirely at the<br=
>
&gt; application level. I wrote an app that uses multiple dongles, for HCI<=
br>&gt; commands, SDP and OBEX. I have an array of hci control objects that=
 I<br>&gt; &quot;alloc&quot; and &quot;free&quot; just as you would any oth=
er shared resource.
<br>&gt;<br>&gt; Whenever I need to do a BT operation, the app goes to the =
pool of HCI<br>&gt; devices and requests one with &quot;hci_alloc()&quot;. =
If one is free, that &quot;hciX&quot;<br>&gt; is returned. If none is free,=
 then NULL is returned. When the app is
<br>&gt; done with the operation, I do an &quot;hci_free()&quot;.<br>&gt;<b=
r>That&#39;s what I&#39;m doing so far, I&#39;m doing it all from a bash sc=
ript, I<br>keep the count of hci dongles I have and then open one connectio=
n one
<br>per hci. And I count how many hci connections each hci has.<br>But that=
&#39;s not the best for sure.<br>Thanks,<br>Manuel<br><br><br>-------------=
------------------------------------------------------------<br>This SF.net
 email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE ver=
sion of DB2 express and take<br>control of your XML. No limits. Just data. =
Click to get it now.<br><a href=3D"http://sourceforge.net/powerbar/db2/">
http://sourceforge.net/powerbar/db2/</a><br>_______________________________=
________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-dev=
el@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=
=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>

------=_Part_49195_18370628.1178254713885--


--===============1997320176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1997320176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1997320176==--
