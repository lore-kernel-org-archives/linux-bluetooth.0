Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] [PATCH] Bluetooth address specific device
	configuration
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075564788.2720.49.camel@pegasus>
References: <1075316178.553.18.camel@akka.yeti.nocrew.org>
	 <1075355567.26729.65.camel@pegasus>
	 <1075405154.22564.64.camel@akka.yeti.nocrew.org>
	 <1075406315.22564.67.camel@akka.yeti.nocrew.org>
	 <1075563018.2720.19.camel@pegasus>
	 <1075564164.14644.167.camel@akka.yeti.nocrew.org>
	 <1075564788.2720.49.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1075565699.14644.186.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sat, 31 Jan 2004 17:15:00 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

lör 2004-01-31 klockan 16.59 skrev Marcel Holtmann:
> I have seen more. Also misplaced comments ;)

The "char *ref" comment in hcid.h? I understand the kernel people you
referred to before use this type of comment as well. :)

The other three comments do not refer to the if:s but the code inside
each if. So I don't think these are misplaced either.

More places? That's the only comments I know of...

> This is too much and not needed, because we can use memset().

Sure.

> And of course in this case inlining the function is a good idea.

Why is that?

Fredrik
