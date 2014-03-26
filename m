Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0154F030-52BE-4935-8150-1A96737E7413@holtmann.org>
References: <1395815788-24666-1-git-send-email-surendra.tux@gmail.com>
	<0154F030-52BE-4935-8150-1A96737E7413@holtmann.org>
Date: Wed, 26 Mar 2014 10:33:16 -0700
Message-ID: <CADDSOjg4x-zRsASje2-qpZB_HFeM+iEKbaikSYzdkR97jEYObQ@mail.gmail.com>
Subject: Re: [PATCH] drivers:bluetooth:ath3k.c Fixed sparse warning for cast
 to restricted __le32
From: Surendra Patil <surendra.tux@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Joe Perches <joe@perches.com>, bt <linux-bluetooth@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b5d839121d34a04f585dd85
List-ID: <linux-bluetooth.vger.kernel.org>

--047d7b5d839121d34a04f585dd85
Content-Type: text/plain; charset=ISO-8859-1

Thanks Marcel for the feedback,

In my previous patch joe/johan suggested me to make rom_version to __le32 ,
when i made changes i got an warning while compilation as " rom_version
expects __le32 getting unsigned int " hence i added second changes
cpu_to_32().

I am confused about what should be  the proper change ? I have only built
the module on x86 with sparse.


On Wed, Mar 26, 2014 at 12:21 AM, Marcel Holtmann <marcel@holtmann.org>wrote:

> Hi Surendra,
>
> > To fix the sparse warning "cast to restricted __le32" marked
> > "rom_version"  to __le32 instead of unsigned int in "struct
> ath3k_version"
> > and added cpu_to_le32() for the expression assigning int value to
> "rom_version".
> > Successfully built the module without warnings and errors on x86 machine
> with sparse.
> >
> > Signed-off-by: Surendra Patil <surendra.tux@gmail.com>
> > ---
> > drivers/bluetooth/ath3k.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> > index be571fe..5564207 100644
> > --- a/drivers/bluetooth/ath3k.c
> > +++ b/drivers/bluetooth/ath3k.c
> > @@ -50,7 +50,7 @@
> > #define ATH3K_NAME_LEN                                0xFF
> >
> > struct ath3k_version {
> > -     unsigned int    rom_version;
> > +     __le32          rom_version;
> >       unsigned int    build_version;
> >       unsigned int    ram_version;
> >       unsigned char   ref_clock;
>
> so I think this struct should be __packed in the first place and use
> strictly typed variables.
>
> Seems like all fields have an endian issue.
>
> > @@ -375,7 +375,7 @@ static int ath3k_load_patch(struct usb_device *udev)
> >               return ret;
> >       }
> >
> > -     pt_version.rom_version = *(int *)(firmware->data + firmware->size
> - 8);
> > +     pt_version.rom_version = cpu_to_le32(*(int *)(firmware->data +
> firmware->size - 8));
> >       pt_version.build_version = *(int *)
> >               (firmware->data + firmware->size - 4);
>
> I have no idea what this code is doing since that is just crazy. The
> variables are unsigned int and are now casted into int and not to mention
> that it is unaligned access. Has this code every been run on anything other
> than x86 at all. Does it happen to just work by pure luck.
>
> Regards
>
> Marcel
>
>


-- 
Best,
Surendra Patil

--047d7b5d839121d34a04f585dd85
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Marcel for the feedback,<div><br></div><div>In my p=
revious patch joe/johan suggested me to make rom_version to __le32 , when i=
 made changes i got an warning while compilation as &quot;<span style=3D"co=
lor:rgb(80,0,80);font-family:arial,sans-serif;font-size:13px">=A0rom_versio=
n expects __le32 getting unsigned int=A0</span>&quot; hence i added second =
changes cpu_to_32().</div>

<div><br></div><div>I am confused about what should be =A0the proper change=
 ? I have only built the module on x86 with sparse.</div></div><div class=
=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed, Mar 26, 2014 at=
 12:21 AM, Marcel Holtmann <span dir=3D"ltr">&lt;<a href=3D"mailto:marcel@h=
oltmann.org" target=3D"_blank">marcel@holtmann.org</a>&gt;</span> wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Surendra,<br>
<div class=3D""><br>
&gt; To fix the sparse warning &quot;cast to restricted __le32&quot; marked=
<br>
&gt; &quot;rom_version&quot; =A0to __le32 instead of unsigned int in &quot;=
struct ath3k_version&quot;<br>
&gt; and added cpu_to_le32() for the expression assigning int value to &quo=
t;rom_version&quot;.<br>
&gt; Successfully built the module without warnings and errors on x86 machi=
ne with sparse.<br>
&gt;<br>
&gt; Signed-off-by: Surendra Patil &lt;<a href=3D"mailto:surendra.tux@gmail=
.com">surendra.tux@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; drivers/bluetooth/ath3k.c | 4 ++--<br>
&gt; 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c<br>
&gt; index be571fe..5564207 100644<br>
&gt; --- a/drivers/bluetooth/ath3k.c<br>
&gt; +++ b/drivers/bluetooth/ath3k.c<br>
&gt; @@ -50,7 +50,7 @@<br>
&gt; #define ATH3K_NAME_LEN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00xFF<br>
&gt;<br>
&gt; struct ath3k_version {<br>
&gt; - =A0 =A0 unsigned int =A0 =A0rom_version;<br>
&gt; + =A0 =A0 __le32 =A0 =A0 =A0 =A0 =A0rom_version;<br>
&gt; =A0 =A0 =A0 unsigned int =A0 =A0build_version;<br>
&gt; =A0 =A0 =A0 unsigned int =A0 =A0ram_version;<br>
&gt; =A0 =A0 =A0 unsigned char =A0 ref_clock;<br>
<br>
</div>so I think this struct should be __packed in the first place and use =
strictly typed variables.<br>
<br>
Seems like all fields have an endian issue.<br>
<div class=3D""><br>
&gt; @@ -375,7 +375,7 @@ static int ath3k_load_patch(struct usb_device *ude=
v)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; - =A0 =A0 pt_version.rom_version =3D *(int *)(firmware-&gt;data + firm=
ware-&gt;size - 8);<br>
&gt; + =A0 =A0 pt_version.rom_version =3D cpu_to_le32(*(int *)(firmware-&gt=
;data + firmware-&gt;size - 8));<br>
&gt; =A0 =A0 =A0 pt_version.build_version =3D *(int *)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 (firmware-&gt;data + firmware-&gt;size - 4=
);<br>
<br>
</div>I have no idea what this code is doing since that is just crazy. The =
variables are unsigned int and are now casted into int and not to mention t=
hat it is unaligned access. Has this code every been run on anything other =
than x86 at all. Does it happen to just work by pure luck.<br>

<br>
Regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Marcel<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div dir=3D"ltr">Best,<div>Surendra Patil</div></div>
</div>

--047d7b5d839121d34a04f585dd85--
