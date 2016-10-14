Return-Path: <johan.hedberg@intel.com>
Date: Fri, 14 Oct 2016 17:19:38 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: "Wu, Jiangbo" <jiangbo.wu@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Add conn type to identify addr type with SMP
 over BR/EDR
Message-ID: <20161014141938.GA16585@x1c.P-661HNU-F1>
References: <1476448183-8630-1-git-send-email-jiangbo.wu@intel.com>
 <46A11791-AE7E-4064-94EC-D824C875FB37@holtmann.org>
 <ACB402E679F3454EAE433BF5E93F4EAA389960DF@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ACB402E679F3454EAE433BF5E93F4EAA389960DF@shsmsx102.ccr.corp.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiangbo,

Please don't top-post on this list.

On Fri, Oct 14, 2016, Wu, Jiangbo wrote:
> If pair a device that unpair firstly that remove encryption key,
> encryption key event will be emitted. kernel will receive
> 'L2CAP_CID_SMP_BREDR' frame, and then it will use SMP to distribute
> key.  SMP would like to use LTK, IRK and CRSK to notify user. If it
> don't identify device by which conn type they are, only marks LE as
> the device type,

Why would that happen? Before SMP over BR/EDR happens pairing would have
happened over BR/EDR, so bluetoothd should know that BR/EDR is supported
as well (it would even be aware of an existing BR/EDR connection). Are
you perhaps trying to work around some bluetoothd bug with all this?

> while Bluetoothd will use this 'addr' and 'addr type' to reply the
> comfirm to kernel.

What reply are you talking about? There's no user interaction involved
with SMP over BR/EDR - that would already have occurred when SSP over
BR/EDR happened.

> At the same time kernel always uses them to lookup hci_conn in LE
> hashtable firstly, because addr type always marks as LE. Obviously it
> will failed with SMP over BR/EDR.

I don't follow this either since there shouldn't have been any "reply"
from user space for SMP over BR/EDR. All there should be are events from
the kernel for the generated LE keys.

> Actually, SPM is only for LE in SPEC,

That's not true. SMP is specified both for LE-U and ACL-U.

> but kernel already support and use SMP over BR/EDR. if BR/EDR
> exchanges key with SMP, it will never reply pairing response to
> remote, in other words it will be never paired, that is happened in
> our products.

Szymon recently implemented SMP over BR/EDR for Zephyr and used
Linux/BlueZ as a reference for testing. He didn't report any issues like
this. It might help if you could provide some logs (particularly
HCI/btmon but also from bluetoothd) to understand what's the actual
issue you're seeing.

Johan
