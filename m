Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 12 May 2015 18:16:11 -0700
Message-ID: <CADxtLgRDc_=Y7EiXRUd=26LOZznueAhsxc+YZTE3eMzb+19vcA@mail.gmail.com>
Subject: BLE device advertised manufacturer data cached?
From: Tony DiCola <tony@tonydicola.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Kevin Townsend <kevin@ktownsend.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all, I'm playing with the latest bluez 5.30 and bluetooth low
energy devices and am noticing that the manufacturer data field from a
device's advertisement data appears to be cached somewhere internally.
I wanted to check if this was expected and see if there was any way to
disable that caching or work around getting back stale manufacturer
data.

For some context I'm using bluez 5.30's dbus API and applied these
patches to make the gatt support non-experimental (so I can run
bluetoothd without the --experimental flag):
  https://chromium.googlesource.com/chromiumos/third_party/bluez/+/2b3a91a12c86a5708329edf58d0cea237f319f6f%5E%21/#F0
  https://chromium.googlesource.com/chromiumos/third_party/bluez/+/5755965a9944f158dd8aba63655f2b0a414a1f49%5E%21/#F0
However I've also tried it with the stock 5.30 code and the
--experimental flag and see the same results.

For my device I'm using a Nordic nRF51822-based board that I have
control over the firmware and am using it to send custom advertisement
data for my device.  In my advertisement data I'm sending manufacturer
data that looks like this: 0x07FFFFFF00000001.  This breaks down as
the length of the advertisement section (0x07 bytes), the manufacturer
data advertisement type (0xFF), the testing manufacturer ID (0xFFFF),
and then 4 bytes with a value of 1 (0x00000001).

I see when I enable scanning on an adapter that a device object is
created for my device in bluez's dbus hiearchy.  It has a
ManufacturerData field that looks just like what my advertisement
sends, for example here's the output of the device's dbus tree (using
python):

[ /org/bluez/hci0/dev_C5_25_55_09_6A_B1 ]
    org.bluez.Device1
      Name = UART
      Paired = 0
      Adapter = /org/bluez/hci0
      LegacyPairing = 0
      Alias = UART
      ManufacturerData = dbus.Dictionary({dbus.UInt16(65535):
dbus.Array([dbus.Byte(0), dbus.Byte(0), dbus.Byte(0), dbus.Byte(1)],
signature=dbus.Signature('y'), variant_level=1)},
signature=dbus.Signature('qv'), variant_level=1)
      Connected = 0
      UUIDs = dbus.Array([], signature=dbus.Signature('s'), variant_level=1)
      Address = C5:25:55:09:6A:B1
      Trusted = 0
      Blocked = 0

Everything looks great and the manufacturer data is parsed out as I
expect.  However the problem is when I have the nRF51822 change the
advertised manufacturer data.  For example if I change to
0x07FFFFFF00000002 (so the last 4 bytes change to 0x00000002) I'm not
seeing the updated value in bluez's dbus hierarchy.  When I query the
device object's ManufacturerData property I still see the old value
that ends in 1.  Even if I sit in a loop querying the value every
second for over a minute I still don't see the updated value (for
reference the nRF51822 is advertising this updated value every
second).

I do notice that if I remove the device from bluez's dbus hiearchy (by
getting its parent adapter and calling RemoveDevice on it) then I do
see the device added back with the current/updated ManufacturerData
property.  This makes me think there's something up with the
manufacturer data field getting cached or never being updated.

I wanted to check is this expected behavior, that the manufacturer
data property won't be updated when it changes?  If so is there any
clean way to disable this caching or get access to the most recently
seen/up to date manufacturer data field?

Let me know if anything isn't clear or if perhaps I'm doing something
completely wrong.  Thanks!

-Tony
