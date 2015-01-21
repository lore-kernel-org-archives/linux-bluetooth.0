Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A73F36CA-2DD1-4EBE-A08F-E3CD0CC63ECA@holtmann.org>
References: <CAEUmHyata35dg_=CMWau0AhjVwFU-cJT1eVyBsgpDHYRMp5uzw@mail.gmail.com>
	<A73F36CA-2DD1-4EBE-A08F-E3CD0CC63ECA@holtmann.org>
Date: Wed, 21 Jan 2015 10:57:30 +0530
Message-ID: <CAEUmHyYR=NRMsPMkps413XSVDrNAKoJ8_X4eEgpp2Q6A8=3XSA@mail.gmail.com>
Subject: Re: bluetooth-next tree compilation error
From: Varka Bhadram <varkabhadram@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 21, 2015 at 10:49 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Varka,
>
>> I am getting compilation error with bluetooth-next tree. No problem
>> with net-next tree.
>> ...
>> CC      drivers/net/ethernet/ti/cpsw.o
>> drivers/net/ethernet/ti/cpsw.c: In function =E2=80=98cpsw_ndo_poll_contr=
oller=E2=80=99:
>> drivers/net/ethernet/ti/cpsw.c:1635:24: error: =E2=80=98struct cpsw_priv=
=E2=80=99 has
>> no member named =E2=80=98irq=E2=80=99
>> drivers/net/ethernet/ti/cpsw.c:1636:24: error: =E2=80=98struct cpsw_priv=
=E2=80=99 has
>> no member named =E2=80=98irq=E2=80=99
>> make[4]: *** [drivers/net/ethernet/ti/cpsw.o] Error 1
>> make[3]: *** [drivers/net/ethernet/ti] Error 2
>> make[2]: *** [drivers/net/ethernet] Error 2
>> make[1]: *** [drivers/net] Error 2
>> make: *** [drivers] Error 2
>
> this is obviously not our fault. However just in case I pulled net-next i=
nto bluetooth-next now.
>
Yes you correct. But the problem is we are using bluetooth-next tree
for development. This problem wont be
there if you update the tree with net-next. That you did. Great. Thanks...

> Regards
>
> Marcel
>
