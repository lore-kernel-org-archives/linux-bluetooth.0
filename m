Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: No Connected=false event on iPhone app kill.
From: =?utf-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@gmail.com>
In-Reply-To: <CABBYNZJxdzs620LZCAqSEuC4p3goa1=m=Jmh2erxY66NmDFoVg@mail.gmail.com>
Date: Thu, 17 Mar 2016 11:58:08 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C3C308DE-48EE-4A57-8CC7-7B230D0BF6D8@gmail.com>
References: <4590C4C4-A8DB-4318-97E9-9489E1E00257@gmail.com> <CABBYNZLzhTX8rJOzadn0+-WM1+Rr5WZvqQPFtzu46EyFEpj_yg@mail.gmail.com> <DE03A908-C3D3-4467-AB9F-3CD11C2539C7@gmail.com> <CABBYNZKCr53JJGVjPq65_aH8vp3LfCpymPmPPpZ_NwPosWFHSA@mail.gmail.com> <48839EC2-6A8E-4110-8224-229ACCAC5854@gmail.com> <CABBYNZK1G+M-ge+XdBGpwKXw+w6Hau4E3Xc+-KyMr7BDRL1-ug@mail.gmail.com> <55A7F9E2-32E1-4618-8E8A-CEC75F464025@gmail.com> <CABBYNZLEvn4Gw2=ukc8o+WZoaQ13FZSm5cX3xoczGC2D5g1Y0g@mail.gmail.com> <CABBYNZJxdzs620LZCAqSEuC4p3goa1=m=Jmh2erxY66NmDFoVg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

> On 16 Mar 2016, at 15:28, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
> Hi Tõnis,
> 
> On Wed, Mar 16, 2016 at 1:27 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Tõnis,
>> 
>> On Wed, Mar 16, 2016 at 11:07 AM, Tõnis Tiganik <ttiganik@gmail.com> wrote:
>>> Hi Luiz
>>> 
>>>> On 14 Mar 2016, at 10:45, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>>> 
>>>> Hi Tõnis,
>>>> 
>>>> On Fri, Mar 11, 2016 at 11:48 AM, Tõnis Tiganik <ttiganik@gmail.com> wrote:
>>>>> Hi Luiz,
>>>>> 
>>>>>> On 10 Mar 2016, at 16:28, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>>>>> 
>>>>>> Hi Tõnis,
>>>>>> 
>>>>>> On Thu, Mar 10, 2016 at 4:18 PM, Tõnis Tiganik <ttiganik@gmail.com> wrote:
>>>>>>> Hi Luiz
>>>>>>> 
>>>>>>>> On 10 Mar 2016, at 14:00, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>>>>>>> 
>>>>>>>> Hi Tõnis,
>>>>>>>> 
>>>>>>>> On Thu, Mar 10, 2016 at 12:43 PM, Tõnis Tiganik <ttiganik@gmail.com> wrote:
>>>>>>>>> Hello,
>>>>>>>>> 
>>>>>>>>> We have an iPhone app that is acting as a peripheral and bluez connects to it.
>>>>>>>>> 
>>>>>>>>> We do not receive properties changed signal from dbus that you would expect on device disconnection (Device.Connected = false) if we kill the iPhone app. We know the iPhone disconnects from bluez because the bluetooth icon goes from black to grey on the iPhone. We receive the connected=false signal if we turn the bluetooth off on the iPhone(keep the app alive) - in that case everything works correctly.
>>>>>>>> 
>>>>>>>> Check the HCI traces if we don't receive a HCI Disconnect command then
>>>>>>>> it is probably not disconnecting, btw I would imagine it perhaps
>>>>>>>> wouldn't disconnect because there could be other users to GATT/ATT not
>>>>>>>> just the app, in that case you would have to force a disconnect
>>>>>>>> somehow. This btw matches the behavior of BlueZ as peripheral, if the
>>>>>>>> app unregister its services (or is close by the user) the only thing
>>>>>>>> that will happen is a service changed indication telling these
>>>>>>>> services are no longer available, thus the central can know what has
>>>>>>>> happened and take actions such as disconnecting if there are no
>>>>>>>> profiles in use.
>>>>>>> 
>>>>>>> I checked the HCI traces, it looks to me there is a Disconnect command both when I set the bluetooth off and kill the app. I dont know if this should be the case but reasons for command and event are different (0x13 and 0x16)
>>>>>>> 
>>>>>>>       < HCI Command: Disconnect (0x01|0x0006) plen 3
>>>>>>>           handle 64 reason 0x13
>>>>>>>           Reason: Remote User Terminated Connection
>>>>>>>> HCI Event: Command Status (0x0f) plen 4
>>>>>>>           Disconnect (0x01|0x0006) status 0x00 ncmd 1
>>>>>>>> HCI Event: Disconn Complete (0x05) plen 4
>>>>>>>           status 0x00 handle 64 reason 0x16
>>>>>>>           Reason: Connection Terminated by Local Host
>>>>>> 
>>>>>> This is actually initiated by BlueZ according to the logs, and we do
>>>>>> receive a Disconnect Complete so at this point it should be
>>>>>> disconnected. Is there something printed in bluetoothd logs?
>>>>> 
>>>>> Here is the bluetoothd log after we kill the iPhone app. Could the segfault be a problem?
>>>> 
>>>> Are you saying you observed a crash? That could probably cause a
>>>> problem like you saying, since we have no way to disconnect the ATT
>>>> which happens to be a fixed channel the connection would stay up, but
>>>> that doesn't match the logs since we do receive a Disconnect Command.
>>>> 
>>>>> 
>>>>> Mar 11 11:40:10 ubuntu bluetoothd[11289]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0040
>>>>> Mar 11 11:40:10 ubuntu bluetoothd[11289]: Can't store info for private addressed device /org/bluez/hci0/dev_64_03_64_61_1F_35
>>>>> Mar 11 11:40:28 ubuntu kernel: [ 2588.635787] bluetoothd[11289]: segfault at 66303048 ip 000000000049d123 sp 00007fff715108b8 error 4 in bluetoothd[400000+fb000]
>>>> 
>>>> I see so there is a crash, I guess we will need to investigate and fix
>>>> the crash first.
>>>> 
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/device.c:gatt_debug() Service Changed received - start: 0x0034 end: 0x003d
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/device.c:gatt_service_removed() start: 0x0034, end: 0x003d
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: Can't store info for private addressed device /org/bluez/hci0/dev_64_03_64_61_1F_35
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:btd_gatt_client_service_removed() GATT Services Removed - start: 0x0034, end: 0x003d
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_service() Removing GATT service: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_characteristic() Removing GATT characteristic: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char0035
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:notify_client_unref() owner :1.121
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:notify_client_free() owner :1.121
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_descriptor() Removing GATT descriptor: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char0035/desc0037
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_characteristic() Removing GATT characteristic: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char0038
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_descriptor() Removing GATT descriptor: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char0038/desc003a
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_characteristic() Removing GATT characteristic: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char003b
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: src/gatt-client.c:unregister_descriptor() Removing GATT descriptor: /org/bluez/hci0/dev_64_03_64_61_1F_35/service0034/char003b/desc003d
>>>>> Mar 11 11:40:28 ubuntu bluetoothd[11289]: Can't store GATT db for private addressed device /org/bluez/hci0/dev_64_03_64_61_1F_35
>>>> 
>>>> The errors you are seeing here is that we cannot store information of
>>>> private addresses without pairing so the irk is distributed, perhaps
>>>> this is the reason it is crashing. Can you try running with
>>>> valgring/gdb to collect the bracktrace?
>>> 
>>> We are not paired at this moment with the device. Im trying to implement logic where instead of connecting at first we pair with the device and then on subsequent appearances just Connect/ConnectProfile to it.
>>> 
>>> I cannot get it to crash with running the bluetoothd with valgrind (valgrind --leak-check=yes /usr/sbin/bluetoothd -E -d). Everything works as expected then, we get the Connected = false signal.
>>> 
>>> Still, here are the logs from valgrind after we have killed the iPhone app.
>>> http://pastebin.com/raw/6GvxYA22
>> 
>> There is a lot of errors though which valgrind is catching, so there
>> is actually a bug there and it seems the code is a bit over engineered
>> in the handling of service changed since it removing the notification
>> handles automatically. So we will need to fix asap since it will cause
>> crashes.
> 
> Ive sent 2 patches to the list, can you give them a try to see if they
> fix the crashes?

I tried the patches and they did not seem to work unfortunately.

here are the valgrind and btmon logs:
patch 1: http://pastebin.com/raw/pKbLtBAw
patch 2: http://pastebin.com/raw/sW68M3vK

Since this is the first time for me to apply patches, maybe its good to verify my patching/building process?

$ git clone git://git.kernel.org/pub/scm/bluetooth/bluez.git 
$ checkout 5.37 commit

store the 2 patches in .patch files

$ git apply patch1.patch

rebuild the blueZ with:

$ ./configure --enable-experimental && make
$ make install && ln -svf ../libexec/bluetooth/bluetoothd /usr/sbin
$ install -v -dm755 /etc/bluetooth && install -v -m644 src/main.conf /etc/bluetooth/main.conf

run the bluetooth again
$ sudo /usr/sbin/bluetoothd -E -d

verify that it still crashes and try to apply the patch2 as well (without cloning the repo again e.g keeping the patch1 changes)






