Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180911174520.g6mw2low6tcm7cvx@lacklustre.net>
References: <20180911174520.g6mw2low6tcm7cvx@lacklustre.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Sep 2018 12:52:56 +0300
Message-ID: <CABBYNZKOS1-654KQ_aUmOBChnBxbi9M3XRx3cemu3_gpkPiMBw@mail.gmail.com>
Subject: Re: Automatically connect via DBUS Device API
To: Mike Ryan <mikeryan@lacklustre.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Tue, Sep 11, 2018 at 8:45 PM, Mike Ryan <mikeryan@lacklustre.net> wrote:
> It would be useful to have a way to automatically connect to previously
> discovered devices via the DBUS Device API.
>
> Current use case: I have BLE devices that become discoverable once they
> have a measurement available. Upon connecting, the measurement is
> notified/indicated and then the connection drops. Some of the devices
> with this behavior support/require pairing, and some do not support
> pairing/encryption.
>
> At present, the only options are to manually connect via DBUS or set the
> device to auto connect via the management API (using Add Device with
> Action set to 2). Since management is root-only, it would be useful to
> move this into DBUS.

Device.Connect should actually set the device to auto connect with use
of Add Device if there is a profile setting the auto_connect flag:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/device.c#n4305

Perhaps there is no matching service or you had not registered the
profile with RegisterApplication:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n355

> Possible workflow:
>
>  1. Discover devices as usual using StartDiscovery() on the adapter
>  2. Pair (if necessary)
>  3. Set new property AutoConnect = true
>  4. bluetoothd scans in background, connects when device becomes
>     available
>
> One concern: a binary AutoConnect may not be sufficient considering the
> management API has three defined actions: background scan (generates an
> event, could be handled via a new Connectable property that generates a
> ProptertiesChanged event), allow incoming connection (connects on
> directed advertising), and auto-connect (connects even on indirect
> advertising).

Is there a use case where you would only connect when it is a directed
advertising vs connectable advertising?

-- 
Luiz Augusto von Dentz
