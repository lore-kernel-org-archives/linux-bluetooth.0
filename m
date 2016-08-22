Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Race condition between DIS and HoG profiles
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <96447190-1a92-5864-f4f6-cfe9898da242@atomos.com>
 <CABBYNZL1oW9DdEXD3teMfudzwp540pWZnZ1zun0Az6D6qn2tcw@mail.gmail.com>
CC: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
From: Leigh Fiddes <leigh.fiddes@atomos.com>
Message-ID: <deff2fac-9315-0773-004b-6a520c7ced47@atomos.com>
Date: Mon, 22 Aug 2016 13:45:56 +1000
MIME-Version: 1.0
In-Reply-To: <CABBYNZL1oW9DdEXD3teMfudzwp540pWZnZ1zun0Az6D6qn2tcw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


On 19/08/16 20:36, Luiz Augusto von Dentz wrote:
> Hi Leigh,
>
> On Fri, Aug 19, 2016 at 9:29 AM, Leigh Fiddes <leigh.fiddes@atomos.com> wrote:
>> Hi,
>>
>> In November 2012 an issue was identified in which the uhid device was
>> being created before the DIS information had been retrieved. This cause
>> the input device to not have the correct vendor and product identifiers.
>> See the message http://www.spinics.net/lists/linux-bluetooth/msg31931.html
>>
>> The patch proposed was not included and I have not seen any discussion as to why.
>>
>> I am seeing this exact problem with Bluez 5.41 on Linux 4.1 with a
>> Nordic nRF51 development board as the peripheral. Some snippets from the
>> /var/log/messages show the result.
>>
>>
>> Jan  1 00:02:54 bluetoothd[714]: src/device.c:device_probe_profiles() Probing profiles for device C0:58:9E:9D:A6:FF
>> Jan  1 00:02:54 bluetoothd[714]: profiles/input/hog.c:hog_probe() path /org/bluez/hci0/dev_C0_58_9E_9D_A6_FF
>> Jan  1 00:02:54 bluetoothd[714]: profiles/input/hog.c:hog_device_new() name=Nordic_Mouse vendor=0x0, product=0x0, version=0x0
>>
>> Jan  1 00:02:55 bluetoothd[714]: profiles/deviceinfo/deviceinfo.c:read_pnpid_cb() Vendor 1915 Product EEEE Version 0001
>>
>> Jan  1 00:02:57 kernel: [  179.706068] input: Nordic_Mouse as /devices/virtual/misc/uhid/0005:0000:0000.0001/input/input2
>> Jan  1 00:02:57 kernel: [  179.706681] hid-generic 0005:0000:0000.0001:input: BLUETOOTH HID v0.00 Mouse [Nordic_Mouse] on 00:1A:7D:DA:71:13
>> Jan  1 00:02:57 bluetoothd[714]: profiles/input/hog-lib.c:report_map_read_cb() HoG created uHID device
>>
>> interestingly, if I stop and restart bluetoothd without changing
>> anything else the correct input is created, since the vendor, product
>> and version are now valid
>>
>> Jan  1 00:04:14 kernel: [  256.476283] input: Nordic_Mouse as /devices/virtual/misc/uhid/0005:1915:EEEE.0002/input/input3
>> Jan  1 00:04:14 bluetoothd[773]: profiles/input/hog-lib.c:report_map_read_cb() HoG created uHID device
>> Jan  1 00:04:14 bluetoothd[773]: attrib/gattrib.c:g_attrib_unref() 0xad4e78: g_attrib_unref=2
>> Jan  1 00:04:14 kernel: [  256.477313] hid-generic 0005:1915:EEEE.0002:input: BLUETOOTH HID v0.01 Mouse [Nordic_Mouse] on 00:1A:7D:DA:71:13
>>
>> Is this a problem for anyone else?
> I guess this would be a problem only if the device requires a specific
> driver, or are you saying it doesn't work the first time either? We
> should be able to fix the this problem by checking the profile
> priority and have DIS before HoG in case the generic HID driver
> doesn't work.
>
It doesn't appear to cause me any issues as far as I can see. In my
case, /dev/input/event2 is created
correctly both the first and subsequent times, and events are sent
correctly.
It just didn't look right and I was interested in why it had not been
addressed. For me the issue is not urgent.
Leigh


