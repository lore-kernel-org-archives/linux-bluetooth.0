Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030519140835.050ef830@unixmail.qualcomm.com>
Date: Mon, 19 May 2003 14:17:46 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001301c31bd5$3287cb10$1a01010a@baked>
References: <5.1.0.14.2.20030516101849.0d55f0f0@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

We now have full support for SO_LINGER socket option (2.4 BK is already updated). 
I also added -L option and some more error checking to l2test and rctest.

./l2test -L 60 -s -b 1000 -N 10 
this will enabled SO_LINGER for 60 seconds and report an error if channel disconnect
timed out or failed for any other reason.

I tested it with HCIEmu and everything seems to work as expected.

btw Regarding RFCOMM disconnect problem that Marcel mentioned. I check the spec again
and it's indeed option to send DISC for DCL 0.

"5.2.2 Close-down procedure
The device closing the last connection (DLC) on a particular session is responsible
for closing the multiplexer by closing the corresponding L2CAP channel.
Closing the multiplexer by first sending a DISC command frame on DLCI 0 is
optional, but it is mandatory to respond correctly to a DISC (with UA response)."

So I think it's ok that we don't wait for UA response before closing L2CAP channel.

Max
