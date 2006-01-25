Return-Path: <michiel@yall.nl>
Date: Wed, 25 Jan 2006 10:12:37 +0100
From: Michiel van Hulst <michiel@yall.nl>
Subject: Re: [Bluez-devel] vendor/manufacture id
In-reply-to: <1138143376.2616.5.camel@localhost>
To: Jim Wyllie <jwyllie@masaka.cs.ohiou.edu>,
        Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
Message-id: <200601251012.38001.michiel@yall.nl>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <43D69967.3060704@yall.nl> <1138143376.2616.5.camel@localhost>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel, Jim,

Thanks for the reply,

> the company id 10 stands for CSR. Take a look at the Bluetooth assigned
> numbers documents from their website.
The tool hcitool using the option "info <btaddr>" prints out Manufacture:=20
Cambridge Silicon Radio (10) or Nokia Mobile Phones (1) and so on. So in th=
e=20
tool code should be a mapping for these numbers? Trough JBluez I only recei=
ve=20
the manufacture number (1) and (10) in this example.

Is there a list availible or array in c code which has these mappings?=20

My program should respond deferent on every bluetooth manafacture device it=
=20
detects, so I'm looking for the manufacture id's from the Bluetooth device=
=20
market leaders

> I've tested all of the JSR-82 options out there that are available for
> free on Linux: the only thing I got to work is Avetana's JSR-82 spec
> (GPL code on Linux).  You can grab it from SourceForge here:
>
> http://sourceforge.net/projects/avetanabt/
Great! The project release date is much more promecing ;-). I downloaded th=
is=20
project and its seems the include a prebuild version of the .jar and .so I'=
m=20
going to test this for sure

Cheers,

Michiel

On Tuesday 24 January 2006 23:56, Marcel Holtmann wrote:
> Hi Michiel,
>
> > I posted almost the same email to the bluez-user mailing list, but its
> > more developer related I think;
> >
> > I use the outdated jBluez native Java API and got a question about the
> > manufacture id's.
> >
> > When getting version info for a remote device using the Java API wich is
> > native corresponding with Bluez a manufacture id is retreived and store=
d.
> > This is great but I don't have or can't find any list corresponding with
> > these manufacture id's. I browsed some Bluez c code and did see some
> > manufacture id such as 10 (Nokia) being stored and used in functions.
>
> the company id 10 stands for CSR. Take a look at the Bluetooth assigned
> numbers documents from their website.
>
> > Another question which is proberbly asked many times before, but I just
> > can't settle with it, yet:
> >
> > - Is there a good, can be simple but good and maintened opensource Java
> > API for Bluez?
>
> Nobody spent the time to run something like that by me. So actually
> there is no real good JSR-82 implementation for BlueZ.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

=2D-=20
regards,

M.P.A. (Michiel) van Hulst

Y'All . http://www.yall.nl
Grotestraat 182 5141 HD Waalwijk . The Netherlands
Tel: +31 (0) 416 340 019 =C2=A0. Fax. : +31 (0) 416 340 019=20

Information in this message may be confidential and is intended for
the recipient only. Please do not use the content of this message
if you receive this unintentionally and notify us by return mail.
