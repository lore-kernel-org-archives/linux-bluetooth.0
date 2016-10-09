Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sun, 9 Oct 2016 17:52:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jamie Mccrae <Jamie.Mccrae@lairdtech.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Getting the address type of a  BLE device
Message-ID: <20161009145208.GA9550@x1c.P-661HNU-F1>
References: <5EFE62F1AC977B4F94A5BA55F4D506333BF4D43A@DEDC01MBX02.corp.lairdtech.com>
 <20161008060409.GA4638@x1c.P-661HNU-F1>
 <5EFE62F1AC977B4F94A5BA55F4D506333BF4D518@DEDC01MBX02.corp.lairdtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5EFE62F1AC977B4F94A5BA55F4D506333BF4D518@DEDC01MBX02.corp.lairdtech.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jamie,

On Sat, Oct 08, 2016, Jamie Mccrae wrote:
> > There *is* a timeout for discovered but not connected device
> > objects, that will be auto-removed from D-Bus. I think that's 3
> > minutes - maybe what you're referring to? 
> 
> Correct, this is what I am referring to. If someone creates an
> application which performs a scan, then they walk away for 10 minutes
> and come back then try to connect to a device in the list, as far as I
> understand it the type of the address would have been forgotten and a
> connection would not work unless the scan was restarted?

Well, the device wouldn't be in the list anymore, so there'd be nothing
to try to connect to. So yes you'd need to restart the scan to
rediscover the device and recreate a device object for it. This is
intentional cleanup that bluetoothd does for found devices so that we
don't end up with a huge list of unused device objects (which would only
confuse the user when needing to select the right device to connect to).

> > There's already an API for requesting an LE-only scan: the
> > SetDiscoveryFilter method on the Adapter interface (see
> > doc/adapter-api.txt for more info).
> 
> If a scan is performed with no filtering and a dual mode device is
> found, how do you know what type has been returned (will it be the BTC
> device, the BLE device or an device indicating that both services are
> supported)? If it's not currently exposed then my idea would be to
> either have a bitmask value which indicates the type of device
> detected, e.g. 0x00 for BTC device, 0x01 for BLE random only, 0x02 for
> BLE public only, 0x03 for BTC and BLE random, 0x04 for BTC and BLE
> public - or just two separate fields e.g. BTCService: true/false,
> BLEService: null (none), 1 (random), 2 (public). That way applications
> can scan for devices and decide if it's best to connect via BLE or
> BTC.

The LE & BR/EDR D-Bus interface proposal from Szymon (that I mentioned
in my earlier email) would likely be the cleanest way to do this.

> > While we do expose the LE address type through mgmt and bluetoothd
> > tracks it, I realize that we don't expose that further. This is only
> > really an issue if you want to create e.g. an L2CAP socket yourself and
> > connect to the remote device (you provide the address type in the socket
> > address).
> 
> I do understand this is likely just a Qt issue due to how their API
> works: if a scan is performed and then you attempt to connect to a
> device without setting the address type it fails to connect and you
> cannot currently retrieve the address type, but if it was reported
> back then it could be stored with the address and solve this problem
> (I haven't looked at implementations in other languages but I assume
> some might also have this problem).

What API does Qt use to connect? The first connection to LE devices is
usually either through the Pair() or Connect() D-Bus method. Neither one
requires knowledge of the address type. After the initial connection
re-connections are typically done through passive background scanning by
the kernel, and in this case the application also doesn't need knowledge
of the address type.

> > I'm not completely following this. Do you mean that the former is a
> > private address? Changing a private address to static type implies
> > changing two bits of the address value, meaning it's not the same
> > address anymore. As for devices spoofing others, that's one of the
> > reasons pairing exists - you connect to them and if authentication fails
> > you know something's wrong.
> 
> This is only true if you've bonded with the device,

If you're not bonded there's no way to protect against other devices
spoofing the address of the real device,

> the benefit of BLE over BTC is that you can connect to a device and
> interact with it without needing to bond (unless encryption is
> required or a mandatory bond is required for a certain
> characteristic).

That's only true for BR/EDR Security Mode 4, and even that has some
exceptions like SDP.

> If I get two BLE devices, one with the random address
> 01:00:11:22:33:44:55 and then set a public address on the other to
> 00:00:11:22:33:44:55, in the list of devices found in a search using
> BlueZ there is currently nothing to differentiate them via DBUS
> although yes the kernel will know the difference.

I suppose you're referring to the Address property on the Device1
interface? It'd be help understand what exactly your concern is if you
could be more specific in this regard. I'll assume you're talking about
the Address property. This property was originally created for BR/EDR
devices and probably isn't that useful for LE where you need to know the
random vs public information. The new LE-specific D-Bus interface talked
about earlier would provide this missing info.

> > That would only work if the spoofing device has the LTK we share with
> > the "real" device. How would it have gotten it?
> 
> In the previous scenario by spoofing the address and changing the type
> to be opposite of what the real device is, if BlueZ connects and pairs
> with that device instead, that device can then initiate an outgoing
> connection and pair with the real device and any data passing through
> the MITM device can be dumped without knowledge of the BlueZ system.

It would still be a separate device object and shown as a separate entry
in the UI. Its Paired property would also start off as False. I'd expect
this already to provide a fairly good indication to the user that
there's another device around.

> BLE is really pushing for the IoT sector and in my opinion a high
> level of security is essential for this, being unable to differentiate
> between two devices from a user's application is equivalent to having
> no security.

Agreed, but I'm not sure I've fully understood the issue you're seeing,
since we'd still have two D-Bus objects. When these also map to two
entries in the UI, I think that's visually much more obvious to the user
that there are two devices (rather than one), compared to the user
having to look at the address details of each device.

The proposed LE-specific D-Bus interface would provide this information,
but I'd expect the greatest value of it to be for custom L2CAP channels
(where the address type is needed for the L2CAP socket address) rather
than a UI. Even for L2CAP the added value is a bit dubious thanks to the
Profile1 D-Bus interface.

Johan
