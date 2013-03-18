Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130318145711.GB16337@joana>
References: <1363443003-13839-1-git-send-email-gheorghiuandru@gmail.com>
	<20130318145711.GB16337@joana>
Date: Mon, 18 Mar 2013 17:03:10 +0200
Message-ID: <CADca43LWFC64PeppEGpxPLPj+XDna69oGeamBYX1A5q2vb-Wow@mail.gmail.com>
Subject: Re: [PATCH] net: bluetooth: Use PTR_RET function
From: Andru Gheorghiu <gheorghiuandru@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>, Alexandru Gheorghiu <gheorghiuandru@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=e0cb4efe2b2a8ea30b04d8344944
List-ID: <linux-bluetooth.vger.kernel.org>

--e0cb4efe2b2a8ea30b04d8344944
Content-Type: text/plain; charset=ISO-8859-1

Sorry, I made the change without checking. I shall resend it.

Thank you,
Alexandru Gheorghiu

On Mon, Mar 18, 2013 at 4:57 PM, Gustavo Padovan <gustavo@padovan.org>wrote:

> Hi Alexandru,
>
> * Alexandru Gheorghiu <gheorghiuandru@gmail.com> [2013-03-16 16:10:03
> +0200]:
>
> > Used PTR_RET function instead of IS_ERR and PTR_ERR.
> > Patch found using coccinelle.
> >
> > Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
> > ---
> >  net/bluetooth/hci_sysfs.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
>
> Patch has been applied to bluetooth-next. Thanks.
>
>         Gustavo
>

--e0cb4efe2b2a8ea30b04d8344944
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sorry, I made the change without checking. I shall resend it.<div><br></div=
><div>Thank you,</div><div>Alexandru Gheorghiu<br><br><div class=3D"gmail_q=
uote">On Mon, Mar 18, 2013 at 4:57 PM, Gustavo Padovan <span dir=3D"ltr">&l=
t;<a href=3D"mailto:gustavo@padovan.org" target=3D"_blank">gustavo@padovan.=
org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Alexandru,<br>
<br>
* Alexandru Gheorghiu &lt;<a href=3D"mailto:gheorghiuandru@gmail.com">gheor=
ghiuandru@gmail.com</a>&gt; [2013-03-16 16:10:03 +0200]:<br>
<div class=3D"im"><br>
&gt; Used PTR_RET function instead of IS_ERR and PTR_ERR.<br>
&gt; Patch found using coccinelle.<br>
&gt;<br>
&gt; Signed-off-by: Alexandru Gheorghiu &lt;<a href=3D"mailto:gheorghiuandr=
u@gmail.com">gheorghiuandru@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0net/bluetooth/hci_sysfs.c | =A0 =A04 +---<br>
&gt; =A01 file changed, 1 insertion(+), 3 deletions(-)<br>
<br>
</div>Patch has been applied to bluetooth-next. Thanks.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=A0 =A0 =A0 =A0 Gustavo<br>
</font></span></blockquote></div><br></div>

--e0cb4efe2b2a8ea30b04d8344944--
