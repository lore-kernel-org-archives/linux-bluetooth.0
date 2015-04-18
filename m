Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CADxtLgT5xqHQ53QZvRH_zWSgdg_Ba1YKY6NReeNjQ4pK=oeTvg@mail.gmail.com>
References: <CADxtLgT5xqHQ53QZvRH_zWSgdg_Ba1YKY6NReeNjQ4pK=oeTvg@mail.gmail.com>
Date: Fri, 17 Apr 2015 21:00:21 -0700
Message-ID: <CADxtLgQ=N2qHgD7_Yx44Wu2Y9-EWtgKe+1_m=k=8CGx7yxyu4w@mail.gmail.com>
Subject: Re: BLE device GATT service discovery without pairing?
From: Tony DiCola <tony@tonydicola.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Townsend <kevin@ktownsend.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 17, 2015 at 12:04 PM, Tony DiCola <tony@tonydicola.com> wrote:
> Hi all, I'm using bluez 5.3's dbus API (also running bluetoothd with
> the --experimental option) and wanted to check is it possible to
> connect to a BLE device and discover its GATT services without pairing
> to the device?
>
> I'm using the dbus APIs and see that the device Pair() function docs
> call out that it will perform GATT service discovery.  This matches
> what I see in practice--when I turn on an adapter's discovery with
> StartDiscovery() I start to see nearby BLE devices added to the bluez
> dbus root (with the org.bluez.Device1 interface).  I can connect to
> those devices, but only when I call the device Pair() function do I
> see all the GATT services, characteristics, descriptors, etc. added to
> the bluez dbus root (using the org.bluez.GattService1,
> org.bluez.GattCharacteristic1, etc. interfaces).
>
> However using just the dbus interface is it possible to trigger the
> discovery of all those GATT service, characteristic, etc. objects
> without pairing with a device?  I.e. is there an explicit GATT service
> discovery command for a connected device?
>
> Let me know if the question isn't clear, and thanks for any help foks
> can provide.
>
> -Tony

Just to follow up and close the loop, I went back and realized I
actually am getting all the GATT services, characteristics, etc.
without pairing.  I must have had an issue with what I was trying
earlier and see now after just a device connect call the GATT
information shows up a short while after connecting.

One quick question, is there any easy way to check if a device has
finished its service discovery?  Right now I can watch the bluez
ObjectManager's InterfacesAdded signal to see exactly when GATT
objects are created, or even just poll the bluez dbus object hiearchy
for their existance.  Just curious if there's a more explicit way like
a signal or changed property to know when a device's service discovery
completes.  Thanks!

-Tony
