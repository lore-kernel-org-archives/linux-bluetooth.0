Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25R_B=Xn8VHSpkXVyz95LY--hGU9+GJrEwVBSekRKoo98Q@mail.gmail.com>
References: <CADxtLgT5xqHQ53QZvRH_zWSgdg_Ba1YKY6NReeNjQ4pK=oeTvg@mail.gmail.com>
	<CADxtLgQ=N2qHgD7_Yx44Wu2Y9-EWtgKe+1_m=k=8CGx7yxyu4w@mail.gmail.com>
	<CAHrH25R_B=Xn8VHSpkXVyz95LY--hGU9+GJrEwVBSekRKoo98Q@mail.gmail.com>
Date: Mon, 20 Apr 2015 15:14:25 -0700
Message-ID: <CADxtLgS9N2x7TLBdJwgFKTWRsZ8Row+KpGT-Kg8oUh0tOqYr2Q@mail.gmail.com>
Subject: Re: BLE device GATT service discovery without pairing?
From: Tony DiCola <tony@tonydicola.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Kevin Townsend <kevin@ktownsend.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 17, 2015 at 10:23 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Tony,
>
>> On Fri, Apr 17, 2015 at 9:00 PM, Tony DiCola <tony@tonydicola.com> wrote:
>> On Fri, Apr 17, 2015 at 12:04 PM, Tony DiCola <tony@tonydicola.com> wrote:
>>> Hi all, I'm using bluez 5.3's dbus API (also running bluetoothd with
>>> the --experimental option) and wanted to check is it possible to
>>> connect to a BLE device and discover its GATT services without pairing
>>> to the device?
>>>
>>> I'm using the dbus APIs and see that the device Pair() function docs
>>> call out that it will perform GATT service discovery.  This matches
>>> what I see in practice--when I turn on an adapter's discovery with
>>> StartDiscovery() I start to see nearby BLE devices added to the bluez
>>> dbus root (with the org.bluez.Device1 interface).  I can connect to
>>> those devices, but only when I call the device Pair() function do I
>>> see all the GATT services, characteristics, descriptors, etc. added to
>>> the bluez dbus root (using the org.bluez.GattService1,
>>> org.bluez.GattCharacteristic1, etc. interfaces).
>>>
>>> However using just the dbus interface is it possible to trigger the
>>> discovery of all those GATT service, characteristic, etc. objects
>>> without pairing with a device?  I.e. is there an explicit GATT service
>>> discovery command for a connected device?
>>>
>>> Let me know if the question isn't clear, and thanks for any help foks
>>> can provide.
>>>
>>> -Tony
>>
>> Just to follow up and close the loop, I went back and realized I
>> actually am getting all the GATT services, characteristics, etc.
>> without pairing.  I must have had an issue with what I was trying
>> earlier and see now after just a device connect call the GATT
>> information shows up a short while after connecting.
>>
>> One quick question, is there any easy way to check if a device has
>> finished its service discovery?  Right now I can watch the bluez
>> ObjectManager's InterfacesAdded signal to see exactly when GATT
>> objects are created, or even just poll the bluez dbus object hiearchy
>> for their existance.  Just curious if there's a more explicit way like
>> a signal or changed property to know when a device's service discovery
>> completes.  Thanks!
>>
>
> It's pretty straightforward to know when all the attributes of an
> individual service have been discovered; basically, once all the
> GattCharacteristic1 objects under a service have been exported, the
> "Characteristics" property of the service (GattService1) will be
> updated and you'll receive a PropertiesChanged signal for it.
>
> Finding out that the complete list of services have been discovered
> and the objects have been exported is a bit trickier. Usually, the
> "UUIDs" property on org.bluez.Device1 will be populated before a
> connection with services obtained via advertising/inquiry. Upon
> connection and when GATT/SDP service discovery has completed (and
> after the service objects have been exported), the UUIDs property will
> update with the full list of services. Here you could do something
> like tracking InterfacesAdded signals and comparing the newly added
> services to the initial UUID list.
>
> I would be open to adding a signal/property to notify applications
> when service discovery completes though this hasn't really been an
> issue so far. Usually applications can be built in a very event based
> manner and update their state on a per-service basis as service
> hierarchies get added and removed.
>
> I hope this helps!
> Arman

Thanks for the advice!  Yeah I ended up going with a somewhat simple
approach to look for the existence of certain services and
characteristics I care about beneath the connected device's dbus
hierarchy.  I could get fancier and construct the tree of services,
child characteristics, child descriptors, etc. and look for a specific
hierarchy to consider service discovery complete, but I'd rather keep
it simple for now and just check for the presence of certain key
characteristics & services.

A specific event or property to signal the completion of service
discovery could be useful to think about for the future IMHO.  Since
all the services, characteristics, etc. are discovered asynchronously
I worry there could be subtle race conditions with a simple approach
people might take that just looks for the existence of a service.

For example if I connect to a BLE UART device and wait for the UART
service to be discovered and then start interacting with the service's
RX & TX characteristics, could there be a small window between being
notified of the service existing but the characteristics not yet being
discovered (and attempts to use them failing)?  If so that's why I was
thinking a single event / property that tells you everything is done
would be a little easier for most application code to deal with.  That
way you don't need to try to reconstruct your expected service &
characteristic tree from all the async events--just look for the
service discovery complete event and move on from there.

For now though I think I'm good to just look for the few services and
characteristics I care about being available before using them.
Thanks again for the help!

-Tony
