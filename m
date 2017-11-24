Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <614D22AE-E15E-4943-87E9-A52A84F85FB2@diva-e.com>
References: <614D22AE-E15E-4943-87E9-A52A84F85FB2@diva-e.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Nov 2017 10:27:44 +0200
Message-ID: <CABBYNZJ8vc0eB4np_0JeM00NaixTRb0OP9b7jvGA96iw0jgQsA@mail.gmail.com>
Subject: Re: GATT Server ReadValue offset missing
To: Matthias Schmidt <Matthias.Schmidt@diva-e.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthias,

On Thu, Nov 23, 2017 at 5:05 PM, Matthias Schmidt
<Matthias.Schmidt@diva-e.com> wrote:
> Hi *,
>
> despite the ReadValue Documentation:
>
> Methods         array{byte} ReadValue(dict options)
>
>                         Issues a request to read the value of the
>                         characteristic and returns the value if the
>                         operation was successful.
>
>                         Possible options: "offset": uint16 offset
>                                           "device": Object Device (Server=
 only)
>
> We don=E2=80=99t get the offset value, but only the device entry:
>
> Keyhandling.ReadValue(), options=3D{'device': '/org/bluez/hci0/dev_45_4A_=
B8_B8_BA_09'}
>
> We are running Bluez 5.47 on Debian Stretch on armv7l.
>
> What have we done wrong?

Is the offset 0? We only send the offset if it is different than 0:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c=
#n1719

> Cheers,
>
> Matthias
>
> Matthias Schmidt
> Senior Architect
>
> diva-e Karlsruhe
> Ludwig-Erhard-Allee 20, 76131 Karlsruhe, Deutschland
> T: +49 721 92060 822
> M: +49 175 2694213
> matthias.schmidt@diva-e.com
>
> CE27 BF59 3651 2619 8A5D  08CA 0839 2E99 3449 4A32
>
>
>
> Public Key: matthias-schmidt-diva-e-com-34494A32.asc <https://owncloud.di=
va-e.com/index.php/s/RJYDK9Ypfnxqscg/download>
>
> www.diva-e.com <https://www.diva-e.com/> follow us: twitter <https://twit=
ter.com/diva_enterprise>, facebook <https://www.facebook.com/digital.value.=
enterprise/?ref=3Dhl>, LinkedIn <https://www.linkedin.com/company/diva-e-di=
gital-value-enterprise-gmbh>, Xing <https://www.xing.com/companies/diva-edi=
gitalvalueenterprisegmbh>
>
> -------------------------------------------------
> diva-e | Netpioneer GmbH
> Ludwig-Erhard-Allee 20, 76131 Karlsruhe
> HRB: 107521 Handelsregister Mannheim
> Gesch=C3=A4ftsf=C3=BChrung: Marcel Fuhlmann, Stefan M=C3=A4rkle, Axel Jah=
n
>
>



--=20
Luiz Augusto von Dentz
