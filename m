Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9D4EB9A8-6F3A-47EE-842C-1049DEC1A5B2@high-mobility.com>
References: <9D4EB9A8-6F3A-47EE-842C-1049DEC1A5B2@high-mobility.com>
Date: Tue, 8 Mar 2016 16:38:29 +0200
Message-ID: <CABBYNZLxPy4kUwhNX94q3s1bLsEPMd+TN-QigMs8cozk8yWAuw@mail.gmail.com>
Subject: Re: ConnectProfile for faster service discovery.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@high-mobility.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tõnis,

On Tue, Mar 8, 2016 at 1:15 PM, Tõnis Tiganik
<ttiganik@high-mobility.com> wrote:
> Hello, we have implemented our application using BlueZ and DBUS.
>
> All is working rather well but the service/characteristics discovery is slow after Connecting to the device. Our guess is that this is because all of the services are discovered automatically in the connection process and for instance iPhone has a lot of services extra that we are not interested in. For other platforms(iOS, BlueSDK), optional service discovery is supported and it seems to work faster.
>
> After looking into some threads and the device-api.txt it seems ConnectProfile() should be the method to use. However, when connecting to our UUID with the following:
>
> GVariant *UUIDString = g_variant_new("s", "713d0100-503e-4c75-ba94-3148f18d941e");
> reply = g_dbus_proxy_call_sync(device_proxy, "ConnectProfile", g_variant_new_tuple(&UUIDString, 1),
>                                            G_DBUS_CALL_FLAGS_NONE, -1, NULL, &error);
>
> the call repeatedly fails with:
>
> GDBus.Error:org.bluez.Error.Failed: Host is down
>
> We know the UUID exists because it is in the Device property UUIDs if we use the normal Connect method that discovers all the services automatically.
>
> Is it possible to connect and only discover the services that our application is interested in?
> Could it be faster than the normal Connect() method?

Currently we build a cache the very first time you connect to the
device then subsequent connects will just check if there are any
services have changed but that is actually quite fast if nothing has
changed, this mechanism is present for a while but perhaps you have a
dated version that don't have this implemented yet.

>
> Im also wondering if there is a signal or some other mechanism to detect when a disconnected but advertising peripheral leaves the central's proximity?

Well perhaps you want a mechanism to detect if was a link-loss or just
a regular disconnection initiated by the remote, this is not necessary
in LE since you can program the kernel to do passive scanning for you
and reconnect as soon it finds the peripheral is advertising.
bluetoothd will actually attempt to set this up if your kernel support
it (requires 3.17 or later).


-- 
Luiz Augusto von Dentz
