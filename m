Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <37D1ED5D-6FF5-4ABA-BD2A-222261BE1EAA@holtmann.org>
References: <CAHkwNT=sQQz11YWsxivxb20mW7rh1U=CXTN7uyBqTzkXvNbXgA@mail.gmail.com>
	<37D1ED5D-6FF5-4ABA-BD2A-222261BE1EAA@holtmann.org>
Date: Thu, 1 Oct 2015 19:58:04 +0530
Message-ID: <CAHkwNT=3m4nU5M_Kk5htfDonqPrKZO5vRR0q_8Mn2O=umGMK5Q@mail.gmail.com>
Subject: Re: Issues With USB Bluetooth Dongle
From: Anil Nair <anilcoll90@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

The following is the output from hciconfig,

hci0: Type: BR/EDR  Bus: USB
BD Address: 00:1B:10:00:2A:EC  ACL MTU: 1017:8  SCO MTU: 64:0
DOWN
RX bytes:474 acl:0 sco:0 events:18 errors:0
TX bytes:74 acl:0 sco:0 commands:18 errors:0

Marcel By "btmon" did you mean "bt-monitor"? Running bt-monitor gives me,

No Adapters found.

> include /sys/kernel/debug/usb/devices from this device.

Did you mean the contents in the file? I did not understand.

> Then again, you are running a 3.13 kernel, that is a pretty old kernel.

You want me to try it with the latest stable release?

--
Regards,
Anil Nair
