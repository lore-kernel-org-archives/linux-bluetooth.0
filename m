Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Wed, 14 May 2003 09:02:18 -0700
Message-ID: <000501c31a32$327c9be0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1052872215.4608.44.camel@pegasus.local>
List-ID: <bluez-devel.lists.sourceforge.net>

Hey Marcel,

> > L2CAP_LM_RELIABLE

L2CAP_LM_RETENTIVE? ;) (Not sure if the slang meaning of that word comes
through in other countries. The real meaning may not be appropriate.) Some
others: intolerant, cautious.

> > Now we just need to add support for it in l2test.
>=20
> Daryl, it is your test :)

Cool. :)

Another addition to l2test (and maybe rctest) that would be handy for
testing is an option to specify how many packets to send. It would be nice
to have the option of sending only a few packets rather than an infinite
number. None of the tests that I've encountered so far require sending larg=
e
amounts of data... Just a packet or two. For rfcomm testing I could probabl=
y
just do an "rfcomm connect /dev/something etc.." and redirect something
small to /dev/something if rctest is causing trouble.

-Daryl.
