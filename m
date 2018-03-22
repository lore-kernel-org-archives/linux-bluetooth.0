Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: jay@systech.com
Subject: Re: Bluez 5.49 Segmentation Fault
From: Jay Foster <jay@systech.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
References: <e4a2aaba-6888-6c44-b48d-e954514263b4@systech.com>
 <3101238.RsEhQVg2kc@ix> <7e888e08-ab9f-0a46-7c46-88ada4ca4ca0@systech.com>
Message-ID: <2bfa2cf5-f020-f731-bd82-fbd04a29f74b@systech.com>
Date: Thu, 22 Mar 2018 13:29:08 -0700
MIME-Version: 1.0
In-Reply-To: <7e888e08-ab9f-0a46-7c46-88ada4ca4ca0@systech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 3/22/2018 1:21 PM, Jay Foster wrote:
> On 3/22/2018 1:04 PM, Szymon Janc wrote:
>> Hi Jay,
>>
>> On Thursday, 22 March 2018 20:31:23 CET Jay Foster wrote:
>>> I am experiencing problems with the latest 5.49 version of the bluez
>>> bluetooth daemon.  Attempting to configure the Discoverable property of
>>> an adapter causes the bluetoothd to segmentation fault.  This works
>>> correctly for version 5.48 and earlier.
>>>
>>> The following command demonstrates the bug.
>>>
>>> dbus-send --system --dest=org.bluez --print-reply /org/bluez/hci0
>>> org.freedesktop.DBus.Properties.Set string:org.bluez.Adapter1
>>> string:Discoverable variant:boolean:true
>> I'm not able to reproduce this on 5.49 tag. Could you run bluetoothd 
>> under
>> valgrind and provide the output?
>>
> Unfortunately, no.  valgrind is not available for my target.  I was 
> able to use gdb and get the following backtrace:
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00081768 in btd_adv_manager_refresh ()
> Current language:  auto
> The current source language is "auto; currently asm".
> (gdb) bt
> #0  0x00081768 in btd_adv_manager_refresh ()
> #1  0x00084efc in settings_changed ()
> #2  0x00085020 in new_settings_callback ()
> #3  0x0008a6a8 in property_set_mode_complete ()
> #4  0x000e4384 in request_complete ()
> #5  0x000e4784 in can_read_data ()
> #6  0x000fe32c in watch_callback ()
> #7  0xb6f25f00 in ?? () from /usr/lib/libglib-2.0.so.0
> #8  0xb6f25f00 in ?? () from /usr/lib/libglib-2.0.so.0
>
> Jay
>
It also only seems to happen with a particular BD adapter, a USB dongle.

     Bus 001 Device 006: ID 0a12:0001 Cambridge Silicon Radio, Ltd 
Bluetooth Dongle (HCI mode)

This BD adapter does not support BLE, which might be a factor.

Jay

