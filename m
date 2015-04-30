Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: Add tty HCI driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <8665E2433BC68541A24DFFCA87B70F5B2365DFEB@DFRE01.ent.ti.com>
Date: Thu, 30 Apr 2015 07:58:12 -0700
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Eyal Reizer <eyalreizer@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pavan Savoy <pavan_savoy@ti.com>,
	"Mahaveer, Vishal" <vishalm@ti.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Ziv, Dotan" <dotanz@ti.com>
Message-Id: <E924CD28-8A0C-4F39-AA87-D97185B68786@holtmann.org>
References: <1430380089-2395-1-git-send-email-eyalr@ti.com> <20150430113103.3ad0bfac@lxorguk.ukuu.org.uk> <2A731A0F-6BEB-4614-94E8-90B28BEE2DD9@holtmann.org> <8665E2433BC68541A24DFFCA87B70F5B2365DFEB@DFRE01.ent.ti.com>
To: "Reizer, Eyal" <eyalr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eyal,

>>>> tty_hci driver exposes a /dev/hci_tty character device node, that
>>>> intends to emulate a generic /dev/ttyX device that would be used by
>>>> the user-space Bluetooth stacks to send/receive data to/from the WL
>>>> combo-connectivity chipsets.
>>> 
>>> We have an in kernel bluetooth stack, why do we care about this - how
>>> will people test and debug driver interactions with binary only
>>> bluetooth stacks in userspace ?
>> 
>> NAK to this driver.
>> 
>> If you want to run an external Bluetooth stack, then use HCI User Channel. The
>> functionality already exists.
> 
> This is a pretty old driver that has been written a couple of years back and is being used by customers (including android that use a userspace based stack).
> If there is another driver already available that provides same functionality, of course we will be happy to use it instead. 
> Any idea of where we can get info on the HCI User Channel?

search for my BlueZ for Android presentation from Android Builders Summit from 2014. It has an explanation on how HCI User Channel works.

Otherwise look into bluez.git since it contains a bunch of examples on how to use the HCI User Channel. It is a generic functionality for raw access to the HCI layer. Look for HCI_CHANNEL_USER.

>> We do not want to have two drivers for the same hardware. Work with the
>> Bluetooth stack that is present in the kernel and please stop hacking around it.
>> 
> There are in fact quite a few products that use commercial user space based Bluetooth stacks.
> One reason is that bluez has not been certified but I assume they have other reasons as well.

Please stop this FUD. BlueZ has been qualified multiple times.

And let me tell you this, when doing BlueZ for Android, we went through a lengthy period of qualification and fixing PTS with 65 errata today. I don't know if any commercial stack was actually such a good citizen in ensuring that the certification tools get fixed. And we documented all of it.

Clone the bluez.git tree and look for android/{pts,pics,pixit}-*.txt files. They contain all details for qualifying BlueZ for Android stack.

Regards

Marcel

