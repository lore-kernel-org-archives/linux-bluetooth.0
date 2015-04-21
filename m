Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CADxtLgSwN6aYUhC1DaF5Z1fUkqHp0ofkrGzei8NmdEdNVM0daw@mail.gmail.com>
References: <CADxtLgSwN6aYUhC1DaF5Z1fUkqHp0ofkrGzei8NmdEdNVM0daw@mail.gmail.com>
Date: Tue, 21 Apr 2015 13:04:17 -0700
Message-ID: <CAHrH25Rf-TjtXPP=R6=LbRZrh-Bt=NVSmoxjyvAXNG2odRuEig@mail.gmail.com>
Subject: Re: BLE GATT services hidden from users of DBus API by design?
From: Arman Uguray <armansito@chromium.org>
To: Tony DiCola <tony@tonydicola.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Kevin Townsend <kevin@ktownsend.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tony,

> On Tue, Apr 21, 2015 at 12:46 PM, Tony DiCola <tony@tonydicola.com> wrote:
> Hi all, I'm running into an odd issue with bluez's bluetooth low
> energy device support and wanted to check if it's something by design
> or perhaps a bug.  For context I'm using bluez 5.3 and running
> bluetoothd with --experimental to access the GATT objects with the
> dbus API.  Below is a long explanation, but at the end of the mail I
> summarized it into two questions.
>
> The first issue I see is that certain device services, like the device
> information service, are not exposed as GattService and
> GattCharacteristic objects in the dbus hierarchy.
>
> For example I have a BLE UART device I'm working with and after
> connecting and discovering services I see the UUIDs property of the
> device object looks like this (this is just a snippet of the output of
> the get-managed-objects python example script in bluez's source tree):
>
> UUIDs = dbus.Array([dbus.String(u'00001530-1212-efde-1523-785feabcd123'),
> dbus.String(u'00001800-0000-1000-8000-00805f9b34fb'),
> dbus.String(u'00001801-0000-1000-8000-00805f9b34fb'),
> dbus.String(u'0000180a-0000-1000-8000-00805f9b34fb'),
> dbus.String(u'6e400001-b5a3-f393-e0a9-e50e24dcca9e')],
> signature=dbus.Signature('s'), variant_level=1)
>
> I can see a service like 0000180a-0000-1000-8000-00805f9b34fb which is
> the device information service defined by the bluetooth SIG (more info
> here: https://developer.bluetooth.org/gatt/services/Pages/ServiceViewer.aspx?u=org.bluetooth.service.device_information.xml).
>
> However when I look at all the GattService objects created for this
> device I only see two of them, one for the device's UART service and
> another for its DFU firmware update service (both are custom services
> defined by Nordic).  Here's the full DBus tree for these services:
>
> [ /org/bluez/hci0/dev_C5_25_55_09_6A_B1/service0009 ]
>     org.bluez.GattService1
>       Device = /org/bluez/hci0/dev_C5_25_55_09_6A_B1
>       Characteristics =
> dbus.Array([dbus.ObjectPath('/org/bluez/hci0/dev_C5_25_55_09_6A_B1/service0009/char000a'),
> dbus.ObjectPath('/org/bluez/hci0/dev_C5_25_55_09_6A_B1/service0009/char000c'),
> dbus.ObjectPath('/org/bluez/hci0/dev_C5_25_55_09_6A_B1/service0009/char000f')],
> signature=dbus.Signature('o'), variant_level=1)
>       UUID = 00001530-1212-efde-1523-785feabcd123
>       Primary = 1
>
> [ /org/bluez/hci0/dev_C5_25_55_09_6A_B1/service001e ]
>     org.bluez.GattService1
>       Device = /org/bluez/hci0/dev_C5_25_55_09_6A_B1
>       Characteristics =
> dbus.Array([dbus.ObjectPath('/org/bluez/hci0/dev_C5_25_55_09_6A_B1/service001e/char001f'),
> dbus.ObjectPath('/org/bluez/hci0/dev_C5_25_55_09_6A_B1/service001e/char0023')],
> signature=dbus.Signature('o'), variant_level=1)
>       UUID = 6e400001-b5a3-f393-e0a9-e50e24dcca9e
>       Primary = 1
>
> Unfortunately I don't see any GattService objects for the other UUIDs
> associated with the device, like the device info service.
>
> I'm curious are there services like device info that are explicitly
> hidden from users of the DBus API, or does this look like a bug?  If
> it's by design is there any way to access the device info service
> characteristics?  My UART device is a custom hardware design and its
> device info service is built to expose characteristics I need to read
> like its firmware version, software version, etc.  I'm curious how I
> can read these characteristics using bluez's DBus API.
>
> The second issue I see is a similar issue but with the immediate alert
> service (UUID 00001802-0000-1000-8000-00805f9b34fb) on a different
> device.  It looks like bluez is picking up that this device appears to
> be a proximity sensor and not exposing those proximity alert sensor
> services and characteristics in the dbus hierarchy.
>
> The device I'm trying to talk to is a 'smart light bulb' that uses BLE
> to change its color.  I sniffed the protocol and found the bulb is
> actually using/abusing the immediate alert service to control its RGB
> color.  Likely the developers of the bulb rushed through a prototype
> built on existing proximity sensor examples to make it control the
> light's color.  If you want all the gory details you can see a little
> write-up I did about it here:
> https://learn.adafruit.com/reverse-engineering-a-bluetooth-low-energy-light-bulb/overview
> (I also have some python code there that uses the old gatttool to
> control the light bulb, but I'm looking at switching over to the DBus
> API, hence all these questions :)
>
> The problem I'm having talking to this device is that after I connect
> to it I see the immediate alert service listed in the device UUIDs,
> but I don't see a GattService object created that lets me control the
> immediate alert service myself.  I do see the device is assigned the
> ProximityMonitor interface, presumably because bluez sees the device
> advertising the immediate alert service and assumes it's a proximity
> sensor.  The problem is I need to be able to send a non-standard
> string of data to the alert level characteristic, like
> 0x58010301FF00FF0000, and those 0 bytes cause an error when trying to
> set the property in my testing.
>
> Ultimately though the issue is similar to the device information
> service, should I expect bluez to hide the low level GattService
> objects for interfaces that it knows about like proximity sensor?  If
> so, is there any concern about how people might interact with 'bad'
> devices that abuse the specs like this light bulb?  I'm ultimately OK
> with pushing back here since I don't think these devices are common
> and it's not good behavior to abuse the specs.  However it is kind of
> a bummer that there doesn't appear to be any way to control these
> non-standard devices with the DBus API.
>
> So just to summarize the two issues & questions:
>
> - Is it expected that the device information service (UUID
> 0000180a-0000-1000-8000-00805f9b34fb) is hidden and not exposed as a
> GattService object in the DBus hierarchy?  If so, how can folks access
> the characteristics's on the device info service?
>
> - Is it expected that services bluez is natively aware of, like the
> proximity / link loss service, should also not expose GattService
> objects in DBus?  If so, how could someone get low level access to
> these services so they could send whatever data they want to that
> service's characteristics?
>
> Let me know if the questions aren't clear or you'd like more info, thanks!
>

It's all actually a lot simpler than that. Basically, if a bluetoothd
plugin or internal profile claims a GATT service, it won't be exported
over D-Bus to avoid interference. Since you're running bluetoothd with
--experimental, you're enabling a whole bunch of these experimental
plugins that end up claiming GATT services. So, one thing you can do
is to simply modify Makefile.plugins to not compile in any of the
experimental plugins.

Another approach you can take is to make the GATT D-Bus API
non-experimental with a local patch like these:

  https://chromium.googlesource.com/chromiumos/third_party/bluez/+/2b3a91a12c86a5708329edf58d0cea237f319f6f%5E%21/#F0
  https://chromium.googlesource.com/chromiumos/third_party/bluez/+/5755965a9944f158dd8aba63655f2b0a414a1f49%5E%21/#F0

You can then run bluetooth without --experimental and you'll have the
GATT API without any of the experimental plugins.

Let me know if you run into any issues. Thanks!
Arman
