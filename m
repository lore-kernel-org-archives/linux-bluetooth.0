Return-Path: <gary_martin_au@yahoo.com.au>
Message-ID: <20040401090917.60642.qmail@web21005.mail.yahoo.com>
Date: Thu, 1 Apr 2004 19:09:17 +1000 (EST)
From: =?iso-8859-1?q?Gary=20Martin?= <gary_martin_au@yahoo.com.au>
Subject: Re: [Bluez-users] Desperate newbie
To: bluez-users@lists.sourceforge.net
Cc: Marcel Holtmann <marcel@holtmann.org>,
   Thomas Chiverton <thomas.chiverton@bluefinger.com>,
   Andreas Deresch <aderesch@fs.tum.de>
In-Reply-To: <1080746814.2536.16.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <bluez-users.lists.sourceforge.net>

Thank you to Andreas, Marcel and Tom for your assistance. I
assumed that the problems I am having connecting to my phone were
the result of me misconfiguring something eg. hcid.conf. But
Marcel and Andreas seem to intimate that it may be a problem in
Bluez for PowerPC. I find it hard to believe that there aren't
other Linux PPC users successfully using Bluez to synchronise
their phones.
Bluetooth connectivity is an important function for today's
computer users --- I can't be the only one!

> > Fine, so the only difference (apart from multisync itself)
> between our
> > phones is that "hcitool info <BDA>" does not work for you. The
> problem there
> > seems to arise at HCIGETCONNINFO and then
> hci_create_connection.
Sometimes I have "object push" on the phone, and I can send files
to Linux. Sometimes I can't. This change appears after I have
connected the phone under Mac OS X. Does the Bluetooth adapter
retain information from one operating system to the other? Even
when I delete the device "Mac OS X" on the phone and pair it with
"debian-0", the phone retains services that aren't available in
Linus, and refreshing the services on the phone makes them
disappear


> Marcel wrote
> On the other side I think that the userspace part still have 
some
missing byteswap operations, so try to isolate them and I will try

to
fix them as soon as possible.
Am I to isolate missing byteswap operations? I'm afraid I don't
know how to do this?

Regards,

Gary Martin

Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
