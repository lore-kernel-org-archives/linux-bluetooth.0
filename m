Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e29894ca0705240928m65c9999as6e2380c95610e457@mail.gmail.com>
Date: Thu, 24 May 2007 19:28:56 +0300
From: "=?ISO-8859-1?Q?Marc-Andr=E9_Lureau?=" <marcandre.lureau@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300705240624u15df9655gb9624e0955d6d195@mail.gmail.com>
MIME-Version: 1.0
References: <200705170207.52710.bluez-devel@huitl.de>
	<d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>
	<200705171521.38889.bluez-devel@huitl.de>
	<d89ddf300705240624u15df9655gb9624e0955d6d195@mail.gmail.com>
Subject: Re: [Bluez-devel] headsetd has problems serving two applications at
	a time
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0768978729=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0768978729==
Content-Type: multipart/alternative;
	boundary="----=_Part_21896_16555155.1180024136042"

------=_Part_21896_16555155.1180024136042
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

dmix and dsnoop requires hw interrupts. Thats why they are bundled inside
alsa-lib and not in alsa-plugins. If you want to do dmx or dsnoop stuff, yo=
u
should definetly have a look at PulseAudio as Brad suggested. Not however
that PulseAudio require NON_BLOCKING alsa pcm. I am unsure about the sco
alsa plugin support for NON_BLOCKING mode. Maybe Brad could comment.

my 2cents,

--=20
Marc-Andr=E9 Lureau, GSmartMix

On 5/24/07, Brad Midgley <bmidgley@gmail.com> wrote:
>
> Robert
>
> > Could it be that some of the ALSA plugins only work with hardware
> > devices?!
>
>
> that is a real possibility. libalsa plugins are definitely second-class.
>
> i am searching around in headsetd to see if it restricts the mic and
> speaker sockets to be sent to the same application. it should be easy eno=
ugh
> to keep track of these two independently.
>
> Brad
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net<https://mail.google.com/mail?view=3Dcm&=
tf=3D0&to=3DBluez-devel@lists.sourceforge.net>
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

------=_Part_21896_16555155.1180024136042
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br>dmix and dsnoop requires hw interrupts. Thats why they are bundl=
ed inside alsa-lib and not in alsa-plugins. If you want to do dmx or dsnoop=
 stuff, you should definetly have a look at PulseAudio as Brad suggested. N=
ot however that PulseAudio require NON_BLOCKING alsa pcm. I am unsure about=
 the sco alsa plugin support for NON_BLOCKING mode. Maybe Brad could commen=
t.
<br><br clear=3D"all">my 2cents,<br><br>-- <br>Marc-Andr=E9 Lureau, GSmartM=
ix
<br><br><div><span class=3D"gmail_quote">On 5/24/07, <b class=3D"gmail_send=
ername">Brad Midgley</b> &lt;<a href=3D"mailto:bmidgley@gmail.com">bmidgley=
@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
<b class=3D"gmail_sendername">Robert </b><div><span class=3D"q"><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Could it be t=
hat some of the ALSA plugins only work with hardware devices?!
</blockquote></span><div><br>that is a real possibility. libalsa plugins ar=
e definitely second-class.<br><br>i am searching around in headsetd to see =
if it restricts the mic and speaker sockets to be sent to the same applicat=
ion. it should be easy enough to keep track of these two independently.
<br><br>Brad<br></div><br></div><br>
<br>-----------------------------------------------------------------------=
--<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express=
 C - the FREE version of DB2 express and take<br>control of your XML. No li=
mits. Just data. Click to get it now.
<br><a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"htt=
p://sourceforge.net/powerbar/db2/" target=3D"_blank">http://sourceforge.net=
/powerbar/db2/</a><br>_______________________________________________<br>Bl=
uez-devel mailing list
<br><a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"htt=
ps://mail.google.com/mail?view=3Dcm&amp;tf=3D0&amp;to=3DBluez-devel@lists.s=
ourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a onclick=3D"retu=
rn top.js.OpenExtLink(window,event,this)" href=3D"https://lists.sourceforge=
.net/lists/listinfo/bluez-devel" target=3D"_blank">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br></block=
quote></div><br>

------=_Part_21896_16555155.1180024136042--


--===============0768978729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0768978729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0768978729==--
