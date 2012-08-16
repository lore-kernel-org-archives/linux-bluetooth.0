Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120815044111.GG3344@joana>
References: <1344757304-11555-1-git-send-email-7aborigines7@gmail.com> <20120815044111.GG3344@joana>
From: koko Aborigines <7aborigines7@gmail.com>
Date: Thu, 16 Aug 2012 10:12:44 +0700
Message-ID: <CA+iwHK1VYJ+G-9aVgkzvAV4C3Unhyz-sqC+_SkUmPhffs1_=CQ@mail.gmail.com>
Subject: Re: [PATCH] add support bluetooth usb 0489:e046 Foxconn / Hon Hai
To: Gustavo Padovan <gustavo@padovan.org>, aborigines <7aborigines7@gmail.com>, marcel@holtmann.org,
	padovan@profusion.mobi, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=f46d042f9f38fe835d04c7596b92
List-ID: <linux-bluetooth.vger.kernel.org>

--f46d042f9f38fe835d04c7596b92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, Gustavo

i have error with your patch

 CC [M]  drivers/bluetooth/btusb.o
drivers/bluetooth/btusb.c:113:2: error: implicit declaration of function
=E2=80=98USB_VENDOR_AND_INTERFACE_INFO=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
drivers/bluetooth/btusb.c:113:2: error: initializer element is not constant
drivers/bluetooth/btusb.c:113:2: error: (near initialization for
=E2=80=98btusb_table[22].match_flags=E2=80=99)


System : Debian Wheezy amd64

Thanks.

On Wed, Aug 15, 2012 at 11:41 AM, Gustavo Padovan <gustavo@padovan.org>wrot=
e:

> * aborigines <7aborigines7@gmail.com> [2012-08-12 14:41:44 +0700]:
>
> > $ usb-deveices
> > T: Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D02 Cnt=3D03 Dev#=3D 5 Spd=3D12 Mx=
Ch=3D 0
> > D: Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D 1
> > P: Vendor=3D0489 ProdID=3De046 Rev=3D01.12
> > S: Manufacturer=3DBroadcom Corp
> > S: Product=3DBCM20702A0
> > S: SerialNumber=3DC01885F67F9E
> > C: #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D0mA
> > I: If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3D(none)
> > I: If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3D(none)
> > I: If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Drive=
r=3D(none)
> > I: If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Drive=
r=3D(none)
> >
> > $ lsusb
> > Bus 001 Device 005: ID 0489:e046 Foxconn / Hon Hai
> > ---
> >  drivers/bluetooth/btusb.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index fc4bcd6..fb54c70 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -110,6 +110,7 @@ static struct usb_device_id btusb_table[] =3D {
> >
> >       /* Foxconn - Hon Hai */
> >       { USB_DEVICE(0x0489, 0xe033) },
> > +     { USB_DEVICE(0x0489, 0xe046) },
> >
> >       { }     /* Terminating entry */
> >  };
>
> Can you try the following patch and see if it works for you.
>
>         Gustavo
>
> ---
> commit 8d2952f43af434f0aa5d109a9ae50c5886a9322c (HEAD, master)
> Author: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> Date:   Wed Aug 15 01:38:11 2012 -0300
>
>     Bluetooth: Add USB_VENDOR_AND_INTERFACE_INFO() for Broadcom/Foxconn
>
>     Foxconn devices has a vendor specific class of device, we will match
> them
>     differently now.
>
>     Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f637c25..f077f4d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -101,7 +101,7 @@ static struct usb_device_id btusb_table[] =3D {
>         { USB_DEVICE(0x413c, 0x8197) },
>
>         /* Foxconn - Hon Hai */
> -       { USB_DEVICE(0x0489, 0xe033) },
> +       { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
>
>         { }     /* Terminating entry */
>  };
>
>

--f46d042f9f38fe835d04c7596b92
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, Gustavo<br><br>i have error with your patch<br><br>=C2=A0CC [M]=C2=A0 d=
rivers/bluetooth/btusb.o<br>drivers/bluetooth/btusb.c:113:2: error: implici=
t declaration of function =E2=80=98USB_VENDOR_AND_INTERFACE_INFO=E2=80=99 [=
-Werror=3Dimplicit-function-declaration]<br>

drivers/bluetooth/btusb.c:113:2: error: initializer element is not constant=
<br>drivers/bluetooth/btusb.c:113:2: error: (near initialization for =E2=80=
=98btusb_table[22].match_flags=E2=80=99)<br><br><br>System : Debian Wheezy =
amd64<br><br>

Thanks.<br><br><div class=3D"gmail_quote">On Wed, Aug 15, 2012 at 11:41 AM,=
 Gustavo Padovan <span dir=3D"ltr">&lt;<a href=3D"mailto:gustavo@padovan.or=
g" target=3D"_blank">gustavo@padovan.org</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">

* aborigines &lt;<a href=3D"mailto:7aborigines7@gmail.com">7aborigines7@gma=
il.com</a>&gt; [2012-08-12 14:41:44 +0700]:<br>
<div><div class=3D"h5"><br>
&gt; $ usb-deveices<br>
&gt; T: Bus=3D01 Lev=3D02 Prnt=3D02 Port=3D02 Cnt=3D03 Dev#=3D 5 Spd=3D12 M=
xCh=3D 0<br>
&gt; D: Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D 1=
<br>
&gt; P: Vendor=3D0489 ProdID=3De046 Rev=3D01.12<br>
&gt; S: Manufacturer=3DBroadcom Corp<br>
&gt; S: Product=3DBCM20702A0<br>
&gt; S: SerialNumber=3DC01885F67F9E<br>
&gt; C: #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D0mA<br>
&gt; I: If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driv=
er=3D(none)<br>
&gt; I: If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driv=
er=3D(none)<br>
&gt; I: If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driv=
er=3D(none)<br>
&gt; I: If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Driv=
er=3D(none)<br>
&gt;<br>
&gt; $ lsusb<br>
&gt; Bus 001 Device 005: ID 0489:e046 Foxconn / Hon Hai<br>
&gt; ---<br>
&gt; =C2=A0drivers/bluetooth/btusb.c | =C2=A0 =C2=A01 +<br>
&gt; =C2=A01 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c<br>
&gt; index fc4bcd6..fb54c70 100644<br>
&gt; --- a/drivers/bluetooth/btusb.c<br>
&gt; +++ b/drivers/bluetooth/btusb.c<br>
&gt; @@ -110,6 +110,7 @@ static struct usb_device_id btusb_table[] =3D {<br=
>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 /* Foxconn - Hon Hai */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 { USB_DEVICE(0x0489, 0xe033) },<br>
&gt; + =C2=A0 =C2=A0 { USB_DEVICE(0x0489, 0xe046) },<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 { } =C2=A0 =C2=A0 /* Terminating entry */<br>
&gt; =C2=A0};<br>
<br>
</div></div>Can you try the following patch and see if it works for you.<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Gustavo<br>
<br>
---<br>
commit 8d2952f43af434f0aa5d109a9ae50c5886a9322c (HEAD, master)<br>
Author: Gustavo Padovan &lt;<a href=3D"mailto:gustavo.padovan@collabora.co.=
uk">gustavo.padovan@collabora.co.uk</a>&gt;<br>
Date: =C2=A0 Wed Aug 15 01:38:11 2012 -0300<br>
<br>
=C2=A0 =C2=A0 Bluetooth: Add USB_VENDOR_AND_INTERFACE_INFO() for Broadcom/F=
oxconn<br>
<br>
=C2=A0 =C2=A0 Foxconn devices has a vendor specific class of device, we wil=
l match them<br>
=C2=A0 =C2=A0 differently now.<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Gustavo Padovan &lt;<a href=3D"mailto:gustavo.=
padovan@collabora.co.uk">gustavo.padovan@collabora.co.uk</a>&gt;<br>
<br>
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c<br>
index f637c25..f077f4d 100644<br>
--- a/drivers/bluetooth/btusb.c<br>
+++ b/drivers/bluetooth/btusb.c<br>
@@ -101,7 +101,7 @@ static struct usb_device_id btusb_table[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { USB_DEVICE(0x413c, 0x8197) },<br>
<div class=3D"im"><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Foxconn - Hon Hai */<br>
</div>- =C2=A0 =C2=A0 =C2=A0 { USB_DEVICE(0x0489, 0xe033) },<br>
+ =C2=A0 =C2=A0 =C2=A0 { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, =
0x01) },<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { } =C2=A0 =C2=A0 /* Terminating entry */<br>
=C2=A0};<br>
<br>
</blockquote></div><br>

--f46d042f9f38fe835d04c7596b92--
