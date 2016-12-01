Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJNy918AqPxsp+Fm6-Sv7whX7nHGQZHHaroncw8jn6ecQ@mail.gmail.com>
References: <CAGXr9JFjURuq0brgMGYYU+r_5XedXm4WgS_B-vKLZiWS4WKbrA@mail.gmail.com>
 <CABBYNZ+yMwgGN4+pv7dyog0P8LyME5zVz=RuD=sqXs6csYQBAQ@mail.gmail.com>
 <CAGXr9JHSmQs-wZenHAVCPqpe+jL8b5awywBQ-XtZtqYSVtmcpQ@mail.gmail.com>
 <CABBYNZ+cGzQcspVM0B3wbimsE5sjZS6t9Kk-TZ_qc324aO1Q2Q@mail.gmail.com>
 <CAGXr9JET_-mB1qtOryXpUMhQPTe_ecw84f4kFH+Wv9_WYp3iog@mail.gmail.com>
 <CAGXr9JGBGVy5P0BiGCer=RO4i9D_8qMabaSP0DufaTk3gx6Ryw@mail.gmail.com>
 <CABBYNZ+v7B6gkUZ-a=3maBUmFu-boOduiSDxvcyaJ=Y-HcktCQ@mail.gmail.com>
 <CABBYNZ+jYduJM-5j0tK7-TN0axQA_qdOfdrM+hZvm4_6raKK1g@mail.gmail.com>
 <CAGXr9JEs_SUNBJhRqDoy90HqAkKs4NyamB4_q=qSNcLzyk8WsA@mail.gmail.com> <CABBYNZJNy918AqPxsp+Fm6-Sv7whX7nHGQZHHaroncw8jn6ecQ@mail.gmail.com>
From: Petri Gynther <pgynther@google.com>
Date: Thu, 1 Dec 2016 13:12:41 -0800
Message-ID: <CAGXr9JGXtwsMxfZd-VKNAtWa3M13oYBacxb7RW-skF5b7S1+1Q@mail.gmail.com>
Subject: Re: BlueZ 5.43: HoG peripheral services re-discovered again and again
 on every reconnect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 1, 2016 at 12:21 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Petri,
>
> On Thu, Dec 1, 2016 at 12:15 AM, Petri Gynther <pgynther@google.com> wrote:
>> Hi Luiz,
>>
>> On Wed, Nov 30, 2016 at 1:37 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Petri,
>>>
>>> On Wed, Nov 30, 2016 at 10:36 AM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Petri,
>>>>>
>>>>> This primary services re-discovery on every reconnect is actually now
>>>>> causing a problem for us.
>>>>>
>>>>> Basically, this is what happens:
>>>>> 1. HoG remote control reconnects to BlueZ host for firmware update check.
>>>>> 2. BlueZ starts re-discovering the services of the remote, but doesn't
>>>>> yet complete it.
>>>>> 3. The remote disconnects after being connected for 2 seconds (no
>>>>> firmware update was available, so quickly disconnect to save battery).
>>>>> 4. BlueZ declares the HoG remote "bad" since it couldn't complete step
>>>>> (2). And then, BlueZ ends up removing the HoG remote services from its
>>>>> GATT database completely.
>>>>> 5. On the next reconnect attempt, the remote does not work. Re-pairing
>>>>> is required.
>>>>>
>>>>> Obviously, this is bad for user experience. Therefore, I'm asking:
>>>>> 1. Is there a way to avoid services re-discovery on every reconnect?
>>>>> 2. If the remote control is successfully bonded previously, and BlueZ
>>>>> experiences a problem during reconnect (services re-discovery), can we
>>>>> avoid destroying the bonding and GATT info on BlueZ side? A failed
>>>>> reconnect should not be a reason to remove a bonded device.
>>>>
>>>> The second point should definitely be fixed, but I wonder how the
>>>> firmware update check does actually detects if the host is not doing
>>>> something important before it decides it has to save power. Also if I
>>>> recall this correctly dfu was exactly why some devices needed the
>>>> database check, they boot in dfu mode which has a different database
>>>> but they completely lost the state of service changed subscriptions so
>>>> basically nothing works since all handles are invalid and even if
>>>> service changed would work it would cause a rediscover anyway.
>>>
>>> Checking the code I did not find anything that could have break the
>>> remote services, or perhaps it is the passive scanning/reconnection
>>> logic that gets broken if we failed to discover the services?
>>>
>> 11/12,060343.698  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
>> Primary service discovery failed. ATT ECODE: 0x00
>
> There is something wrong with your setup then, here it reconnect just fine:
>
> https://paste.fedoraproject.org/494521/58036114/
>

Thanks for sharing the above.

Here is the first reconnect attempt from our remote after the services
had been removed on previous failure:

11/12,061843.757  bluez: bluetoothd[3980]:
src/gatt-database.c:connect_cb() New incoming LE ATT connection
11/12,061843.757  bluez: bluetoothd[3980]:
src/device.c:device_attach_att() Elevating security level since LTK is
available
11/12,061843.780  bluez: bluetoothd[3980]:
attrib/gattrib.c:g_attrib_ref() 0x51c360: g_attrib_ref=1
11/12,061843.780  bluez: bluetoothd[3980]:
src/gatt-client.c:btd_gatt_client_connected() Device connected.
11/12,061843.780  bluez: bluetoothd[3980]: src/device.c:load_gatt_db()
Restoring LEFQAU gatt database from file
11/12,061843.783  bluez: bluetoothd[3980]: No cache for LEFQAU
11/12,061843.944  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
MTU exchange complete, with MTU: 23
11/12,061846.226  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
Primary services found: 9
11/12,061846.226  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0001, end: 0x000b, uuid: 00001800-0000-1000-8000-00805f9b34fb
11/12,061846.227  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x000c, end: 0x000f, uuid: 00001801-0000-1000-8000-00805f9b34fb
11/12,061846.227  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0010, end: 0x0022, uuid: 0000180a-0000-1000-8000-00805f9b34fb
11/12,061846.230  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0023, end: 0x0028, uuid: 0000180f-0000-1000-8000-00805f9b34fb
11/12,061846.230  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0029, end: 0x002e, uuid: 00001813-0000-1000-8000-00805f9b34fb
11/12,061846.230  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x002f, end: 0x0037, uuid: 0000fff0-0000-1000-8000-00805f9b34fb
11/12,061846.230  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0038, end: 0x005c, uuid: 00001812-0000-1000-8000-00805f9b34fb
11/12,061846.230  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x005d, end: 0x0070, uuid: f000fef0-0451-4000-b000-000000000000
11/12,061846.232  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0071, end: 0xffff, uuid: f000ffc0-0451-4000-b000-000000000000
11/12,061846.757  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
Secondary service discovery failed. ATT ECODE: 0x10
11/12,061847.497  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
Included services found: 1
11/12,061847.497  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
handle: 0x0039, start: 0x0023, end: 0x0028,uuid:
0000180f-0000-1000-8000-0080
11/12,061847.644  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
Characteristics found: 5
11/12,061847.644  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0002, end: 0x0003, value: 0x0003, props: 0x02, uuid:
00002a00-0000-1
11/12,061847.646  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0004, end: 0x0005, value: 0x0005, props: 0x02, uuid:
00002a01-0000-1
11/12,061847.646  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0006, end: 0x0007, value: 0x0007, props: 0x0a, uuid:
00002a02-0000-1
11/12,061847.648  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0008, end: 0x0009, value: 0x0009, props: 0x08, uuid:
00002a03-0000-1
11/12,061847.648  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x000a, end: 0x000b, value: 0x000b, props: 0x02, uuid:
00002a04-0000-1
11/12,061847.715  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
Characteristics found: 1
11/12,061847.715  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x000d, end: 0x000f, value: 0x000e, props: 0x20, uuid:
00002a05-0000-1
11/12,061847.735  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
Descriptors found: 1
11/12,061847.735  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
handle: 0x000f, uuid: 00002902-0000-1000-8000-00805f9b34fb
11/12,061847.871  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
Characteristics found: 9
11/12,061847.871  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0011, end: 0x0012, value: 0x0012, props: 0x02, uuid:
00002a23-0000-1
11/12,061847.871  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0013, end: 0x0014, value: 0x0014, props: 0x02, uuid:
00002a24-0000-1
11/12,061847.874  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0015, end: 0x0016, value: 0x0016, props: 0x02, uuid:
00002a25-0000-1
11/12,061847.874  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0017, end: 0x0018, value: 0x0018, props: 0x02, uuid:
00002a26-0000-1
11/12,061847.878  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0019, end: 0x001a, value: 0x001a, props: 0x02, uuid:
00002a27-0000-1
11/12,061847.886  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x001b, end: 0x001c, value: 0x001c, props: 0x02, uuid:
00002a28-0000-1
11/12,061847.887  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x001d, end: 0x001e, value: 0x001e, props: 0x02, uuid:
00002a29-0000-1
11/12,061847.888  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x001f, end: 0x0020, value: 0x0020, props: 0x02, uuid:
00002a2a-0000-1
11/12,061847.890  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0021, end: 0x0022, value: 0x0022, props: 0x02, uuid:
00002a50-0000-1
11/12,061848.426  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
Characteristics found: 1
11/12,061848.426  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
start: 0x0024, end: 0x0028, value: 0x0025, props: 0x12, uuid:
00002a19-0000-1

==== again here, early disconnect from remote side ====
11/12,061848.999  bluez: bluetoothd[3980]:
src/adapter.c:dev_disconnected() Device LEFQAU disconnected, reason 3
11/12,061848.999  bluez: bluetoothd[3980]:
src/adapter.c:dev_disconnected() device 0x522c18 paired 1 bonded 1
bonding 0
11/12,061848.999  bluez: bluetoothd[3980]:
src/adapter.c:adapter_remove_connection()
11/12,061848.999  bluez: bluetoothd[3980]:
plugins/policy.c:disconnect_cb() reason 3
11/12,061848.999  bluez: bluetoothd[3980]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr LEFQAU type 1
status 0xe
11/12,061849.000  bluez: bluetoothd[3980]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
11/12,061849.000  bluez: bluetoothd[3980]:
src/device.c:device_bonding_failed() status 14
11/12,061849.001  bluez: bluetoothd[3980]: src/adapter.c:resume_discovery()

==== and again, since the re-discovery of services didn't complete
fully, GATT DB gets cleaned ====
11/12,061849.002  bluez: bluetoothd[3980]:
src/device.c:gatt_service_removed() start: 0x0001, end: 0x000b
11/12,061849.003  bluez: bluetoothd[3980]:
src/device.c:gatt_service_removed() start: 0x000c, end: 0x000f
11/12,061849.004  bluez: bluetoothd[3980]:
src/device.c:gatt_service_removed() start: 0x0010, end: 0x0022
11/12,061849.020  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
Failed to initialize gatt-client
11/12,061849.021  bluez: bluetoothd[3980]:
src/device.c:gatt_client_ready_cb() status: failed, error: 0
11/12,061849.021  bluez: bluetoothd[3980]:
src/device.c:device_svc_resolved() /org/bluez/hci0/dev_LEFQAU err -5
11/12,061849.027  bluez: bluetoothd[3980]: src/device.c:att_disconnected_cb()
11/12,061849.032  bluez: bluetoothd[3980]:
src/device.c:att_disconnected_cb() Connection reset by peer (131)
11/12,061849.049  bluez: bluetoothd[3980]:
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
Cleaning up.
11/12,061849.056  bluez: bluetoothd[3980]:
attrib/gattrib.c:g_attrib_unref() 0x51c360: g_attrib_unref=0

However, in this case, I think this handling is correct.
load_gatt_db() showed "No cache for LEFQAU", so BlueZ has to
re-discover everything from the device over BLE.
But, since the device disconnected in the middle of discovery, BlueZ
couldn't fully populate the GATT DB and has to clean it.
If the device didn't disconnect so quickly, this would have most likely worked.

> But I do agree that we should not reset the db if that was populated
> already, so I will try to fix that.

Yes, once BlueZ does not reset the GATT DB on failed reconnects, this
problem will be solved.
