Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Intel: Introduce btvnd_intel library
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <551525E8.7070103@intel.com>
Date: Fri, 27 Mar 2015 10:59:01 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <F38305D3-B7D8-4D50-8623-F2F0CDE90990@holtmann.org>
References: <1427387863-2629-1-git-send-email-loic.poulain@intel.com> <3354DD05-A6FC-4F73-9D77-485D570944B1@holtmann.org> <551525E8.7070103@intel.com>
To: loic <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>>> Most Intel Bluetooth controllers use a same set of vendor HCI commands
>>> and procedures regardless of the transport layer (USB, UART, etc).
>>> In order to prevent code duplication, this patch adds common library
>>> for Intel bluetooth drivers.
>>> This is essentially a move of btusb Intel code to btvnd_intel.
>> actually in the beginning I would prefer to actually go with independent code for USB and UART for the Intel silicon. The reason I am saying that is because there are still things to be figured out before we can have generic code. So we might accept duplicate at first and once both transports are working, we will slowly start moving code out into a common module.
> Seems reasonable.
>> 
>> Also I think only BTUSB_INTEL_NEW support needs to be considered in the beginning. The older Intel silicon support should only be considered when the need arises.
>> 
>> To give a little bit background, the functions that we need to consider are hdev->shutdown, hdev->setup and hdev->set_bdaddr. That would be simplest split into a separate module. However they are a bit tricky since for BTUSB_INTEL_NEW we already know that we have to handle asynchronous event reception from the firmware download. With regard, I would like to see the UART code first merged upstream and then we go and move common pieces into a more generic solution.
> Async events (boot up, patch complete) are currently managed by the Bluetooth transport driver itself (hook).
> Could we consider to introduce a hci_wait_vendor_event helper?

we could, but it is a bit more complicated. It might needs to be something in the form of wait queue or alike. Reason is the the __hci_cmd_sync will run at the same time. The reason why this works in btusb.c at the moment is because the event processing just sets a flag and then wakes up the queue. And you need to run them at the same time. Everything else is racy and run into these when developing the USB support.

One thing that might work is if the core allows you to provide a way to forward vendor events back into the driver. I went forth and back on that a few times already and can not make up my mind. Essentially it is vendor specific in the first place, so it should be confined to the driver. However then again, __hci_cmd_sync sends vendor commands and the core processes them. It is tricky and honestly I do not know which direction to take this.

If you want to make a proposal for having vendor event hooks in the core, then please go for it. No promises that they going to make it, but it is worth a try. If you do not try you never know what works and what doesn't. My take however would be to develop this inside the hci_uart driver first and see how it goes. Once you have two drivers needing some similar functionality, then we can easier decide what make sense to have in the core and what does not.

Regards

Marcel

