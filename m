Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALdY0K7WAnRAoBWLrp2YsmpC35EixpqpByj7bvbL-EqxZkt6=Q@mail.gmail.com>
References: <CALdY0K5NNrrWdY73e44kp+QNxF2dizEyU44ny9k5h1YFQDf21w@mail.gmail.com>
	<CAJdJm_Myxh+i50v+0bMJgDCActz4Na_fZdVbNuNjwCE7Bss_kQ@mail.gmail.com>
	<CALdY0K6u0ZrJM-z7YKd2zmDzPStX2azVO-v4LUa385Ziq4uzOA@mail.gmail.com>
	<CAJdJm_PE5U4ePHg7rb2Q1dxXKy0=5KH1tyjzif0tcuSQCcf6Fg@mail.gmail.com>
	<CALdY0K7WAnRAoBWLrp2YsmpC35EixpqpByj7bvbL-EqxZkt6=Q@mail.gmail.com>
Date: Mon, 17 Mar 2014 16:30:37 +0000
Message-ID: <CALdY0K68bHDmg+7hpi3d_E5Ti+BJd2nCm+O8-DO1YukErFT+WA@mail.gmail.com>
Subject: Re: Bluetooth low energy with gatttool and jawbone
From: Christian Bianchini <christian.bianchini@euservers.net>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Tried to connect with bluez:
$ sudo bluez-simple-agent hci0 DC:7A:F8:10:AF:A5
Creating device failed: org.bluez.Error.ConnectionAttemptFailed: Page Timeout


Stupid question, how do I read the firmware version? Sorry to ask
silly questions but this my first attempt to use this kind of "AT
commands" via GATT

Here is the dump:

HCI sniffer - Bluetooth packet analyzer ver 2.5
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr DC:7A:F8:10:AF:A5 type 1
    interval 96 window 48 initiator_filter 0
    own_bdaddr_type 0 min_interval 40 max_interval 56
    latency 0 supervision_to 42 min_ce 0 max_ce 0
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 70, role master
      bdaddr DC:7A:F8:10:AF:A5 (Random)
< ACL data: handle 70 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0001, end 0xffff
      type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 70 packets 1
> ACL data: handle 70 flags 0x02 dlen 18
    ATT: Read By Group resp (0x11)
      attr handle 0x0001, end group handle 0x0007
      value 0x00 0x18
      attr handle 0x0008, end group handle 0x0008
      value 0x01 0x18
< ACL data: handle 70 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0009, end 0xffff
      type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 70 packets 1
> ACL data: handle 70 flags 0x02 dlen 26
    ATT: Read By Group resp (0x11)
      attr handle 0x0009, end group handle 0x0012
      value 0x54 0x36 0x45 0xe1 0xe5 0x1d 0x3c 0xb5 0x90 0x43 0x58
0x66 0x7e 0xba 0xc9 0xf7
< ACL data: handle 70 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0013, end 0xffff
      type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 70 packets 1
> ACL data: handle 70 flags 0x02 dlen 12
    ATT: Read By Group resp (0x11)
      attr handle 0x0013, end group handle 0xffff
      value 0x0a 0x18
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 70 reason 0x08
    Reason: Connection Timeout

On Fri, Mar 14, 2014 at 5:18 PM, Christian Bianchini
<christian.bianchini@euservers.net> wrote:
> I would like to get the motion data, basically this device has an
> accelerometer inside and maybe a gyro, so I just want to receive these
> information on my pc :)
> I will do some more testing later, probably if I dont answer for a
> while... I will be back on Monday.
>
> In the meantime thanks for your helpful answers!
>
> On Fri, Mar 14, 2014 at 5:07 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi Christian,
>>
>> On Fri, Mar 14, 2014 at 12:19 PM, Christian Bianchini
>> <christian.bianchini@euservers.net> wrote:
>>> You were right!
>>> Something happened, but I am not sure how to continue now, even
>>> because after primary I get some data then the device disconnect
>>> itself.
>>>
>>> $ sudo gatttool -b DC:7A:F8:10:AF:A5 -t random -I
>>> [   ][DC:7A:F8:10:AF:A5][LE]> connect
>>> [CON][DC:7A:F8:10:AF:A5][LE]> primary
>>> [CON][DC:7A:F8:10:AF:A5][LE]>
>>> attr handle: 0x0001, end grp handle: 0x0007 uuid:
>>> 00001800-0000-1000-8000-00805f9b34fb
>>> attr handle: 0x0008, end grp handle: 0x0008 uuid:
>>> 00001801-0000-1000-8000-00805f9b34fb
>>> attr handle: 0x0009, end grp handle: 0x0012 uuid:
>>> f7c9ba7e-6658-4390-b53c-1de5e1453654
>>> attr handle: 0x0013, end grp handle: 0xffff uuid:
>>> 0000180a-0000-1000-8000-00805f9b34fb
>>>
>>> I dont have bluetoothctl, there is special package for ubuntu?
>>
>> To have btmon/bluetoothctl, I think you need a recent BlueZ 5.x, which
>> is not available on Ubuntu (I think even latest Ubuntu uses 4.101, not
>> sure about the development version). So you need to build BlueZ from
>> sources.
>>
>> If you see a disconnect after ~30 seconds, it may be because it is
>> issuing a GATT request which gatttool does not answer (as gatttool
>> does not implement a GATT server). To confirm this, use "hcidump -i
>> hci0 -w jawbone.dump" and send it here. This log will show whether the
>> device is attempting some ATT request (e.g. GATT service discovery).
>> You can also read this log using "hcidump -r jawbone.dump".
>>
>> Another reason for disconnect is a failed pairing attempt.
>>
>> If you can't use BlueZ 5 for some reason, you can try pairing using
>> "sudo bluez-simple-agent hci0 <addr>".
>>
>> All that said, which data specifically do you want to get from the
>> device? On the output above I see a proprietary service at handle
>> 0x0009 and the Device Information service at handle 0x0013 (which is
>> most likely firmware version, serial number etc.). Do you have
>> specifications for the proprietary service?
>>
>> Best Regards,
>> --
>> Anderson Lizardo
>> http://www.indt.org/?lang=en
>> INdT - Manaus - Brazil
>
>
>
> --
> ---------------------------
> Web/Mobile Developer
> Luiis Group
> christian@bianchini.ch



-- 
---------------------------
Web/Mobile Developer
Luiis Group
christian@bianchini.ch
