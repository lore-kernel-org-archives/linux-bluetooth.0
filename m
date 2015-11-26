Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: btmrvl: add sysfs commands gpiogap and hscfgcmd
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5e4d2f83202448c0bf610f0d9f610719@SC-EXCH04.marvell.com>
Date: Thu, 26 Nov 2015 05:55:34 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Cathy Luo <cluo@marvell.com>, Xinming Hu <huxm@marvell.com>
Message-Id: <2EA6E50F-AA90-4234-A366-3B7913C8525A@holtmann.org>
References: <1448534238-5508-1-git-send-email-akarwar@marvell.com> <B75B5139-479F-4A9E-9C5B-136B883B64D2@holtmann.org> <5e4d2f83202448c0bf610f0d9f610719@SC-EXCH04.marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

>>> This patch adds support for driver's internal host sleep configuration
>>> via sysfs. gpiogap and hscfgcmd sysfs commands are added for this
>>> purpose.
>>> 
>>> Examples.
>>> 1. Get current gpiogap
>>>  cat /sys/class/bluetooth/hci0/gpiogap 2. Set gpio as 13 and gap as
>>> 100msecs
>>>  echo "0x0d64" > /sys/class/bluetooth/hci0/gpiogap 3. Download host
>>> sleep configuration to firmware.
>>>  echo "1" > /sys/class/bluetooth/hci0/hscfgcmd
>> 
>> explain to me how this is a good API. Keep in mind this is an userspace
>> API and needs to be stable.
>> 
>> If you want to expose a GPIO, why not expose it through the standard
>> Linux kernel GPIO API. Then it becomes easily discoverable via standard
>> sysfs tools. Also you can use standard tools to modify it.
>> 
>> I also do not understand why you need something to set host sleep
>> configuration. Just do this all the time and be done with it.
> 
> Thanks for the review. 
> I wasn't aware about standard linux kernel GPIO API. I will go through below link and check how we can make use of it.
> http://lxr.free-electrons.com/source/Documentation/gpio/sysfs.txt
> 
> Basically we have gpiogap and hscfgcmd debugfs commands. As production kernel doesn't enable CONFIG_DEBUGFS, we tried to do same thing via sysfs.

debugfs things are for testing / debugging purposes and should not be required in production. debugfs is also not an API guarantee. So you can change it any time. With sysfs that is no longer the case. And I am really careful letting any driver add any sysfs APIs.

If you are the first driver needing this, then you need a proper explanation why this would be needed at all. There is no driver / hardware from any manufacturer having the need for anything special exposed via sysfs.

Regards

Marcel

