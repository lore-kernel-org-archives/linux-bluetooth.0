Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4590C4C4-A8DB-4318-97E9-9489E1E00257@gmail.com>
References: <4590C4C4-A8DB-4318-97E9-9489E1E00257@gmail.com>
Date: Thu, 10 Mar 2016 14:00:30 +0200
Message-ID: <CABBYNZLzhTX8rJOzadn0+-WM1+Rr5WZvqQPFtzu46EyFEpj_yg@mail.gmail.com>
Subject: Re: No Connected=false event on iPhone app kill.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tõnis,

On Thu, Mar 10, 2016 at 12:43 PM, Tõnis Tiganik <ttiganik@gmail.com> wrote:
> Hello,
>
> We have an iPhone app that is acting as a peripheral and bluez connects to it.
>
> We do not receive properties changed signal from dbus that you would expect on device disconnection (Device.Connected = false) if we kill the iPhone app. We know the iPhone disconnects from bluez because the bluetooth icon goes from black to grey on the iPhone. We receive the connected=false signal if we turn the bluetooth off on the iPhone(keep the app alive) - in that case everything works correctly.

Check the HCI traces if we don't receive a HCI Disconnect command then
it is probably not disconnecting, btw I would imagine it perhaps
wouldn't disconnect because there could be other users to GATT/ATT not
just the app, in that case you would have to force a disconnect
somehow. This btw matches the behavior of BlueZ as peripheral, if the
app unregister its services (or is close by the user) the only thing
that will happen is a service changed indication telling these
services are no longer available, thus the central can know what has
happened and take actions such as disconnecting if there are no
profiles in use.

> What is weird is that we receive object-removed signal for all of the bluez dbus stack, even for instance /org/bluez and /org/bluez/hci0. org.bluez also disappears from d-feet.

That sounds like the adapter has been removed, perhaps it is a driver
problem after all. Check the logs with btmon it should tell if that
has happened.
>
> After this if we open the iPhone app and start broadcasting again, the bluez app does not work. If we restart the bluez app everything works as before.

Probably the adapter is no longer available.

> Do you have any idea why we do not receive connected = false signal if we kill our connected iPhone app?
>
> Why does the bluez lose its dbus interface if we kill our connected iPhone app?

See the above explanation.

-- 
Luiz Augusto von Dentz
