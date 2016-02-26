Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGMRwb4bKO5ZTy3JMz-TxQf3PLs6ZKWobTdnHLHf2c5d3A@mail.gmail.com>
References: <CAEZxfGNt6FPXpk0SQLCxke49M4PVcP5t-JSEnB9S+AXCi0HJgw@mail.gmail.com>
	<CABBYNZJiuQXVGm3AFbSU23mEQB_vEN5D0QFkcZJw=FFdU9Zztw@mail.gmail.com>
	<CAEZxfGNq6DWz_0Rp+_hr0KWwUBkN_gg0tpQssn+ZUnuDv6nhSw@mail.gmail.com>
	<CAEZxfGNRUGHOuLGpVa5NqVi4zvCTMFwNrTqpE2ysLq6_uCoCCg@mail.gmail.com>
	<CAEZxfGOtnPsBRJzKPNLt0cMn+DRo5NExw=NTF60JKSPQgCAiGQ@mail.gmail.com>
	<CABBYNZK4P2XPGiMks35yTqhqP5WfHbuCKJ4dVan+j8oQHugPbw@mail.gmail.com>
	<CABBYNZLR2w2Q9mdH_u4y59YTYghPUFwgDkFcnJ34YF+8wfTsdQ@mail.gmail.com>
	<CAEZxfGNwmoDTvgR3azQSKYOANe=Dn427UynjrR427Y1kjmPniQ@mail.gmail.com>
	<CAEZxfGNXA2hEM19ogKCDDuUqtfmc43=7O+3JTetPqn6KvU98Dw@mail.gmail.com>
	<CABBYNZJBzGXSGjLX4dzKE_EC7uphLHQrxWQJ-ChEVHNifKe3Dw@mail.gmail.com>
	<CAEZxfGNQiqmE4hA+R=a5y8Sk21M6kyK-pj5RBzX-rSGvHMMGzg@mail.gmail.com>
	<CAEZxfGPm+KHjHFfRw4L5PLEQ3EMJ=z9waq5bvuaDcz8JHMHo3w@mail.gmail.com>
	<CAEZxfGMRwb4bKO5ZTy3JMz-TxQf3PLs6ZKWobTdnHLHf2c5d3A@mail.gmail.com>
Date: Fri, 26 Feb 2016 17:34:34 +0200
Message-ID: <CABBYNZ+n6nA-q7VQoF5LLiGmCOqt=P=-HZf3t4YEHyruA2b8EA@mail.gmail.com>
Subject: Re: What does mean "GattServices is nil" ?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

Actually this is caused by the following:

bluetoothd[6917]: Unable to register GATT service with handle 0x0012
for device F1:6F:DE:EC:F1:D6
bluetoothd[6917]: Unable to register GATT service with handle 0x0016
for device F1:6F:DE:EC:F1:D6
bluetoothd[6917]: Unable to register GATT service with handle 0x0019
for device F1:6F:DE:EC:F1:D6

Perhaps you forgot to enable the experimental flags (-E), anyway the
patch Ive mentioned is not yet pushed, I thought you would be able to
pick it for the mailing list.

On Fri, Feb 26, 2016 at 4:59 PM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> After updating to your last patch
> (http://git.kernel.org/cgit/bluetooth/bluez.git/commit/?id=d205d58b285542f845d59cab24793de7c12f4aca),
> here's what I'm seeing now: http://pastebin.com/raw/4CXw36A5
> As you can see, list-attributes doesn't list all attributes anymore ;)
>
> On Thu, Feb 25, 2016 at 3:33 PM, François Beaufort
> <beaufort.francois@gmail.com> wrote:
>> And here's the diff which shows that more services are discovered
>> somehow: https://www.diffchecker.com/m20m9ga1
>>
>> On Thu, Feb 25, 2016 at 3:29 PM, François Beaufort
>> <beaufort.francois@gmail.com> wrote:
>>> Here are bluetoothd logs for Pixel 2015 (working):
>>> http://pastebin.com/raw/uShisSPw
>>> And here are the ones for the Pixel 2013 (failing):
>>> http://pastebin.com/raw/4arEF8qu
>>>
>>> On Thu, Feb 25, 2016 at 3:03 PM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi François,
>>>>
>>>>
>>>> On Thu, Feb 25, 2016 at 3:59 PM, François Beaufort
>>>> <beaufort.francois@gmail.com> wrote:
>>>>> Here's an interesting bit, I've tried with Chromebook Pixel 2013 and
>>>>> Chromebook Pixel 2015 (different chipsets) and the results are
>>>>> differents
>>>>>
>>>>> Chromebook Pixel 2013 fails to get GATT Services:
>>>>> http://pastebin.com/raw/gsi63kWg
>>>>
>>>> Perhaps something else is affecting that, do you have the bluetoothd logs?
>>>>
>>>>> Chromebook Pixel 2015 can discover all of them: http://pastebin.com/raw/z5vr0B3P
>>>>>
>>>>> Does that make some kind of sense?
>>>>>
>>>>> On Wed, Feb 17, 2016 at 6:12 PM, François Beaufort
>>>>> <beaufort.francois@gmail.com> wrote:
>>>>>> I didn't have a chance to try your patches sadly.
>>>>>> Feel free to push them as it will still be valuable for sure.
>>>>>>
>>>>>> On Tue, Feb 16, 2016 at 12:49 PM, Luiz Augusto von Dentz
>>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>>> Hi François,
>>>>>>>
>>>>>>> On Mon, Feb 15, 2016 at 2:32 PM, Luiz Augusto von Dentz
>>>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>>>> Hi François,
>>>>>>>>
>>>>>>>> On Mon, Feb 15, 2016 at 12:20 PM, François Beaufort
>>>>>>>> <beaufort.francois@gmail.com> wrote:
>>>>>>>>> And here are my bluetoothd logs when enabling debug mode:
>>>>>>>>> http://pastebin.com/raw/WjRVrMk5
>>>>>>>>>
>>>>>>>>> bluetoothd[21655]: src/device.c:device_connect_le() Connection attempt
>>>>>>>>> to: F1:6F:DE:EC:F1:D6
>>>>>>>>> bluetoothd[21655]: src/adapter.c:connect_failed_callback() hci0
>>>>>>>>> F1:6F:DE:EC:F1:D6 status 2
>>>>>>>>> bluetoothd[21655]: plugins/policy.c:conn_fail_cb() status 2
>>>>>>>>> bluetoothd[21655]: src/adapter.c:bonding_attempt_complete() hci0
>>>>>>>>> bdaddr F1:6F:DE:EC:F1:D6 type 2 status 0x2
>>>>>>>>> bluetoothd[21655]: src/device.c:device_bonding_complete() bonding
>>>>>>>>> (nil) status 0x02
>>>>>>>>> bluetoothd[21655]: src/device.c:device_bonding_failed() status 2
>>>>>>>>> bluetoothd[21655]: src/adapter.c:resume_discovery()
>>>>>>>>> bluetoothd[21655]: src/device.c:att_connect_cb() connect error:
>>>>>>>>> Transport endpoint is not connected (107)
>>>>>>>>> bluetoothd[21655]: src/adapter.c:connected_callback() hci0 device
>>>>>>>>> F1:6F:DE:EC:F1:D6 connected eir_len 24
>>>>>>>>> bluetoothd[21655]: attrib/gattrib.c:g_attrib_ref() 0x7f3ccfe929b0:
>>>>>>>>> g_attrib_ref=1
>>>>>>>>> bluetoothd[21655]: src/device.c:load_gatt_db() Restoring
>>>>>>>>> F1:6F:DE:EC:F1:D6 gatt database from file
>>>>>>>>> bluetoothd[21655]: src/device.c:load_service() loading service:
>>>>>>>>> 0x0001, end: 0x0007, uuid: 1800
>>>>>>>>> bluetoothd[21655]: src/device.c:load_service() loading service:
>>>>>>>>> 0x0008, end: 0x000b, uuid: 00001801-0000-1000-8000-00805f9b34fb
>>>>>>>>> bluetoothd[21655]: src/device.c:load_service() loading service:
>>>>>>>>> 0x0012, end: 0x0019, uuid: 0000180d-0000-1000-8000-00805f9b34fb
>>>>>>>>> bluetoothd[21655]: src/device.c:load_service() loading service:
>>>>>>>>> 0x001a, end: 0xffff, uuid: 0000180a-0000-1000-8000-00805f9b34fb
>>>>>>>>> bluetoothd[21655]: src/device.c:load_chrc() loading characteristic
>>>>>>>>> handle: 0x0002, value handle: 0x0003, properties 0x000a uuid: 2a00
>>>>>>>>> bluetoothd[21655]: src/device.c:load_chrc() loading characteristic
>>>>>>>>> handle: 0x0004, value handle: 0x0005, properties 0x0002 uuid: 2a01
>>>>>>>>> bluetoothd[21655]: src/device.c:load_chrc() loading characteristic
>>>>>>>>> handle: 0x0006, value handle: 0x0007, properties 0x0002 uuid: 2a04
>>>>>>>>> bluetoothd[21655]: src/device.c:load_chrc() loading characteristic
>>>>>>>>> handle: 0x0009, value handle: 0x000a, properties 0x0020 uuid:
>>>>>>>>> 00002a05-0000-1000-8000-00805f9b34fb
>>>>>>>>> bluetoothd[21655]: src/device.c:load_chrc() loading characteristic
>>>>>>>>> handle: 0x000a, value handle: 0x000b, properties 0x0010 uuid:
>>>>>>>>> 6e400003-b5a3-f393-e0a9-e50e24dcca9e
>>>>>>>>> bluetoothd[21655]: saving characteristic to db failed
>>>>>>>>> bluetoothd[21655]: Unable to load gatt db from file for F1:6F:DE:EC:F1:D6
>>>>>>>>> bluetoothd[21655]: src/gatt-client.c:btd_gatt_client_connected()
>>>>>>>>> Device connected.
>>>>>>>>> bluetoothd[21655]: src/device.c:att_browse_cb() ATT connection successful
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() Primary services found: 5
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() start: 0x0001, end:
>>>>>>>>> 0x0007, uuid: 00001800-0000-1000-8000-00805f9b34fb
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() start: 0x0008, end:
>>>>>>>>> 0x000b, uuid: 00001801-0000-1000-8000-00805f9b34fb
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() start: 0x000c, end:
>>>>>>>>> 0x0011, uuid: 00001530-1212-efde-1523-785feabcd123
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() start: 0x0012, end:
>>>>>>>>> 0x0019, uuid: 0000180d-0000-1000-8000-00805f9b34fb
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() start: 0x001a, end:
>>>>>>>>> 0xffff, uuid: 0000180a-0000-1000-8000-00805f9b34fb
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() Secondary service
>>>>>>>>> discovery failed. ATT ECODE: 0x0a
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() Characteristics found: 1
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() start: 0x0009, end:
>>>>>>>>> 0x000b, value: 0x000a, props: 0x20, uuid: 00002a05-0000-1
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_debug() Failed to initialize gatt-client
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_client_ready_cb() status: failed, error: 10
>>>>>>>>> bluetoothd[21655]: src/device.c:device_svc_resolved()
>>>>>>>>> /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6 err -5
>>>>>>>>> bluetoothd[21655]: src/device.c:gatt_service_removed() start: 0x0001,
>>>>>>>>> end: 0x0007
>>>>>>>>
>>>>>>>> It turns out it was the cache malfunctioning, it does clear the cache
>>>>>>>> properly before storing the services when it changed so you would end
>>>>>>>> up with new and old services which obviously does not work as the
>>>>>>>> ranges tend to overlap.
>>>>>>>
>>>>>>> Have you tried my patches? I will probably push them today if you don't object.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Luiz Augusto von Dentz
>>>>
>>>>
>>>>
>>>> --
>>>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
