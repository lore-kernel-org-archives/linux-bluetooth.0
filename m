Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
Date: Tue, 21 Sep 2004 13:39:19 -0700
Message-ID: <001801c4a01b$12116eb0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1095798744.5762.4.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

> I will fix 2.6 first, before I will backport it to 2.4.

Sounds good.

> Attached is the full patch that should also fix the RFCOMM 
> part. This is
> again only compile tested, because I had no time to setup a 
> test system.
> The L2CAP solution looks very sane to me, but I am not sure about the
> RFCOMM part and we may will have a locking problem. This really needs
> intensive testing.

Excellent. Thank you very much.

I'll let you know how it works for me.

-Daryl.
