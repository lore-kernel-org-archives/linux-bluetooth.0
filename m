Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: ConnectProfile for faster service discovery.
From: =?utf-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@high-mobility.com>
In-Reply-To: <CABBYNZLxPy4kUwhNX94q3s1bLsEPMd+TN-QigMs8cozk8yWAuw@mail.gmail.com>
Date: Wed, 9 Mar 2016 11:54:17 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EEBB0B2D-94A2-4B9D-A719-E6F5CF012159@high-mobility.com>
References: <9D4EB9A8-6F3A-47EE-842C-1049DEC1A5B2@high-mobility.com> <CABBYNZLxPy4kUwhNX94q3s1bLsEPMd+TN-QigMs8cozk8yWAuw@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz, thanks for the reply


> On 08 Mar 2016, at 16:38, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
> Hi Tõnis,
> 
> On Tue, Mar 8, 2016 at 1:15 PM, Tõnis Tiganik
> <ttiganik@high-mobility.com> wrote:
>> Hello, we have implemented our application using BlueZ and DBUS.
>> 
>> All is working rather well but the service/characteristics discovery is slow after Connecting to the device. Our guess is that this is because all of the services are discovered automatically in the connection process and for instance iPhone has a lot of services extra that we are not interested in. For other platforms(iOS, BlueSDK), optional service discovery is supported and it seems to work faster.
>> 
>> After looking into some threads and the device-api.txt it seems ConnectProfile() should be the method to use. However, when connecting to our UUID with the following:
>> 
>> GVariant *UUIDString = g_variant_new("s", "713d0100-503e-4c75-ba94-3148f18d941e");
>> reply = g_dbus_proxy_call_sync(device_proxy, "ConnectProfile", g_variant_new_tuple(&UUIDString, 1),
>>                                           G_DBUS_CALL_FLAGS_NONE, -1, NULL, &error);
>> 
>> the call repeatedly fails with:
>> 
>> GDBus.Error:org.bluez.Error.Failed: Host is down
>> 
>> We know the UUID exists because it is in the Device property UUIDs if we use the normal Connect method that discovers all the services automatically.
>> 
>> Is it possible to connect and only discover the services that our application is interested in?
>> Could it be faster than the normal Connect() method?
> 
> Currently we build a cache the very first time you connect to the
> device then subsequent connects will just check if there are any
> services have changed but that is actually quite fast if nothing has
> changed, this mechanism is present for a while but perhaps you have a
> dated version that don't have this implemented yet.

I’m using blueZ 5.35.
Actually our application currently removes the device (RemoveDevice) after disconnecting. We do this to get the object-added signal the next time the device comes into proximity, so the application knows when to connect to it again.
We also do this to clear out the previous DBUS object, because on disconnect we change the MAC address of the device and because of this BlueZ creates a new Device object. We change the MAC for privacy concerns.

So I guess for this reason the services aren’t cached? Could there be another way to discover only the service we are interested in, without the initial caching?

>> 
>> Im also wondering if there is a signal or some other mechanism to detect when a disconnected but advertising peripheral leaves the central's proximity?
> 
> Well perhaps you want a mechanism to detect if was a link-loss or just
> a regular disconnection initiated by the remote, this is not necessary
> in LE since you can program the kernel to do passive scanning for you
> and reconnect as soon it finds the peripheral is advertising.
> bluetoothd will actually attempt to set this up if your kernel support
> it (requires 3.17 or later).


$  uname -r
4.2.0-30-generic

Im guessing this does not work for us because we do the RemoveDevice on disconnect, so kernel does not reconnect automatically.

We need a mechanism to detect when a disconnected device leaves the proximity eg when the peripheral advertisements stop. It would actually be preferred if we would receive all the advertisement packages(for RSSI for example).

I have tried to move the device away from the computer but I do not receive the properties changed signal for RSSI - Im thinking if we would receive 0 for this we would know the device has leaved the proximity.


> -- 
> Luiz Augusto von Dentz

