Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 18 Oct 2010 14:32:23 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	steven miao <realmz6@gmail.com>
Subject: Re: [PATCH] bluetooth: fix unaligned access to l2cap conf data
Message-ID: <20101018163223.GC2468@vigoh>
References: <1287268187-9628-1-git-send-email-vapier@gentoo.org>
 <AANLkTinMSbhTkH0zQn_YO7hFF7zkuv-Gj-B0BUFWy5nP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTinMSbhTkH0zQn_YO7hFF7zkuv-Gj-B0BUFWy5nP@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harvey,

* Harvey Harrison <harvey.harrison@gmail.com> [2010-10-18 11:17:28 -0700]:

> On Sat, Oct 16, 2010 at 3:29 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> > From: steven miao <realmz6@gmail.com>
> >
> >
> > =A0 =A0 =A0 =A0case 2:
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *((__le16 *) opt->val) =3D cpu_to_le16(va=
l);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le16(cpu_to_le16(val), opt-=
>val);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> >
>=20
> I think you wanted:
> put_unaligned_le16(val, opt->val);

I fixed that in the tree. Thanks for the report.=20

--=20
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
