Return-Path: <jjmeijer88@gmail.com>
MIME-Version: 1.0
References: <1453707843-92704-1-git-send-email-marcel@holtmann.org>
 <20160127154921.GA13196@t440s> <CAA+NYvQ35ZoSRy8dEfctXWpfkAN4NuckFnMobdcwjW4hS7ei0g@mail.gmail.com>
 <EB5B11A1-B0CC-4C3D-92F3-689BA44D158F@holtmann.org>
In-Reply-To: <EB5B11A1-B0CC-4C3D-92F3-689BA44D158F@holtmann.org>
From: Jaap Jan Meijer <jjmeijer88@gmail.com>
Date: Fri, 29 Jan 2016 11:40:26 +0000
Message-ID: <CAA+NYvRJst_d2Tim6DsmmQKX2CNf1MMSiZVUCgJj-7SONXKqrQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add missing COMPATIBLE_IOCTL for UART line discipline
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a113fbaf6ed73f8052a7780c2
List-ID: <linux-bluetooth.vger.kernel.org>

--001a113fbaf6ed73f8052a7780c2
Content-Type: text/plain; charset=UTF-8

Hi Marcel,

At the moment I can only tell you that the error was the same without the
second patch.

But those might have bin incremental builds, I think. I will check again
with proper builds and see if I can get some debugging going.

Kind regards,

J.J.



Op vr 29 jan. 2016 11:44 schreef Marcel Holtmann <marcel@holtmann.org>:

> Hi Jaap,
>
> > Could you please also add
> > "[PATCH] Bluetooth: hci_ldisc: Add support for compat_ioctl handling"
> > to get proper ioctl compat functionality?
> >
> > Many thanks in advance,
>
> are you sure that is really needed? I do wonder why we need that. At least
> with COMPATIBLE_IOCTL the error message should actually change. Can you
> trace how far we get in the code path.
>
> Regards
>
> Marcel
>
>

--001a113fbaf6ed73f8052a7780c2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Marcel,</div><span>
</span><p dir=3D"ltr">At the moment I can only tell you that the error was =
the same without the second patch.</p><p dir=3D"ltr">But those might have b=
in incremental builds, I think. I will check again with proper builds and s=
ee if I can get some debugging going.</p><p dir=3D"ltr">Kind regards,</p><p=
 dir=3D"ltr">J.J.</p><p dir=3D"ltr"><br></p><span>
</span><br><div class=3D"gmail_quote"><div dir=3D"ltr">Op vr 29 jan. 2016 1=
1:44 schreef=C2=A0Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org=
" target=3D"_blank">marcel@holtmann.org</a>&gt;:<br></div></div><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Hi Jaap,<br>
<br>
&gt; Could you please also add<br>
&gt; &quot;[PATCH] Bluetooth: hci_ldisc: Add support for compat_ioctl handl=
ing&quot;<br>
&gt; to get proper ioctl compat functionality?<br>
&gt;<br>
&gt; Many thanks in advance,<br>
<br>
are you sure that is really needed? I do wonder why we need that. At least =
with COMPATIBLE_IOCTL the error message should actually change. Can you tra=
ce how far we get in the code path.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
</blockquote></div>

--001a113fbaf6ed73f8052a7780c2--
