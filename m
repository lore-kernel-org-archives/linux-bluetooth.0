Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076282343.6869.65.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076284317.14742.179.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 00:51:57 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 2004-02-09 at 00:19, Marcel Holtmann wrote:
> We try to implement Bluetooth so "org.bluetooth" is ok ;)

Well.. :)

> Do you mean contexts or contents?

I mean context as in "state" and "handle". A file descriptor is an
example of handle that is a reference to a state or object. The hcid
interface as proposed does not have any contexts/states/handles. It's 
just name space separation (modularity) for a bunch of functions.

> I am not really convinced about your argument, because I prefer to have
> more in common with the HCI specification. But the HCI don't have any
> namespace. Let me think about.

We can perhaps have alteranative interfaces for different purposes, if
the difference in semantics is large enough. For example a "standard"
HCI interface with all such methods. (I'm not familiar with HCI myself.)

For example: org.bluez.hci

For stuff that doesn't fit within HCI, or becomes very akward, we
can have other complementary interfaces. GUI applications have other
needs than for example server applications, I suspect. Having
several interfaces for the same things isn't ideal though, but some
overlap for the sake of the HCI standard is perhaps a good idea?

> Lets talk about the namespaces you are thinking of. What makes sense to
> separate?

Some ideas:

   - Name services: including local device, paired and scanned
     names. Preferably using the same "lookup" function, because
     when searching for a name, applications don't want to bother
     where (local/remote/cache/whatever) the name comes from. Given 
     a device address, simply return the name if it's readily
     available.

     Note that since initiating a scan is expensive, this ought
     to be a separate method call.

     Example: org.bluez.name

   - Key/pairing services: including requesting/receiving a pairing
     procedure, link key and PIN management.

     Example: org.bluez.link

   - (Local) device configuration services: activate/deactivate
     devices etc. Link modes? Classes? Or maybe org.bluez.hci will
     be enough for this?

     Example: org.bluez.device

Fredrik
