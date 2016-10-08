Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 8 Oct 2016 09:04:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jamie Mccrae <Jamie.Mccrae@lairdtech.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Getting the address type of a  BLE device
Message-ID: <20161008060409.GA4638@x1c.P-661HNU-F1>
References: <5EFE62F1AC977B4F94A5BA55F4D506333BF4D43A@DEDC01MBX02.corp.lairdtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5EFE62F1AC977B4F94A5BA55F4D506333BF4D43A@DEDC01MBX02.corp.lairdtech.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jamie,

On Fri, Oct 07, 2016, Jamie Mccrae wrote:
> One thing I've noticed that is lacking in BlueZ seems to be the
> inability to get the address type of the devices found in a scan for
> Bluetooth Low Energy scans (not Bluetooth Classic). This is a headache
> in frameworks like Qt. According to a BlueZ 4 -> 5 porting guide when
> a device is detected the Bluetooth daemon holds the address type for 3
> minutes and you should be able to connect or pair with it without
> needing to set the address type (random or private) but this does not
> work at all from Qt. Also (assuming it worked) there is the problem of
> what if a user performs a scan and decides to connect in 5 minutes'
> time? The type of address will have been deleted.

I'm not sure what exactly you're referring to here. There's no timeout
like that for the address type that I'm aware of. There *is* a timeout
for discovered but not connected device objects, that will be
auto-removed from D-Bus. I think that's 3 minutes - maybe what you're
referring to? As long as bluetoothd has a device object it has complete
tracking of the address type (BR/EDR, LE public or LE random).

The private addresses mentioned in the other reply are handled by the
kernel, user space (bluetoothd) always addresses the device using its
identity address and the kernel does the necessary translation based on
IRK availability.

> I propose adding an additional field to the list of devices in a scan
> that will return nothing for BTC devices (or something to indicate it
> is not a BLE device, there is also the option to return something else
> if the device is both a BLE and BTC device combined) or the first byte
> of the BLE address if it is a BLE device.

There's already an API for requesting an LE-only scan: the
SetDiscoveryFilter method on the Adapter interface (see
doc/adapter-api.txt for more info). I don't see how this is related to
the address type topic though (i.e. random vs public) but it does at
least give the BR/EDR vs LE separation.

There's been a proposal from Szymon earlier on this list to have
dediated D-Bus interfaces for BR/EDR and LE on device objects - I think
that would provide a clean way to see what transports a device supports.
Right now you're right that the D-Bus API is lacking and requires
unreliable heuristics, like checking the presence of the Appearance
property (only available for LE).

While we do expose the LE address type through mgmt and bluetoothd
tracks it, I realize that we don't expose that further. This is only
really an issue if you want to create e.g. an L2CAP socket yourself and
connect to the remote device (you provide the address type in the socket
address). That can however be worked around using the Profile D-Bus
interface (see doc/profile-api.txt) that can connect on your behalf and
give the resulting file-descriptor to you. We could either way export
the identity address type info as a property if we add an LE-specific
interface to device objects.

> Right now in Qt it is purely guess work what type of address is
> received and it'd be nice to improve that to make the system workable.
> This means you can detect what type of device it is (great for
> logging), check if it also has BTC service (and decide to connect with
> that) or check if it's using a random address that your device has a
> resolving key for - none of which is possible at the moment.

The main reason why these are not exposed by bluetoothd (they *are*
exposed by the mgmt kernel interface however) is that bluetoothd and the
kernel are supposed to take care of them so you don't have to care. The
kernel does all address resolution using IRKs and bluetoothd reloads the
list of known IRKs from previous pairings to the kernel upon startup.

> It also helps out with a potential MITM issue whereby a device exists
> with a random address and someone clones the address but sets it as a
> static address: how do you know what device you are really pairing
> with?

I'm not completely following this. Do you mean that the former is a
private address? Changing a private address to static type implies
changing two bits of the address value, meaning it's not the same
address anymore. As for devices spoofing others, that's one of the
reasons pairing exists - you connect to them and if authentication fails
you know something's wrong.

> The correct device or the impersonation which could be decrypting all
> data passing through it and passing it to the real device.

That would only work if the spoofing device has the LTK we share with
the "real" device. How would it have gotten it?

Johan
