Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076540221.31726.39.camel@akka.yeti.nocrew.org>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
	 <1076284317.14742.179.camel@akka.yeti.nocrew.org>
	 <1076287085.6869.70.camel@pegasus>
	 <1076311376.14742.202.camel@akka.yeti.nocrew.org>
	 <1076321200.6869.75.camel@pegasus>
	 <1076322129.5263.28.camel@kalkyl.roxen.com>
	 <1076323138.6869.93.camel@pegasus>
	 <1076502776.6281.81.camel@kalkyl.roxen.com>
	 <1076506129.2777.83.camel@pegasus>
	 <1076510103.6281.162.camel@kalkyl.roxen.com>
	 <1076519103.2696.58.camel@pegasus>
	 <1076538332.31726.29.camel@akka.yeti.nocrew.org>
	 <1076539335.3041.28.camel@pegasus>
	 <1076540221.31726.39.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1076541281.3041.38.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 12 Feb 2004 00:14:41 +0100

Hi Fredrik,

> > Why? If you want to deny a paring, you can click cancel on the PIN
> > request.
> 
> Well, you might want to avoid DOS PIN attacks by evil neighbours.

this is more service specific. Maybe we add this later.

> > So lets combine these with (1) and (2). How to present it, is a problem
> > of the UI.
> 
> (1) and (2) is about current devices, that may or may not be configured.
> This is about list/remove configurations, that may or may not have
> devices attached. It's not the same thing, really.

I don't think so, because instead of (1) and (2) we need only a method
that returns the current attached devices.

	hci0 -> 11:22:33:44:55:66
	hci2 -> aa:bb:cc:dd:ee:ff

With this mapping the UI can do the rest.

> > The pairing procedure should be run automaticly on the fist connect, so
> > we shouldn't care about it.
> 
> Uh? You do need a scan to find other devices, don't you?

Yes, but let's talk about this later and concentrate on the device
configuration at the moment.

> > It sounds somekind weird, but it will help in some cases.
> 
> I don't understand why. :)

Let's think about a HID keyboard at boot time. You can't input your PIN,
but the screen can display it. So you tell hcid about a one-time PIN and
try to connect to keyboard in range.

Another point is that some application may want to ask for the PIN
before the connect to the device.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
