Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <575FD5FB.4000404@intel.com>
References: <CAPcThSGPMaqJ9zr5fPWM38YH+2DE5M7a5oBNM4pUa3g1Xdba1w@mail.gmail.com>
 <575A749A.1090409@intel.com> <CAPcThSGtgY=KyAvgtMd2HPTin7uKqNXbTc-4-9ME4ZYGutK1Lg@mail.gmail.com>
 <575FD5FB.4000404@intel.com>
From: Qingtao Cao <qingtao.cao.au@gmail.com>
Date: Wed, 15 Jun 2016 10:42:42 +1000
Message-ID: <CAPcThSEhPyV5Z1oWOv1_UP6TYVMqj9JVL-yRKnYZde0Jun1uZw@mail.gmail.com>
Subject: Re: How to initialise bcm4354A2 with 3.10 kernel?
To: lpoulain <loic.poulain@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

Many thanks for your tips!

I have sent emails to double check whether the vendor may have any
updated *.hcd for the BCM4354A2 hardware.

I have to say you are shrewd in this respect, if I use baud rate of
115.2K, then the leading "garbage" bytes would no longer be 0x00 as
with baud rate of 3M or 4M, e.g.:

Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.664791] Bluetooth:
Frame Reassembly Failed: 84
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.664863] Bluetooth:
Received 12 bytes of data:
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.664892] Bluetooth: 18
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.664908] Bluetooth: 90
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.664923] Bluetooth: 90
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.664939] Bluetooth: 15
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.664952] Bluetooth: f8
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.664967] Bluetooth: 04
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.664982] Bluetooth: 0e
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.665000] Bluetooth: 04
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.665015] Bluetooth: 01
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.665028] Bluetooth: 6d
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.665042] Bluetooth: 0c
Apr 10 05:49:00 armv8-generic-okl4 kernel: [ 4434.665057] Bluetooth: 00
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.656159] Bluetooth:
hci0 command 0x0c6d tx timeout
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.664625] Bluetooth:
Frame Reassembly Failed: 84
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.664690] Bluetooth:
Received 8 bytes of data:
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.664717] Bluetooth: fc
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.664732] Bluetooth: 04
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.664747] Bluetooth: 0e
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.664760] Bluetooth: 04
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.664774] Bluetooth: 01
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.664788] Bluetooth: 1a
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.664802] Bluetooth: 0c
Apr 10 05:49:02 armv8-generic-okl4 kernel: [ 4436.664824] Bluetooth: 00
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.656160] Bluetooth:
hci0 command 0x0c1a tx timeout
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.664776] Bluetooth:
Frame Reassembly Failed: 84
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.664838] Bluetooth:
Received 8 bytes of data:
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.664861] Bluetooth: f8
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.664876] Bluetooth: 04
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.664895] Bluetooth: 0e
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.664910] Bluetooth: 04
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.664924] Bluetooth: 01
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.664938] Bluetooth: 24
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.664952] Bluetooth: 0c
Apr 10 05:49:04 armv8-generic-okl4 kernel: [ 4438.664967] Bluetooth: 00
Apr 10 05:49:06 armv8-generic-okl4 kernel: [ 4440.656159] Bluetooth:
hci0 command 0x0c24 tx timeout
Apr 10 05:49:06 armv8-generic-okl4 kernel: [ 4440.663119] Bluetooth:
Packet too short! Ignored. Count: 1 :
Apr 10 05:49:06 armv8-generic-okl4 kernel: [ 4440.663183] Bluetooth: f8

Above logs are printed when hci_reassembly() returns -84 error code,
as we can see, the leading bytes becomes f8 or fc, sometimes even an
array of "18 90 90 15 f8". By contrast, if baudrate of 3M/4M is used,
the leading bytes seem always be 0x00. So it seems apparent that the
leading garbage bytes are related with the baudrate used.

Moreover, with baudrate of 4M, I tried avoid downloading BCM43xx.hcd
file at all, to my surprise, the hci0 can still be enabled well.
"hciconfig -a" reads that the HCI revision has changed from 0x2108
(with *.hcd downloaded) to 0x2000 (without *.hcd at all):
    HCI Version:  (0x7)  Revision: 0x2000
    HCI Version:  (0x7)  Revision: 0x2108

with all the other features/link policy/packet types identical. Out of
curiosity, what difference could HCI revision make for hardware
capability?

Further more, when a *.hcd file is downloaded if I use "hcitool cmd"
to send the HCI Inquiry command, I can receive the corresponding HCI
Inquiry Result event when I send out the HCI Inquiry Cancel commands.
However, when the *.hcd file is not used, I received no HCI Inquiry
Result event at all. So I guess the firmware patchfile *.hcd is still
desirable to configure hardware properly.

Thanks again!

Harry


On Tue, Jun 14, 2016 at 8:01 PM, lpoulain <loic.poulain@intel.com> wrote:
> Hi Harry,
>
>> However, I still found logs that an extra 0x00 byte was skipped over
>> (by my workaround patch) for some HCI_Event packet (otherwise lots of
>> HCI commands would time out because this extra 0x00 byte would fail
>> hci_reassembly()) and start discovery also failed by 0x0C error code
>> (command disallowed).
>
>
> You should ask to the vendor about this issue.
> Maybe:
> - The firmware is buggy or the wrong one.
> - This extra byte is a vendor specific one (for low power mgmt, sw flow
> control...)
>
> What is the behavior if you don't download the hcd ? (using the embedded fw)
> Just in case, you can also try to reduce the operational baudrate (115200).
>
> Regards,
> Loic
