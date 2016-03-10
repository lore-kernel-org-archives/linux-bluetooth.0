Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: No Connected=false event on iPhone app kill.
From: =?utf-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@gmail.com>
In-Reply-To: <CABBYNZLzhTX8rJOzadn0+-WM1+Rr5WZvqQPFtzu46EyFEpj_yg@mail.gmail.com>
Date: Thu, 10 Mar 2016 16:18:46 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DE03A908-C3D3-4467-AB9F-3CD11C2539C7@gmail.com>
References: <4590C4C4-A8DB-4318-97E9-9489E1E00257@gmail.com> <CABBYNZLzhTX8rJOzadn0+-WM1+Rr5WZvqQPFtzu46EyFEpj_yg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

> On 10 Mar 2016, at 14:00, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
> Hi Tõnis,
> 
> On Thu, Mar 10, 2016 at 12:43 PM, Tõnis Tiganik <ttiganik@gmail.com> wrote:
>> Hello,
>> 
>> We have an iPhone app that is acting as a peripheral and bluez connects to it.
>> 
>> We do not receive properties changed signal from dbus that you would expect on device disconnection (Device.Connected = false) if we kill the iPhone app. We know the iPhone disconnects from bluez because the bluetooth icon goes from black to grey on the iPhone. We receive the connected=false signal if we turn the bluetooth off on the iPhone(keep the app alive) - in that case everything works correctly.
> 
> Check the HCI traces if we don't receive a HCI Disconnect command then
> it is probably not disconnecting, btw I would imagine it perhaps
> wouldn't disconnect because there could be other users to GATT/ATT not
> just the app, in that case you would have to force a disconnect
> somehow. This btw matches the behavior of BlueZ as peripheral, if the
> app unregister its services (or is close by the user) the only thing
> that will happen is a service changed indication telling these
> services are no longer available, thus the central can know what has
> happened and take actions such as disconnecting if there are no
> profiles in use.

I checked the HCI traces, it looks to me there is a Disconnect command both when I set the bluetooth off and kill the app. I dont know if this should be the case but reasons for command and event are different (0x13 and 0x16)

	 < HCI Command: Disconnect (0x01|0x0006) plen 3
	     handle 64 reason 0x13
	     Reason: Remote User Terminated Connection
	 > HCI Event: Command Status (0x0f) plen 4
	     Disconnect (0x01|0x0006) status 0x00 ncmd 1
	 > HCI Event: Disconn Complete (0x05) plen 4
	     status 0x00 handle 64 reason 0x16
	     Reason: Connection Terminated by Local Host

The traces are here:
http://pastebin.com/7ZwF5wkp

> 
>> What is weird is that we receive object-removed signal for all of the bluez dbus stack, even for instance /org/bluez and /org/bluez/hci0. org.bluez also disappears from d-feet.
> 
> That sounds like the adapter has been removed, perhaps it is a driver
> problem after all. Check the logs with btmon it should tell if that
> has happened.

It does not look like the adapter gets removed. I tried to remove the adapter manually and look for similar trace on iPhone app kill but did not find any.

>> 
>> After this if we open the iPhone app and start broadcasting again, the bluez app does not work. If we restart the bluez app everything works as before.
> 
> Probably the adapter is no longer available.
> 
>> Do you have any idea why we do not receive connected = false signal if we kill our connected iPhone app?
>> 
>> Why does the bluez lose its dbus interface if we kill our connected iPhone app?
> 
> See the above explanation.
> 
> -- 
> Luiz Augusto von Dentz

Tõnis

