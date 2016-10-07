Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5EFE62F1AC977B4F94A5BA55F4D506333BF4D43A@DEDC01MBX02.corp.lairdtech.com>
References: <5EFE62F1AC977B4F94A5BA55F4D506333BF4D43A@DEDC01MBX02.corp.lairdtech.com>
From: Emil Lenngren <emil.lenngren@gmail.com>
Date: Fri, 7 Oct 2016 23:02:43 +0200
Message-ID: <CAO1O6scq2h0Y-NNt7oAcDvSVFZB2F2v3VUNQjZDBmy5bTOMhQw@mail.gmail.com>
Subject: Re: Getting the address type of a BLE device
To: Jamie Mccrae <Jamie.Mccrae@lairdtech.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

You are so correct in almost everything you write.

A problem is that some people see the random/public type as a
"property" of the device or device address that isn't much to care
about, while it really should be seen as the 49th bit of the device
address.
For Bluetooth Low Energy, ALWAYS when a device address is passed
around, the address type MUST also be included.
Also if you want some kind of map of device address (key) to some
object (value), you need to include the address type in the key as
well, since there can be two devices having the same device address
but of different types. The probability that this would happen is very
small but can happen if, as you said, some malicious device comes
along.

Bluetooth stacks that only interacts with BLE devices and not classic
devices, normally handles this very well, and in other stacks that
were initially built for classic bluetooth where BLE was added later,
it seems to have been a great challenge to add an extra bit to the
device address. Just as an example, Android's bluetooth stack fails
brutally here on every point all the way from the lowest layers in the
stack up to the application layer. When connecting to a specific BLE
device by device address, you can only enter the 48 bits and not the
address type (and certainly not simply an IRK). Instead Android
maintains a list of "known" devices, where they basically map 48 bits
to a device record which contains if the address is public or random.
Known devices are either bonded devices or devices found in scans
since the latest bluetooth restart. If the device you want to connect
to is not in this map, the stack just makes a wild guess about the
address type. Versions up to Marshmallow tend to guess for a public
address while Nougat seems to guess for a random address, so it's
totally impossible to create a reliable app that connects to an
arbitrary address if you don't do a scan first, even if you know the
address type. An interesting bug is if you first initiate a connection
to a device (where it guesses this is a public address) and after that
you start a scan and have a peripheral that advertises this address
but with random type, Android adds this to its record. Later you
cancel the connection attempt. What it internally did now was to first
add the public address to the white list and later tried to remove the
random address from the white list (which obviously fails), leaving
the public address in the white list while Android thinks it's
empty...

In BLE we also have this problem with private addresses, and the fact
that devices may sometimes use a public address and sometimes a
private address that can be changed any time. Therefore, identifying a
BLE device only by a device address is not really a good idea. It's
first when you have bonded to a device you really know for sure that
you can identify it later, since it's at that point you learn the
IRK/Identity address, or that there is no IRK (which means you should
later identify it with the static/public address that was included in
the advertisement). Apple has made a quite smart approach in their
CoreBluetooth here by simply not exposing any device address but
rather a UUID it generates internally. That way you can always refer
to a device by its UUID and it will automatically take care of IRKs,
random address resolving etc. The only problem with this approach is
that you have to first scan a device before you can use it, and the
fact that you might want to actually use the device address for
something (like identification if you don't use random addresses in
the peripherals). A similar approach is used in Web Bluetooth (see
some discussion at
https://github.com/WebBluetoothCG/web-bluetooth/issues/138).

In either case, if a device you are not bonded to uses resolvable
private addresses, it is impossible to create a user flow to first
scan devices and connect 5 minutes later. With the default time of
changing address each 15 minutes it's pretty high chance that it has
changed after 5 minutes which means you will fail to later connect to
it. Therefore I wouldn't really recommend anyone that develops
peripherals to use resolvable private addresses when the goal is to
establish a connection to non-bonded devices.

This were my thoughts on the topic ;)

/Emil
