Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Jan 2009 09:17:47 +0100
From: "X-PELAGE.Patrick" <patrick.pelage@partners.mbda-systems.com>
Subject: RE: csr_h4.c
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Message-id: <7F2D9B7FC7AF6C47AA68F9CF2094BC7C0346AE3C@rpmsg03.ch.mbda.priv>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks!

I am reading and try to udestand the csr_h4.c source file.
 =20
1- What is the "varid" argument of "csr_read" and "csr_write"
functions? is it the HCI packet type, identified in HCI UART TRANSPORT =
LAYER?
2- How to used the csr_h4.c file? that is to say, the main function, if =
I want to send an HCI packet using H4?
3- What is the meaning of "uin16_t command" in "do_command" function?=20
4- What is the description and specification of the csr_read_h4() input =
parameters? Same questions for csr_write_h4()? So if I have to send a =
HCI frame, what I have to do with these functions, according their input =
parameters?

King regards

Patrick

> -----Message d'origine-----
> De : Marcel Holtmann [mailto:marcel@holtmann.org]=20
> Envoy=E9 : jeudi 29 janvier 2009 09:12
> =C0 : X-PELAGE.Patrick
> Objet : Re: csr_h4.c
>=20
> Hi,
>=20
> >=20
> > I am reading and try to udestand the csr_h4.c source file.
> > =20
> > 1- What is the "varid" argument of "csr_read" and "csr_write"
> > functions? is it the HCI packet type, identified in HCI=20
> UART TRANSPORT=20
> > LAYER?
> > 2- How to used the csr_h4.c file? that is to say, the main=20
> function,=20
> > if I want to send an HCI packet using H4?
> > 3- What is the meaning of "uin16_t command" in "do_command"=20
> function?
>=20
> use linux-bluetooth@vger.kernel.org for such questions.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
