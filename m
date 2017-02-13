Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Bluez5.43 stack for bcm4334x chipset
To: Sinthu Raja M <sinthu.raja@mistralsolutions.com>
References: <CAEd-yTTD0TAE86Ts=Doa0QFcMk2_FARQmxVr5zia8eaJ=NZNDA@mail.gmail.com>
 <CAAu3APanyqS-4JdV6yV-nnAKT4bqJjREjUNB3M1Ziq4OHta3XA@mail.gmail.com>
Cc: Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
From: Loic Poulain <loic.poulain@intel.com>
Message-ID: <ff770d8a-2f12-aa54-7273-07f8b244e9a3@intel.com>
Date: Mon, 13 Feb 2017 11:28:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAAu3APanyqS-4JdV6yV-nnAKT4bqJjREjUNB3M1Ziq4OHta3XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raja,


On 12/02/2017 20:56, Barry Byford wrote:
> Hello Raja,
>
> On 12 February 2017 at 16:14, Sinthu Raja M
> <sinthu.raja@mistralsolutions.com> wrote:
>> Hi,
>> I am working on Bluez5.43 stack, cross compiled for ARM v7 and
>> successfully compiled. also ported into the target device. I am using
>> Broadcom bluetooth chip (BCM4334x)The problem is when i do a hciconfig
>> i am getting the following result
>>
>> # hciconfig
>> hci0: Type: Primary  Bus: UART
>> BD Address: 72:8E:6C:AB:DD:A4  ACL MTU: 1021:8  SCO MTU: 64:1
>> DOWN
>> RX bytes:647 acl:0 sco:0 events:32 errors:0
>> TX bytes:407 acl:0 sco:0 commands:32 errors:0
>>
>> 1)  I am not able to scan any devices.  what could be the possible
>> causes ? In my other bluetooth device it is detected as Bluetooth USB
>> Host Controller

Typically meet this issue when running non-patched/embedded bcm firmware.
HCI link is OK but controller functionalities limited. I suppose the 
radio is off.

>>
>> 2) But I am expecting the following result
>> # hciconfig
>> hci0:   Type: BR/EDR  Bus: UART
>>          BD Address: C4:00:49:00:06:D9  ACL MTU: 1021:8  SCO MTU: 64:1
>>          UP RUNNING PSCAN ISCAN
>>          RX bytes:3640 acl:0 sco:0 events:317 errors:0
>>          TX bytes:43776 acl:0 sco:0 commands:311 errors:
>>
>> What modifications I need to be done in hciattach_bcm4334x.c code
>> inorder to get the above output or I need to modify in some other
>> files of Bluez?
> I'm not sure if it is relevant to your situation but on the Raspbery Pi 3
> I need to apply the following patches to BlueZ 5.43 for the BCM43xx
> https://gist.github.com/pelwell/c8230c48ea24698527cd
>
> The issue I see without the patch is that the controller has an
> address of all A's in bluetoothctl.
>
>

Yes, seems to be the point here, check you have the correct 
firmware/patch-file and maybe
update the firmware dir accordingly.


What is your kernel version ?
Broadcom support is integrated in the kernel since Linux 4.1 and It is 
recommended
to use it (via btattach) instead of using hciattach (the old way).


Regards,
Loic
