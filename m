Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Fri, 16 May 2003 11:01:38 -0700
Message-ID: <001301c31bd5$3287cb10$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5.1.0.14.2.20030516101849.0d55f0f0@unixmail.qualcomm.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

> >> I sent the above quote to Cetecom last week. They responded
> >> saying that MTU isn't the only negotiated parameter.
>=20
> FlushTO _must_ be 0xffff for reliable ACL link. So far none=20
> of the profiles specified use of unreliable links.=20
>=20
> Support for QOS is totally optional. We're only required to=20
> support 'best effort'. Which means that even if they want=20
> something other than 'best effort' (i.e. they reject=20
> default settings) we won't be able to accept it simply=20
> because we don't support it.
>=20
> So I'm not sure what can be negotiated there.=20

Ok. I'll see what they say about that too.

> btw Can this fancy Merlin viewer export trace in plain text ?=20
> I'm too lazy to install=20
> that stuff. And it looks like I need to see what is it=20
> exactly that they request/reject.

Not that I'm aware of. Marcel - you're probably more experienced with Merli=
n
than me. Do you know of a way?

Before we start the test, we must specify to the tester the parameters that
we'll accept. The tester will reject the first set of values, no matter wha=
t
they are. In its response it will send new values (which we specify) that i=
t
expects to see in the next request from the IUT.

-Daryl.
