Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Tue, 21 Sep 2004 13:14:43 -0700
Message-ID: <001101c4a017$a45ae9d0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095723182.5731.76.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> for the L2CAP part the attached patch may fixes the problem 
> and let the
> module reference count decrease after the disconnect. The 
> patch is only
> compile tested. May you wanna give it a chance and run your 
> L2CAP tests
> again.

I gave it a try and it works fine as far as I can tell. I had to apply the
patch manually though (I'm assuming this is because you're working with a
2.6 kernel and I'm not).

I don't see the use count incrementing badly any more, and the listening
socket will continue to accept connections after the number of
connects/disconnects have exceeded the the accept queue.

Does this give you any ideas for rfcomm?

-Daryl.
