Return-Path: <cyrus@holtmann.org>
Message-ID: <c2a31c480901200525q59b1ab02q554b54ceb4515e47@mail.gmail.com>
Date: Tue, 20 Jan 2009 18:55:38 +0530
From: "sreevani medhahal" <sreevani.medhahal@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Patching 2.6.24
Cc: marcel@holtmann.org
In-Reply-To: <1232292040.5095.18.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090115073034.99AEF1059C@ws1-3.us4.outblaze.com>
	 <1232292040.5095.18.camel@californication>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
On Sun, Jan 18, 2009 at 8:50 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Krishnan,
>>
>>> Is it possible to pull in just the Bluetooth changes in kernel 2.6.27 to 2.6.24? Does it have any other dependencies? I am trying to use 2.6.24 with BlueZ 4.17.
>
>> I have 2.6.24 down as release in January 2008. In Linus years this is an
>>ancient kernel. Please just try to forward port any patches you have
>> with 2.6.24 to 2.6.28 and use just a recent kernel. In the long-term
>> this is the only way to keep you sane. Backporting changes to older
>> kernels are always tricky. Sure it can be done, but nobody with a sane
>> mind is doing it for free.

after  attempting to  patching the 2.6.27 bluetooth changes on to
2.6.24[ie., drivers/bluetooth & net/bluetooth] & used the latest BlueZ
. Tested the same with headsets for music & voice(worked fine),but the
HID device didnt not work. We need to work with bluetooth on 2.6.24 as
there is a dependancy on  the others drivers present in kernel 2.6.24.
For HID over Bluetooth to work does it have a dependancy on other
kernel drivers/modules(apart from drivers/bluetooth & net/bluetooth
modules). Any clues in this regard will be helpful.


Thanks & Regards,
Sreevani M

> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
