Return-Path: <andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
In-Reply-To: <47E39EED-4F96-4128-BAD1-09CDE4FC7A2E@holtmann.org>
References: <20170901080744.11544-1-andrzej.kaczmarek@codecoup.pl> <47E39EED-4F96-4128-BAD1-09CDE4FC7A2E@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Date: Fri, 1 Sep 2017 15:26:15 +0200
Message-ID: <CADAkoF53b05YqAWCtwQypX6JVy8ptjW_tvyfp1V+Gwr1Cb5sHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc/btsnoop: Add nop opcode
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary="94eb2c05c5d2ccea7b055820b59f"
List-ID: <linux-bluetooth.vger.kernel.org>

--94eb2c05c5d2ccea7b055820b59f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Fri, Sep 1, 2017 at 2:29 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:

> Hi Andrzej,
>
> > This adds 'no operation' opcode for the cases where we do not want to
> > include any particular payload, just the header is valid.
> >
> > For example, when some packets are dropped over TTY implementation can
> > pass this information only in some other packet and this won't happen
> > until there's actually something to send. With this addition it can
> > just send nop after some time to indicate there were packets dropped.
> > ---
> > doc/btsnoop.txt | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> > diff --git a/doc/btsnoop.txt b/doc/btsnoop.txt
> > index 975a53f6d..865b81554 100644
> > --- a/doc/btsnoop.txt
> > +++ b/doc/btsnoop.txt
> > @@ -115,6 +115,13 @@ User Logging
> >
> >       User logging information.
> >
> > +NOP
> > +-----------
> > +
> > +     Code:        0xffff
> > +
> > +     No operation.
> > +
>
> Hmmm. I am not a huge fan of this. Then I see that we defined the ext_hdr
> that allows to deal with the dropped packets.
>
> I need to think about this a bit since there are some other opcode
> extensions we have to do for certain cases where we have unexpected
> packets. Right now I would propose to use vendor diagnostic or system not=
e
> with empty payload.
>

Vendor diagnostic would produce a message in btmon which may be misleading
and system note with empty payload will print some garbage (i.e. previous
contents=E2=80=8B of buffer) since message is not null-terminated.
But in this case I can just fix btmon to skip system notes with no payload
and it will be basically the same as nop - does it sound good enough for
now?


>
> Regards
>
> Marce
> =E2=80=8Bl
>

Best regards,

Andrzej=E2=80=8B

>

--94eb2c05c5d2ccea7b055820b59f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Hi Marcel,<br></div><div class=3D"gmail_extra"><br><div=
 class=3D"gmail_quote">On Fri, Sep 1, 2017 at 2:29 PM, Marcel Holtmann <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">=
marcel@holtmann.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Hi Andrzej,<br>
<span class=3D""><br>
&gt; This adds &#39;no operation&#39; opcode for the cases where we do not =
want to<br>
&gt; include any particular payload, just the header is valid.<br>
&gt;<br>
&gt; For example, when some packets are dropped over TTY implementation can=
<br>
&gt; pass this information only in some other packet and this won&#39;t hap=
pen<br>
&gt; until there&#39;s actually something to send. With this addition it ca=
n<br>
&gt; just send nop after some time to indicate there were packets dropped.<=
br>
&gt; ---<br>
&gt; doc/btsnoop.txt | 7 +++++++<br>
&gt; 1 file changed, 7 insertions(+)<br>
&gt;<br>
&gt; diff --git a/doc/btsnoop.txt b/doc/btsnoop.txt<br>
&gt; index 975a53f6d..865b81554 100644<br>
&gt; --- a/doc/btsnoop.txt<br>
&gt; +++ b/doc/btsnoop.txt<br>
&gt; @@ -115,6 +115,13 @@ User Logging<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0User logging information.<br>
&gt;<br>
&gt; +NOP<br>
&gt; +-----------<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0Code:=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xffff<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0No operation.<br>
&gt; +<br>
<br>
</span>Hmmm. I am not a huge fan of this. Then I see that we defined the ex=
t_hdr that allows to deal with the dropped packets.<br>
<br>
I need to think about this a bit since there are some other opcode extensio=
ns we have to do for certain cases where we have unexpected packets. Right =
now I would propose to use vendor diagnostic or system note with empty payl=
oad.<br></blockquote><div><br></div><div><div style=3D"font-family:arial,he=
lvetica,sans-serif" class=3D"gmail_default">Vendor diagnostic would produce=
 a message in btmon which may be misleading and system note with empty payl=
oad will print some garbage (i.e. previous contents=E2=80=8B of buffer) sin=
ce message is not null-terminated.<br></div><div style=3D"font-family:arial=
,helvetica,sans-serif" class=3D"gmail_default">But in this case I can just =
fix btmon to skip system notes with no payload and it will be basically the=
 same as nop - does it sound good enough for now?<br></div></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Marce<div style=3D"font-family:arial,helvetica,sans-serif;display:inline" c=
lass=3D"gmail_default">=E2=80=8Bl</div></font></span></blockquote><div styl=
e=3D"font-family:arial,helvetica,sans-serif;display:inline" class=3D"gmail_=
default"><br></div><div style=3D"font-family:arial,helvetica,sans-serif;dis=
play:inline" class=3D"gmail_default"><font color=3D"#888888">Best regards,<=
/font></div><div style=3D"font-family:arial,helvetica,sans-serif;display:in=
line" class=3D"gmail_default"><br></div><div style=3D"font-family:arial,hel=
vetica,sans-serif;display:inline" class=3D"gmail_default"><font color=3D"#8=
88888">Andrzej</font>=E2=80=8B</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span class=3D"HOEnZb"><font color=3D"#888888">

</font></span></blockquote></div></div></div>

--94eb2c05c5d2ccea7b055820b59f--
