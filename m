Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Fri, 16 May 2003 10:54:21 -0700
Message-ID: <001201c31bd4$2e87e320$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5.1.0.14.2.20030516103557.0d59b470@unixmail.qualcomm.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

> btw We want to get all your changes that are useful for 
> qualification. I'm talking about changes to l2test/rctest/etc 
> that you had to make to support 
> particular tests.

You'll definitely get them. :)

So far the l2test change that I gave you yesterday is all that I've needed.
I wasn't actually using it though, I was using a hacked version that would
only send 1 packet. But the updated l2test should be fine.

The l2test and rctest tools that are already available have been great for
testing. Most of the tests are very simple on the IUT end. You either have
to listen for a connection or make a connection, and either send or receive
data or neither.

Oh yeah, I'm going to have to make a tool or an addition to l2test which
will receive data and send data at the same time. I'll pass whatever I come
up with there along. Do we have something simple that'll do that already?
(We have to be able to see that it received the data)

-Daryl.
