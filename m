Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'James Courtier-Dutton'" <James@superbug.demon.co.uk>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Subject: RE: [Bluez-devel] Qualification testing - rfcomm
Date: Fri, 18 Jul 2003 13:25:52 -0700
Message-ID: <000701c34d6a$c9c5c740$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <3F184AD5.5090709@superbug.demon.co.uk>
List-ID: <bluez-devel.lists.sourceforge.net>

James,

> > Finally got some results on those latest rfcomm changes for=20
> > qualification. Looks like there are a few more problems. :(=20
>  But we're=20
> > close. :)
> >=20
> Can you outline what hardware you are using to do the test.
> Is it:
> 1) USB bluetooth adapters
> 2) PCI bluetooth adapters
> 3) PCMCIA bluetooth adapters
> 4) Serial bluetooth adapters.

We are using an Ericsson ROK 104001 bluetooth module. It's connected to a
high-speed UART. The stack is running on an ARM processor.

Once qualification testing is complete I'll put together a list of all test=
s
that were performed, and what kind of software tools or programs needed to
be used for each test.

-Daryl.
