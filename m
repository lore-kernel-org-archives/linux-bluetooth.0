Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGO05T2Fo-qrR3G5TwO=bSf5km0DEJQqhJSFRnwoL7W79w@mail.gmail.com>
References: <CAEZxfGPBv4YJwMEMVSeJQmy5fwzgd6ANpwBUXeZeiv2Pox865Q@mail.gmail.com>
	<CABBYNZ+uYqOi7uYNGL6tJkJ5D2Cz=cOxCN5QbpLx1+Z7gC2Jxg@mail.gmail.com>
	<CABBYNZJkLuSo4hAuNMJN3yKXQtx77BnTsEWvPfOQsXR9puCcqw@mail.gmail.com>
	<CAEZxfGM-bzd07TOGG-v27SdDiZTPduDzQw-k6tFxtg5EnR7VLg@mail.gmail.com>
	<CABBYNZ+xrQOzVAq27yzCPiMiJHUa_eevaRKDA86eLV=uHwKNWA@mail.gmail.com>
	<CAEZxfGPWL4HUd4Y1OBzBnGxzDERMGcqnSqhu_b9v4SnPxo90YQ@mail.gmail.com>
	<CABBYNZLrWEbYorjMuzCUNzN+hGCiqyNnzh_YMQfBSN37YcdcBg@mail.gmail.com>
	<CAEZxfGO05T2Fo-qrR3G5TwO=bSf5km0DEJQqhJSFRnwoL7W79w@mail.gmail.com>
Date: Thu, 10 Mar 2016 13:44:35 +0200
Message-ID: <CABBYNZ+uO6wDE+r0A8ZZNNh01_8PeoN=4mTLOZ5n5X=6tRNjuQ@mail.gmail.com>
Subject: Re: Feature Request: Clean the cache upon device disconnection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	=?UTF-8?Q?Giovanni_Ortu=C3=B1o?= <ortuno@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

On Thu, Mar 10, 2016 at 1:41 PM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> Are there more logs I can provide to help diagnose this issue?

D-Bus perhaps would help, but you will probably have to enable
eavesdrop so you can actually see the responses:

https://wiki.ubuntu.com/DebuggingDBus

> On Thu, Mar 10, 2016 at 12:26 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi François,
>>
>> On Thu, Mar 10, 2016 at 1:01 PM, François Beaufort
>> <beaufort.francois@gmail.com> wrote:
>>> On Thu, Mar 10, 2016 at 11:54 AM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi François,
>>>>
>>>> On Thu, Mar 10, 2016 at 12:15 PM, François Beaufort
>>>> <beaufort.francois@gmail.com> wrote:
>>>>> Here are failing bluetoothd and hcidump logs with BlueZ at commit
>>>>> c8a81f43921cf417e270f3b6e0b0118cbc27a58d
>>>>
>>>> git log c8a81f43921cf417e270f3b6e0b0118cbc27a58d
>>>> fatal: bad object c8a81f43921cf417e270f3b6e0b0118cbc27a58d
>>>>
>>>> Seems like it is not a valid object, is this based on upstream?
>>>
>>> It is: http://git.kernel.org/cgit/bluetooth/bluez.git/commit/?id=c8a81f43921cf417e270f3b6e0b0118cbc27a58d
>>
>> Sorry forgot to update since yesterday.
>>
>>>>
>>>>> http://pastebin.com/raw/i416k6aw
>>>>
>>>> I can see the old services being removed and the new one being added:
>>>>
>>>> old services:
>>>> bluetoothd[8323]: src/gatt-client.c:unregister_service() Removing GATT
>>>> service: /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service0012
>>>> bluetoothd[8323]: src/gatt-client.c:unregister_service() Removing GATT
>>>> service: /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service0016
>>>> bluetoothd[8323]: src/gatt-client.c:unregister_service() Removing GATT
>>>> service: /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service0019
>>>>
>>>> new service:
>>>>
>>>> bluetoothd[8323]: src/gatt-client.c:service_create() Exported GATT
>>>> service: /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service000c
>>>> bluetoothd[8323]: src/gatt-client.c:characteristic_create() Exported
>>>> GATT characteristic:
>>>> /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service000c/char000d
>>>> bluetoothd[8323]: src/gatt-client.c:characteristic_create() Exported
>>>> GATT characteristic:
>>>> /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service000c/char000f
>>>> bluetoothd[8323]: src/gatt-client.c:descriptor_create() Exported GATT
>>>> characteristic descriptor:
>>>> /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service000c/char000f/desc0011
>>>> bluetoothd[8323]: src/gatt-client.c:characteristic_create() Exported
>>>> GATT characteristic:
>>>> /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service000c/char0012
>>>>
>>>>
>>>>> http://pastebin.com/raw/5dC9dFiP
>>>>
>>>> So it fails here:
>>>>
>>>> 2016-03-10 11:11:49.083776 < ACL data: handle 32 flags 0x00 dlen 9
>>>>     ATT: Write req (0x12)
>>>>       handle 0x000b value  0x02 0x00
>>>> 2016-03-10 11:11:49.118038 > ACL data: handle 32 flags 0x02 dlen 5
>>>>     ATT: Write resp (0x13)
>>>>
>>>> It is trying to write to handle 0x000b which is not in the range of
>>>> the new services, in fact is probably the service changed
>>>> characteristic CCC:
>>>>
>>>> bluetoothd[8323]: src/device.c:gatt_debug() start: 0x0008, end:
>>>> 0x000b, uuid: 00001801-0000-1000-8000-00805f9b34fb
>>>>
>>>> That is GATT service:
>>>>
>>>> #define GATT_UUID "00001801-0000-1000-8000-00805f9b34fb"
>>>>
>>>> So there is nothing in the logs related to the application, it is
>>>> perhaps something in the above layers, perhaps it could not be
>>>> detecting the service removal properly. I did a quick test here with
>>>> zephyr as peripheral and changing services do actually appear in
>>>> bluetoothctl.
>>>
>>> Do you have a nRF51 Dev Kit you could use to replicate locally this issue?
>>
>> No, but there is nothing we couldn't do with zephyr or BlueZ I
>> suppose. But as I mentioned above it doesn't look like is something
>> that even reached HCI so I suppose there is something else wrong,
>> perhaps you are trying to access objects that don't exist anymore.
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
