Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: Add tty HCI driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150430113103.3ad0bfac@lxorguk.ukuu.org.uk>
Date: Thu, 30 Apr 2015 07:24:54 -0700
Cc: Eyal Reizer <eyalreizer@gmail.com>, linux-kernel@vger.kernel.org,
	Eyal Reizer <eyalr@ti.com>, Pavan Savoy <pavan_savoy@ti.com>,
	Vishal Mahaveer <vishalm@ti.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <2A731A0F-6BEB-4614-94E8-90B28BEE2DD9@holtmann.org>
References: <1430380089-2395-1-git-send-email-eyalr@ti.com> <20150430113103.3ad0bfac@lxorguk.ukuu.org.uk>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>> tty_hci driver exposes a /dev/hci_tty character device node, that intends
>> to emulate a generic /dev/ttyX device that would be used by the user-space
>> Bluetooth stacks to send/receive data to/from the WL combo-connectivity
>> chipsets.
> 
> We have an in kernel bluetooth stack, why do we care about this - how
> will people test and debug driver interactions with binary only bluetooth
> stacks in userspace ?

NAK to this driver.

If you want to run an external Bluetooth stack, then use HCI User Channel. The functionality already exists.

We do not want to have two drivers for the same hardware. Work with the Bluetooth stack that is present in the kernel and please stop hacking around it.

Regards

Marcel

