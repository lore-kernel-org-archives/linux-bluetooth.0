Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Serial Port Profile
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Jeff Corrall <jcorrall@MarchNetworks.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>, "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: 
	<BD26E20D4C7666478518223ABFF0930F12C3A0@orion.marchnetworks.com>
References: <BD26E20D4C7666478518223ABFF0930F12C3A0@orion.marchnetworks.com>
Message-Id: <1037141695.21129.111.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 12 Nov 2002 23:54:48 +0100
Content-Type: text/plain

Hi Jeff,

> I want to use it for a simple cable replacement application.  Taking a look
> at the Bluetooth Profiles Spec, nearly all profiles are based on the SPP.
> So I would see it as being beneficial to provide a SPP that can be used by
> profiles being built in the future.  I'm not exactly sure what the best
> implimentation for this would be to make it usable by future profiles as I
> am just getting familiar with the stack.  So, as far as I can tell to this
> point, an SPP available to a number of other profiles could possibly cut
> down on code re-use and re-development.
> 
> The SPP is mainly for legacy applications, but it is also useful to
> applications that currently do not have profiles in the Bluetooth
> specification.  My particular application is a technology that has
> previously used RS232 but is now being fitted with Bluetooth.  It would be
> really nice if BlueZ supported the cable replacement application.  Rather
> than have users out there creating messy RFCOMM-only connections between
> their devices that do not comply with the profiles specification.

I want to copy some text from the SPP chapter:

---
The applications on both sides are typically legacy applications, able
and wanting to communicate over a serial cable (which in this case is
emulated). But legacy applications cannot know about Bluetooth
procedures for setting up emulated serial cables, which is why they need
help from some sort of Bluetooth-aware helper application on both sides.
(These issues are not explicitly addressed in this profile; the major
concern here is for Bluetooth interoperability.)
---

The Bluetooth Profiles are part of the Bluetooth Specification, but they
are not part of the Bluetooth Protocol Stack. You better should see the
profiles like an how to use the Bluetooth protocol stack document. And
all profiles which are build on top of the SPP have one basic thing in
common - they use the RFCOMM protocol. You may not like the protocol and
I don't like it either, but the way we have implemented it in BlueZ is
clean, efficient and it is easy to use. If you want to use or write an
application which is based on SPP you have to deal which the creation of
RFCOMM connection or on server side you have to accept incoming RFCOMM
connections. And did you find any API or interface in the Bluetooth
Specification or Profiles which describes how to create the RFCOMM
connection?

Our current RFCOMM fits all that you need. For the case you have a
legacy application and want to make it Bluetooth aware you also have two
choises to deal with it.

1. Asssign a /dev/rfcommX device.

The /dev/rfcommX are like any other serial device (/dev/ttySx for
example) and can be used like them. Due the fact that it is not
hardwired to your system you have to tell them to which remote Bluetooth
device they have to connect to. This is done with the rfcomm command:

	rfcomm bind X <bdaddr> <channel>

After that call you really can make use of the emulated serial port. Is
this a messy RFCOMM-only connection or is this the SPP? Or maybe DUN or
LAN? Did it make any difference?

2. Replace the open("/dev/ttySx")

If you have the source code of your application and a little experience
in BSD socket programming you can put the connection code directly into
your application. You have only to replace:

	open("/dev/ttySx")
with
	socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
	bind(...);
	connect(...);

and all write(), read(), select(), poll() and close() calls will work
like they do for your old legacy application. Sounds easy for me to make
current application Bluetooth SPP aware.

The server side is a bit more complicated, but only a little bit. First
you have to go always through the socket, which means something like:

	socket(...);
	listen(...);
	accept(...);

and after that you have to decide if you want to stay in the application
and use the file descriptor (or maybe call it socket descriptor) to send
and receive data. Or you can bind this connection to a /dev/rfcommX and
start your legacy application on it. For an example how this is done,
you can look at the dund application.

Long message with a short meaning: Don't dig to deep into the profiles.

You should start using BlueZ and you will see how easy Bluetooth is in
the Linux World. If you have done TCP/IP programming in the past you are
ready for Bluetooth application programming. You don't have to learn a
new API, because all techniques are common ones.

For your particular application it should be easy to make it Bluetooth
aware, because Bluetooth will only be used as cable replacement.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by: 
To learn the basics of securing your web site with SSL, 
click here to get a FREE TRIAL of a Thawte Server Certificate: 
http://www.gothawte.com/rd522.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
