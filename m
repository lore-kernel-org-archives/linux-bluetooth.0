Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADrC6Gzz2fVg5poDov4j4REh6C=2sLEKcUBBfA3M+td9vu7J2w@mail.gmail.com>
References: <CADrC6Gxef2A=EsVLxG-izD4xBKvrBW85wOzybuZCrr-OL52VSw@mail.gmail.com>
	<8737pug8ea.fsf@intel.com>
	<CADrC6Gzz2fVg5poDov4j4REh6C=2sLEKcUBBfA3M+td9vu7J2w@mail.gmail.com>
Date: Tue, 17 May 2016 16:57:14 +0300
Message-ID: <CADrC6GwZPBJzq_zy2mZesihuYGDc47iJTsHPwkNj-6NXd3cMqg@mail.gmail.com>
Subject: Re: bluez dbus ble connection problem when a filter is set
From: =?UTF-8?B?SGFra8SxIEfDtsOnZW/En2x1?= <hakki@bir618.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

I have tested the same problem with the newer kernel
(Linux raspberrypi 4.4.9-v7+ #884 SMP Fri May 6 17:28:59 BST 2016
armv7l GNU/Linux)
the outcome is still the same, is there anything I can do, further
testing etc. ?

Thanks a lot, take care

Hakki

On Sat, May 7, 2016 at 8:12 AM, Hakkı Göçeoğlu <hakki@bir618.com> wrote:
> Hi again, please discard my previous mail I had not seen the second question:
>
>> Which kernel version are you running?
>
> pi@raspberrypi:~ $ uname -a
>
> Linux raspberrypi 4.1.19-v7+ #858 SMP Tue Mar 15 15:56:00 GMT 2016
> armv7l GNU/Linux
>
>> I couldn't reproduce this, can you provide the btmon output when this
>> happens?
>
> I have attached two log outputs, one correct behaviour, and the other
> erratic, on both the flow is the same until the line:
>
> 14:22 src/adapter.c:connected_callback() hci0 device EB:52:CE:B5:A3:52
> connected eir_len 0
>
>  on the correct flow the next four lines:
> 14:22 attrib/gattrib.c:g_attrib_ref() 0x1b7eb8: g_attrib_ref=1
> 14:22 src/gatt-client.c:btd_gatt_client_connected() Device connected.
> 14:22 src/device.c:load_gatt_db() Restoring EB:52:CE:B5:A3:52 gatt
> database from file
> 14:22 No cache for EB:52:CE:B5:A3:52
>
> and on the erratic flow the next six lines:
> 15:17 src/adapter.c:device_found_callback() hci0 addr
> EB:52:CE:B5:A3:52, rssi -48 flags 0x0000 eir_len 21
> 15:17 src/device.c:device_set_legacy() legacy 0
> 15:17 src/device.c:device_set_rssi_with_delta() rssi -48 delta 16
> 15:17 src/device.c:att_connect_cb() connect error: Function not implemented (38)
> 15:17 src/device.c:btd_device_set_temporary() temporary 1
> 15:17 src/adapter.c:dev_disconnected() Device EB:52:CE:B5:A3:52
> disconnected, reason 0
>
> cheers
>
> Hakki
>
>
>
> On Sat, May 7, 2016 at 12:54 AM, Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>> Hi hakkig,
>>
>> Hakkı Göçeoğlu <hakki@bir618.com> writes:
>>
>>> Hi All,
>>>
>>> raspberry pi 3
>>> bluez v5.39
>>> testing platform client/bluetoothctl
>>
>> Which kernel version are you running?
>>
>>>
>>> I have a ble peripheral device advertising a custom uuid.
>>> Within bluetoothctl when I try to connect to it after a filter is set,
>>> one third of the time I get an error.
>>> There is no problem if no filter is set, turning scanning off before
>>> the connect command does not help.
>>>
>>> Here is an example flow within bluetoothctl
>>>
>>> [bluetooth]# set-scan-filter-uuids f655b638-fead-4268-b07c-e5d79d09b22b
>>> SetDiscoveryFilter success
>>> [bluetooth]# scan on
>>> Discovery started
>>> [CHG] Controller B8:27:EB:37:3F:CD Discovering: yes
>>> [NEW] Device CF:05:30:F2:6F:5E CF-05-30-F2-6F-5E
>>> [bluetooth]# connect CF:05:30:F2:6F:5E
>>> Attempting to connect to CF:05:30:F2:6F:5E
>>> [CHG] Device CF:05:30:F2:6F:5E Connected: yes
>>> Failed to connect: org.bluez.Error.Failed
>>> [CHG] Device CF:05:30:F2:6F:5E Connected: no
>>
>> I couldn't reproduce this, can you provide the btmon output when this
>> happens?
>>
>>>
>>>
>>> Any ideas? Thanks in advance, cheers
>>>
>>> hakkig
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> Cheers,
>> --
>> Vinicius
