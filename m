Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus support
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076277892.6869.39.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076274445.14742.73.camel@akka.yeti.nocrew.org>
	 <1076277892.6869.39.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076279611.14742.130.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sun, 08 Feb 2004 23:33:31 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel

On Sun, 2004-02-08 at 23:04, Marcel Holtmann wrote:
> This is my favourite and we should make it easy to substitute is with
> another storage backend. So the handheld or embedded people can use what
> they thing fits better.

I don't want to complain about your favourite DB, but isn't a binary
database engine like Berkely DB over engineering for storing a handful 
of keys and device names? I mean, we're talking about maybe 50 entries 
max for all common cases.

Textfiles can easily handle 1000+ entries of Bluetooth key pairs
and device names without problems.

> If we have a D-Bus interface, these files (databases) should only be
> modified by the hcid. It is easier to use the Berkeley DB, because you
> don't have to write everything by yourself. The database code includes
> locking stuff for free.

Text based storage is easy I'd say, and a proof of concept is already
implemented too in typically less than 200 lines of code each. :) For
the common cases Berkely DB is heavier, less accessible, and more
difficult to maintain and debug.

That's why I think Berekely DB should be an option, if required, but 
not default storage.

Fredrik
