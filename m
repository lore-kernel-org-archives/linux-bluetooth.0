Return-Path: <loic.poulain@gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 as serial
 slave
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
 <1502102366-2760-2-git-send-email-loic.poulain@gmail.com>
 <CAL_JsqKxA2pgtjmG-cxy5XPWuRWUiia-weRZDSh4++Vn=QZmqA@mail.gmail.com>
 <8186E2A3-D0AC-498F-8229-78862D363F78@holtmann.org>
 <392e6d51-33d6-1585-6582-1397a0c64852@gmail.com>
 <161632C7-EBBF-47F5-86DC-453E10395B54@holtmann.org>
 <e001e055-10a5-facd-a8e1-57c1bdb78172@gmail.com>
 <FCD47ED6-F01F-4921-97A3-BBC1D0263747@holtmann.org>
 <CALeDE9MeMHtCD8esCcznHjS+z6o7Ezh9dP1OZq=77DuYNS2=2A@mail.gmail.com>
 <0C198B33-8CB6-4D6A-B89F-35D3CD771135@holtmann.org>
From: Loic Poulain <loic.poulain@gmail.com>
Message-ID: <92579650-5eb0-cdf2-405a-7c5be9c54770@gmail.com>
Date: Thu, 17 Aug 2017 12:07:56 +0200
MIME-Version: 1.0
In-Reply-To: <0C198B33-8CB6-4D6A-B89F-35D3CD771135@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


>>> < HCI Command: Broadcom Write UART Clock Setting (0x3f|0x0045) plen 1
>>>         01                                               .
>>>> HCI Event: Command Complete (0x0e) plen 4
>>>       Broadcom Write UART Clock Setting (0x3f|0x0045) ncmd 1
>>>         Status: Unknown HCI Command (0x01)
>>>
>>> And I am seeing fun stuff like failed frame assembly.
>>>
>>> [  888.687594] Bluetooth: hci0: BCM: chip id 94
>>> [  888.687821] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0182
>>> [  892.059023] Bluetooth: hci0: Frame reassembly failed (-84)
>>> [  892.316936] Bluetooth: hci0: BCM: failed to write clock (-56)
>>> [  892.429478] Bluetooth: hci0: BCM (001.002.009) build 0182
>>>
>>> Actually not providing the firmware makes the controller work. It however is stuck ad AA:AA:.. default address. Providing the firmware turns the address active. However then it never completes.
>> I've tried on and off to get the BT working, there seems to lots of
>> options and bits needed including some patches to the bluez [1] stuff
>> but between not quite upstream kernel bits and numerous distros all
>> doing it slightly differently I've never got it to work well.
>>
>> The yocto [1] bits seem fairly representative of some the patches
>> flying around "to get it working" although I'm not sure how many of
>> these are actually required and how many are superfluous with this
>> patch set. There seems to be a firmware required that's not
>> distributed with linux-firmware which would also be nice to resolve.
> Non of these Yocto patches are actually needed. The culprit is the .oper_speed setting to be 4Mbps. Once you reduce that to 921600 thing will start to work smoothly. I sent a patch that takes the .oper_speed out completely and only applies it for the ACPI based devices where we know that it works.
>
> With my patch and the right DT entries for uart0 it actually works with “btattach -B /dev/ttyAMA0 -P bcm”. It will load the firmware, configure it and head towards the right path.
>
> Obviously btattach is only an interim step here. Loic’s patches for serdev integration and changing the DT to expose uart0 as serial-slave for Bluetooth is the right approach. Once Loic’s resends the patches we can get them into bluetooth-next and start merging these towards upstream. After that, Bluetooth should work just out of the box like with any USB dongle.
>
> And the Yocto patches should be abandoned. If using H:5 (aka 3-Wire) instead of H:4 is possible, we could consider it, but as long as the UART wiring doesn’t cause any bit errors, it is not worth it.
>
> That said, I do see a "Bluetooth: hci0: Frame reassembly failed (-84)” error. I need to figure out where that is. Frankly we really need to hexdump the packet when this happens.
>

I also meet this Frame reassembly failure, Seems we receive a 0x00 byte 
from the controller (unknown pkt type).

Regarding the speed, I'm unable to reach 3Mbps, I selected 921600 
because this is the baudrate used by raspbian bt script.

Maybe they had some issues at higher speed (empirical value ?), However 
2Mbps seems ok on my side (need to double check/adjust).

In a second step, need to check If we can use hardware flow control, I 
heard that pin 16&17 are routed to the bcm RTS/CTS.
Since there is no DMA usage, it could help.

Regards,
Loic
