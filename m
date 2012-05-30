Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1338302161.15105.125.camel@aeonflux>
References: <1338286766-5368-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1338286766-5368-2-git-send-email-frederic.dalleau@linux.intel.com>
	<1338302161.15105.125.camel@aeonflux>
Date: Wed, 30 May 2012 13:22:37 +0300
Message-ID: <CA+QXtDuBEP3sT9oNAwhDPOoD1RjEtLQw-8tFM-5rrMSjP15_6Q@mail.gmail.com>
Subject: Re: [RFC] network: Reply to extensions at connection setup
From: "Dalleau, Frederic" <frederic.dalleau@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=e89a8f642c748d741e04c13e54a9
List-ID: <linux-bluetooth.vger.kernel.org>

--e89a8f642c748d741e04c13e54a9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, May 29, 2012 at 5:36 PM, Marcel Holtmann <marcel@holtmann.org>wrote=
:

> > TP/BNEP/CTRL/BV-19-C is about extension in the BNEP_SETUP_CONN_REQ
> > control message. BNEP_SETUP_CONN_REQ is handled by bluetoothd before
> > giving control to kernel.  Current bluez do not reply at all if an
> > extension is added to BNEP_SETUP_CONN_REQ. This patch fixes it by
> > sending COMMAND_NOT_UNDERSTOOD reply.
>


> is this really a good idea to just decline all extensions here?
>
> What happens to the filter setup done via these commands. Don't we need
> to process them inside the kernel to actually setup the filters.
>

I have chosen to decline the extension because they are marked as not
supported in all qualification listings that I have seen.

Processing extensions in the kernel is of course better, but both kernel
and
userspace needs changing, which is usually a much longer process. If
preferred,
I can do so.

Regards,
Fr=E9d=E9ric

--e89a8f642c748d741e04c13e54a9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel,<br><br><div class=3D"gmail_quote">On Tue, May 29, 2012 at 5:36 P=
M, Marcel Holtmann <span dir=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann.=
org" target=3D"_blank">marcel@holtmann.org</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
&gt; TP/BNEP/CTRL/BV-19-C is about extension in the BNEP_SETUP_CONN_REQ<br>=
<div><div class=3D"h5">
&gt; control message. BNEP_SETUP_CONN_REQ is handled by bluetoothd before<b=
r>
&gt; giving control to kernel. =A0Current bluez do not reply at all if an<b=
r>
&gt; extension is added to BNEP_SETUP_CONN_REQ. This patch fixes it by<br>
&gt; sending COMMAND_NOT_UNDERSTOOD reply.<br></div></div></blockquote><div=
>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div class=
=3D"h5">

</div></div>is this really a good idea to just decline all extensions here?=
<br>
<br>
What happens to the filter setup done via these commands. Don&#39;t we need=
<br>
to process them inside the kernel to actually setup the filters.<span class=
=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquote><div>=A0=
</div></div>I have chosen to decline the extension because they are
marked as not<br>supported in all qualification listings that I have=20
seen.<br><br>Processing extensions in the kernel is of course better, but b=
oth kernel and <br>userspace needs changing, which is usually a much longer=
 process. If preferred,<br>I can do so.<br><br>
Regards,<br>Fr=E9d=E9ric<br><br>

--e89a8f642c748d741e04c13e54a9--
