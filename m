Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <20101018163223.GC2468@vigoh>
References: <1287268187-9628-1-git-send-email-vapier@gentoo.org>
 <AANLkTinMSbhTkH0zQn_YO7hFF7zkuv-Gj-B0BUFWy5nP@mail.gmail.com> <20101018163223.GC2468@vigoh>
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 18 Oct 2010 15:10:36 -0400
Message-ID: <AANLkTin3Tx8jyR47G3SNbP_zFJ+tGdR6FtraHmM2T79j@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: fix unaligned access to l2cap conf data
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>, uclinux-dist-devel@blackfin.uclinux.org,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	steven miao <realmz6@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 18, 2010 at 12:32, Gustavo F. Padovan wrote:
> * Harvey Harrison <harvey.harrison@gmail.com> [2010-10-18 11:17:28 -0700]=
:
>> On Sat, Oct 16, 2010 at 3:29 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
>> > From: steven miao <realmz6@gmail.com>
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0case 2:
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *((__le16 *) opt->v=
al) =3D cpu_to_le16(val);
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_unaligned_le16(=
cpu_to_le16(val), opt->val);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>>
>> I think you wanted:
>> put_unaligned_le16(val, opt->val);
>
> I fixed that in the tree. Thanks for the report.

i guess you fixed the 32bit one too ?
  put_unaligned_le32(cpu_to_le32(val), opt->val);
-mike
