Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: No Connected=false event on iPhone app kill.
From: =?utf-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@gmail.com>
In-Reply-To: <CABBYNZKCr53JJGVjPq65_aH8vp3LfCpymPmPPpZ_NwPosWFHSA@mail.gmail.com>
Date: Fri, 11 Mar 2016 11:48:41 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <48839EC2-6A8E-4110-8224-229ACCAC5854@gmail.com>
References: <4590C4C4-A8DB-4318-97E9-9489E1E00257@gmail.com> <CABBYNZLzhTX8rJOzadn0+-WM1+Rr5WZvqQPFtzu46EyFEpj_yg@mail.gmail.com> <DE03A908-C3D3-4467-AB9F-3CD11C2539C7@gmail.com> <CABBYNZKCr53JJGVjPq65_aH8vp3LfCpymPmPPpZ_NwPosWFHSA@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On 10 Mar 2016, at 16:28, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
> Hi Tõnis,
> 
> On Thu, Mar 10, 2016 at 4:18 PM, Tõnis Tiganik <ttiganik@gmail.com> wrote:
>> Hi Luiz
>> 
>>> On 10 Mar 2016, at 14:00, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>> 
>>> Hi Tõnis,
>>> 
>>> On Thu, Mar 10, 2016 at 12:43 PM, Tõnis Tiganik <ttiganik@gmail.com> wrote:
>>>> Hello,
>>>> 
>>>> We have an iPhone app that is acting as a peripheral and bluez connects to it.
>>>> 
>>>> We do not receive properties changed signal from dbus that you would expect on device disconnection (Device.Connected = false) if we kill the iPhone app. We know the iPhone disconnects from bluez because the bluetooth icon goes from black to grey on the iPhone. We receive the connected=false signal if we turn the bluetooth off on the iPhone(keep the app alive) - in that case everything works correctly.
>>> 
>>> Check the HCI traces if we don't receive a HCI Disconnect command then
>>> it is probably not disconnecting, btw I would imagine it perhaps
>>> wouldn't disconnect because there could be other users to GATT/ATT not
>>> just the app, in that case you would have to force a disconnect
>>> somehow. This btw matches the behavior of BlueZ as peripheral, if the
>>> app unregister its services (or is close by the user) the only thing
>>> that will happen is a service changed indication telling these
>>> services are no longer available, thus the central can know what has
>>> happened and take actions such as disconnecting if there are no
>>> profiles in use.
>> 
>> I checked the HCI traces, it looks to me there is a Disconnect command both when I set the bluetooth off and kill the app. I dont know if this should be the case but reasons for command and event are different (0x13 and 0x16)
>> 
>>         < HCI Command: Disconnect (0x01|0x0006) plen 3
>>             handle 64 reason 0x13
>>             Reason: Remote User Terminated Connection
>>> HCI Event: Command Status (0x0f) plen 4
>>             Disconnect (0x01|0x0006) status 0x00 ncmd 1
>>> HCI Event: Disconn Complete (0x05) plen 4
>>             status 0x00 handle 64 reason 0x16
>>             Reason: Connection Terminated by Local Host
> 
> This is actually initiated by BlueZ according to the logs, and we do
> receive a Disconnect Complete so at this point it should be
> disconnected. Is there something printed in bluetoothd logs?

Here is the bluetoothd log after we kill the iPhone app. Could the segfault be a problem?

Mar 11 11:40:10 ubuntu bluetoothd[11289]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0040
Mar 11 11:40:10 ubuntu bluetoothd[11289]: Can't store info for private addressed device /org/bluez/hci0/dev_64_03_64_61_1F_35
Mar 11 11:40:28 ubuntu kernel: [ 2588.635787] bluetoothd[11289]: segfault at 66303048 ip 000000000049d123 sp 00007fff715108b8 error 4 in bluetoothd[400000+fb000]
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/device.c:gatt_debug() Service Changed received - start: 0x0034 end: 0x003d
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/device.c:gatt_service_removed() start: 0x0034, end: 0x003d
Mar 11 11:40:28 ubuntu bluetoothd[11289]: Can't store info for private addressed device /org/bluez/hci0/dev_64_03_64_61_1F_35
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:btd_gatt_client_service_removed() GATT Services Removed - start: 0x0034, end: 0x003d
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_service() Removing GATT service: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_characteristic() Removing GATT characteristic: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char0035
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:notify_client_unref() owner :1.121
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:notify_client_free() owner :1.121
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_descriptor() Removing GATT descriptor: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char0035/desc0037
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_characteristic() Removing GATT characteristic: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char0038
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_descriptor() Removing GATT descriptor: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char0038/desc003a
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_characteristic() Removing GATT characteristic: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char003b
Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_descriptor() Removing GATT descriptor: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char003b/desc003d
Mar 11 11:40:28 ubuntu bluetoothd[11289]: Can't store GATT db for private addressed device /org/bluez/hci0/dev_64_03_64_61_1F_35

Also, what I observed was that everything works correctly if I dont call the dbus method StartNotify for our characteristic like this:

        reply = g_dbus_proxy_call_sync(proxy, "StartNotify", NULL, G_DBUS_CALL_FLAGS_NONE, -1, NULL, &error);

Could there be a problem with this call?


> 
>> The traces are here:
>> http://pastebin.com/7ZwF5wkp
>> 
>>> 
>>>> What is weird is that we receive object-removed signal for all of the bluez dbus stack, even for instance /org/bluez and /org/bluez/hci0. org.bluez also disappears from d-feet.
>>> 
>>> That sounds like the adapter has been removed, perhaps it is a driver
>>> problem after all. Check the logs with btmon it should tell if that
>>> has happened.
>> 
>> It does not look like the adapter gets removed. I tried to remove the adapter manually and look for similar trace on iPhone app kill but did not find any.
>> 
>>>> 
>>>> After this if we open the iPhone app and start broadcasting again, the bluez app does not work. If we restart the bluez app everything works as before.
>>> 
>>> Probably the adapter is no longer available.
>>> 
>>>> Do you have any idea why we do not receive connected = false signal if we kill our connected iPhone app?
>>>> 
>>>> Why does the bluez lose its dbus interface if we kill our connected iPhone app?
>>> 
>>> See the above explanation.
>>> 
>>> --
>>> Luiz Augusto von Dentz
>> 
>> Tõnis
>> 
> 
> 
> 
> -- 
> Luiz Augusto von Dentz

