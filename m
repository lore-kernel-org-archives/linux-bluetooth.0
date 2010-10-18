Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1287268187-9628-1-git-send-email-vapier@gentoo.org>
References: <1287268187-9628-1-git-send-email-vapier@gentoo.org>
Date: Mon, 18 Oct 2010 11:17:28 -0700
Message-ID: <AANLkTinMSbhTkH0zQn_YO7hFF7zkuv-Gj-B0BUFWy5nP@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: fix unaligned access to l2cap conf data
From: Harvey Harrison <harvey.harrison@gmail.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, steven miao <realmz6@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Oct 16, 2010 at 3:29 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> From: steven miao <realmz6@gmail.com>
>
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case 2:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((__le16 *) opt->val)=
 =3D cpu_to_le16(val);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_unaligned_le16(cpu=
_to_le16(val), opt->val);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>

I think you wanted:
put_unaligned_le16(val, opt->val);

Cheers,

Harvey
