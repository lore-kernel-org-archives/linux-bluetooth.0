Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: How to initialise bcm4354A2 with 3.10 kernel?
To: Qingtao Cao <qingtao.cao.au@gmail.com>
References: <CAPcThSGPMaqJ9zr5fPWM38YH+2DE5M7a5oBNM4pUa3g1Xdba1w@mail.gmail.com>
 <575A749A.1090409@intel.com>
 <CAPcThSGtgY=KyAvgtMd2HPTin7uKqNXbTc-4-9ME4ZYGutK1Lg@mail.gmail.com>
 <575FD5FB.4000404@intel.com>
 <CAPcThSEhPyV5Z1oWOv1_UP6TYVMqj9JVL-yRKnYZde0Jun1uZw@mail.gmail.com>
Cc: linux-bluetooth@vger.kernel.org
From: Loic Poulain <loic.poulain@intel.com>
Message-ID: <57626C6A.9050606@intel.com>
Date: Thu, 16 Jun 2016 11:07:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAPcThSEhPyV5Z1oWOv1_UP6TYVMqj9JVL-yRKnYZde0Jun1uZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harry,

> I have to say you are shrewd in this respect, if I use baud rate of
> 115.2K, then the leading "garbage" bytes would no longer be 0x00 as
> with baud rate of 3M or 4M, e.g.:
>
> Above logs are printed when hci_reassembly() returns -84 error code,
> as we can see, the leading bytes becomes f8 or fc, sometimes even an
> array of "18 90 90 15 f8". By contrast, if baudrate of 3M/4M is used,
> the leading bytes seem always be 0x00. So it seems apparent that the
> leading garbage bytes are related with the baudrate used.

Look like some unsync serial bytes.
This seems definitely related to your firmware.

> Moreover, with baudrate of 4M, I tried avoid downloading BCM43xx.hcd
> file at all, to my surprise, the hci0 can still be enabled well.
> "hciconfig -a" reads that the HCI revision has changed from 0x2108
> (with *.hcd downloaded) to 0x2000 (without *.hcd at all):
>      HCI Version:  (0x7)  Revision: 0x2000
>      HCI Version:  (0x7)  Revision: 0x2108
>
> with all the other features/link policy/packet types identical. Out of
> curiosity, what difference could HCI revision make for hardware
> capability?

HCI revision is implementation dependent, vendor can change revision 
with new firmwares (including fixes, capabilities...).

>
> Further more, when a *.hcd file is downloaded if I use "hcitool cmd"
> to send the HCI Inquiry command, I can receive the corresponding HCI
> Inquiry Result event when I send out the HCI Inquiry Cancel commands.
> However, when the *.hcd file is not used, I received no HCI Inquiry
> Result event at all. So I guess the firmware patchfile *.hcd is still
> desirable to configure hardware properly.

Indeed, embedded firmware can be buggy, you need the right hcd.

Regards,
Loic
