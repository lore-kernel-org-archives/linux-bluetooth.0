Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <57626C6A.9050606@intel.com>
References: <CAPcThSGPMaqJ9zr5fPWM38YH+2DE5M7a5oBNM4pUa3g1Xdba1w@mail.gmail.com>
 <575A749A.1090409@intel.com> <CAPcThSGtgY=KyAvgtMd2HPTin7uKqNXbTc-4-9ME4ZYGutK1Lg@mail.gmail.com>
 <575FD5FB.4000404@intel.com> <CAPcThSEhPyV5Z1oWOv1_UP6TYVMqj9JVL-yRKnYZde0Jun1uZw@mail.gmail.com>
 <57626C6A.9050606@intel.com>
From: Qingtao Cao <qingtao.cao.au@gmail.com>
Date: Fri, 17 Jun 2016 17:18:43 +1000
Message-ID: <CAPcThSFE5t=WRTQk53LHyk_tV3Bp3O3jRYO9AqjpObAn7dN74w@mail.gmail.com>
Subject: Re: How to initialise bcm4354A2 with 3.10 kernel?
To: Loic Poulain <loic.poulain@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Loic,

I've got feedback from vendor, turns out the hcd file I have been
testing is as a matter of fact, the latest one available from their
github:

https://github.com/sonyxperiadev/device-sony-karin_windy/blob/master/rootdir/system/etc/BCM4356.hcd

So the hcd file should be fine. Given that I have managed to use
brcm_patchram_plus program to achieve the same results as bluedroid to
initialise the BCM4354A2 hardware and I have even used "hcitool cmd"
to send extra dozens of HCI commands sent by bluedroid (as recorded in
btsnoop_hci.log file) right after initialisation, the culprit might
locate in kernel space. So I compared and contrasted bluetooth kernel
stack in my 3.10 kernel tree and the one used by vendor
(git://github.com/sonyxperiadev/kernel) , turns out there indeed has
one file different - msm_serial_hs.c, the high speed uart driver!

commit 67f8f9d4579db3cd7e852ec42801f2748b18d1d2
Author: Humberto Borba <humberos@gmail.com>
Date:   Thu Apr 21 00:03:06 2016 -0300

    drivers: msm_serial_hs: Fix unbalanced IRQ for msm8974

    This path fixes unbalanced IRQ for msm8974 platforms,
    also it fixes bluesleep wakelocks and it saves the battery life.

    Welcome back deep sleep state.

    This issue happened after driver update (for msm8994 platform) on:
    https://github.com/sonyxperiadev/kernel/commit/529ec81e42194fee05bfd18bffc2c95ba796887d

    Signed-off-by: Humberto Borba <humberos@gmail.com>


Well, after I patched above commit, my situation was greatly improved:

1. The HCI inquiry command will receive relevant command status,
inquiry result and inquiry complete events successfully. Previously
the Inquiry result event won't be received until the HCI inquiry
cancel command is sent.

2. The brcm_patchram_plus program won't have to re-send HCI reset
command any more. Previously the 4-second alarm will be triggered
twice to send the HCI reset command 3 times in total.

3. The HCI write simple pairing mode command will receive its command
complete event immediately. Previously using hcitool to send such
command will block and I would have to send another HCI command to
receive relevant command complete status for it (along with that of
the second command)

All above facts made me wondering that HCI events could be stuck by
uart driver and not relayed upwards to bluetooth kernel stack until a
new event is received.


Last but not least, even after applied this commit, there are still
0x00 leading bytes issue (although they could be worked around by my
patch to skip them over), and sometimes I still could run into
hci_reassembly() error:

Apr 12 13:20:58 armv8-generic-okl4 kernel: [21928.544467] Bluetooth:
Packet too short! Ignored. Count: 1 :
Apr 12 13:20:58 armv8-generic-okl4 kernel: [21928.544500] Bluetooth: 04
Apr 12 13:20:58 armv8-generic-okl4 kernel: [21928.544612] Bluetooth:
Frame Reassembly Failed: 84
Apr 12 13:20:58 armv8-generic-okl4 kernel: [21928.544626] Bluetooth:
Received 6 bytes of data:
Apr 12 13:20:58 armv8-generic-okl4 kernel: [21928.544645] Bluetooth: 0e
Apr 12 13:20:58 armv8-generic-okl4 kernel: [21928.544656] Bluetooth: 04
Apr 12 13:20:58 armv8-generic-okl4 kernel: [21928.544665] Bluetooth: 01
Apr 12 13:20:58 armv8-generic-okl4 kernel: [21928.544672] Bluetooth: 08
Apr 12 13:20:58 armv8-generic-okl4 kernel: [21928.544676] Bluetooth: 20
Apr 12 13:20:58 armv8-generic-okl4 kernel: [21928.544680] Bluetooth: 00

As we can see, the h4_recv() callback has been incorrectly invoked
twice by the low level tty driver for only one hci event packet: once
for the first "04" byte and another for the rest of the "04 0e 04 01
08 20 00" packet, which otherwise would have been passed on to hcitool
in usrspace through the HCI socket.

Anyway, I will continue chase this issue up to relevant developer
Humberto Borba :-D

Many thanks again for all your help and guidance throughout this whole week!

Harry


On Thu, Jun 16, 2016 at 7:07 PM, Loic Poulain <loic.poulain@intel.com> wrote:
> Hi Harry,
>
>> I have to say you are shrewd in this respect, if I use baud rate of
>> 115.2K, then the leading "garbage" bytes would no longer be 0x00 as
>> with baud rate of 3M or 4M, e.g.:
>>
>> Above logs are printed when hci_reassembly() returns -84 error code,
>> as we can see, the leading bytes becomes f8 or fc, sometimes even an
>> array of "18 90 90 15 f8". By contrast, if baudrate of 3M/4M is used,
>> the leading bytes seem always be 0x00. So it seems apparent that the
>> leading garbage bytes are related with the baudrate used.
>
>
> Look like some unsync serial bytes.
> This seems definitely related to your firmware.
>
>> Moreover, with baudrate of 4M, I tried avoid downloading BCM43xx.hcd
>> file at all, to my surprise, the hci0 can still be enabled well.
>> "hciconfig -a" reads that the HCI revision has changed from 0x2108
>> (with *.hcd downloaded) to 0x2000 (without *.hcd at all):
>>      HCI Version:  (0x7)  Revision: 0x2000
>>      HCI Version:  (0x7)  Revision: 0x2108
>>
>> with all the other features/link policy/packet types identical. Out of
>> curiosity, what difference could HCI revision make for hardware
>> capability?
>
>
> HCI revision is implementation dependent, vendor can change revision with
> new firmwares (including fixes, capabilities...).
>
>>
>> Further more, when a *.hcd file is downloaded if I use "hcitool cmd"
>> to send the HCI Inquiry command, I can receive the corresponding HCI
>> Inquiry Result event when I send out the HCI Inquiry Cancel commands.
>> However, when the *.hcd file is not used, I received no HCI Inquiry
>> Result event at all. So I guess the firmware patchfile *.hcd is still
>> desirable to configure hardware properly.
>
>
> Indeed, embedded firmware can be buggy, you need the right hcd.
>
> Regards,
> Loic
