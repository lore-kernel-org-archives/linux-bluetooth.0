Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Issues With USB Bluetooth Dongle
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHkwNT=3m4nU5M_Kk5htfDonqPrKZO5vRR0q_8Mn2O=umGMK5Q@mail.gmail.com>
Date: Thu, 1 Oct 2015 18:19:02 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B4AA2825-8C58-46FB-A529-7CC910920500@holtmann.org>
References: <CAHkwNT=sQQz11YWsxivxb20mW7rh1U=CXTN7uyBqTzkXvNbXgA@mail.gmail.com> <37D1ED5D-6FF5-4ABA-BD2A-222261BE1EAA@holtmann.org> <CAHkwNT=3m4nU5M_Kk5htfDonqPrKZO5vRR0q_8Mn2O=umGMK5Q@mail.gmail.com>
To: Anil Nair <anilcoll90@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anil,

> The following is the output from hciconfig,
> 
> hci0: Type: BR/EDR  Bus: USB
> BD Address: 00:1B:10:00:2A:EC  ACL MTU: 1017:8  SCO MTU: 64:0
> DOWN
> RX bytes:474 acl:0 sco:0 events:18 errors:0
> TX bytes:74 acl:0 sco:0 commands:18 errors:0

so the device gets detected. Which means the basic part works just fine. Commands are also send and received. Question is just if anything is blocking to bring up the controller.

> 
> Marcel By "btmon" did you mean "bt-monitor"? Running bt-monitor gives me,
> 
> No Adapters found.

use hcidump. You are stuck with BlueZ 4 since Ubuntu refuses to upgrade to BlueZ 5.

>> include /sys/kernel/debug/usb/devices from this device.
> 
> Did you mean the contents in the file? I did not understand.

Yes, there will be section for your controller.

>> Then again, you are running a 3.13 kernel, that is a pretty old kernel.
> 
> You want me to try it with the latest stable release?

That might actually help. Try to run a 4.2 kernel.

Regards

Marcel

