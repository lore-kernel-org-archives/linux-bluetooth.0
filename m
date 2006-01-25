Return-Path: <michiel@yall.nl>
Date: Wed, 25 Jan 2006 10:44:07 +0100
From: Michiel van Hulst <michiel@yall.nl>
Subject: Re: [Bluez-devel] vendor/manufacture id
In-reply-to: <1138181580.5782.16.camel@localhost>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Message-id: <200601251044.07088.michiel@yall.nl>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <43D69967.3060704@yall.nl> <200601251012.38001.michiel@yall.nl>
 <1138181580.5782.16.camel@localhost>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> the library function is called bt_compidtostr().
Great thanks.

> You read my answer with the Bluetooth assigned numbers document? Go to
> the Bluetooth website and get this document/webpage.
I misread your comments and went looking for the document on the CSR websit=
e=20
dooh ;-)

This is the link to the document containting the bt device company=20
identifiers:
https://www.bluetooth.org/foundry/assignnumb/document/company_identifiers

Thanks,

Michiel

On Wednesday 25 January 2006 10:33, Marcel Holtmann wrote:
> Hi Michiel,
>
> > > the company id 10 stands for CSR. Take a look at the Bluetooth assign=
ed
> > > numbers documents from their website.
> >
> > The tool hcitool using the option "info <btaddr>" prints out Manufactur=
e:
> > Cambridge Silicon Radio (10) or Nokia Mobile Phones (1) and so on. So in
> > the tool code should be a mapping for these numbers? Trough JBluez I on=
ly
> > receive the manufacture number (1) and (10) in this example.
> >
> > Is there a list availible or array in c code which has these mappings?
>
> the library function is called bt_compidtostr().
>
> > My program should respond deferent on every bluetooth manafacture device
> > it detects, so I'm looking for the manufacture id's from the Bluetooth
> > device market leaders
>
> You read my answer with the Bluetooth assigned numbers document? Go to
> the Bluetooth website and get this document/webpage.
>
> Regards
>
> Marcel

=2D-=20
regards,

M.P.A. (Michiel) van Hulst

Y'All . http://www.yall.nl
Grotestraat 182 5141 HD Waalwijk . The Netherlands
Tel: +31 (0) 416 340 019 =C2=A0. Fax. : +31 (0) 416 340 019=20

Information in this message may be confidential and is intended for
the recipient only. Please do not use the content of this message
if you receive this unintentionally and notify us by return mail.
