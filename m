Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Wed, 14 May 2003 14:12:10 -0700
Message-ID: <001401c31a5d$7ba2bf90$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5.1.0.14.2.20030514093233.0d4e2a28@unixmail.qualcomm.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

> >Another addition to l2test (and maybe rctest) that would be 
> handy for 
> >testing is an option to specify how many packets to send. It 
> would be 
> >nice to have the option of sending only a few packets rather than an 
> >infinite number. None of the tests that I've encountered so 
> far require 
> >sending large amounts of data... Just a packet or two. For rfcomm 
> >testing I could probably just do an "rfcomm connect /dev/something 
> >etc.." and redirect something small to /dev/something if rctest is 
> >causing trouble.
> Go for it. I mean l2test/rctest changes. And sent us a patch(es).

Ok. Will do. I probably won't be able to get to it for a while, but I don't
think anyone else cares at the moment anyway. ;)

-Daryl.
