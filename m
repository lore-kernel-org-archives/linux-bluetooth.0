Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 4/5] Bluetooth: hci_intel: Enter manufacturing mode if requested
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448650563-9075-4-git-send-email-loic.poulain@intel.com>
Date: Tue, 1 Dec 2015 21:56:34 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A56DEF90-5200-4C3C-8EE5-603C3950D7A0@holtmann.org>
References: <1448650563-9075-1-git-send-email-loic.poulain@intel.com> <1448650563-9075-4-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> LhP controller only sends manufacturing error if not correctly
> configured (after first boot), nothing else.
> In order to avoid a read intel version command timeout due to missing
> command complete event, inject the event with an error status.

can we actually get the events that the controller sends. I think we either get a manufacturing error or a bootup event. Both can be taken as indicator that this is LhP and not LnP.

If this turns into something too complicated, we might just create a hci_ag6xx.c and treat this as a separate driver for yet another part of Intel hardware. Or another alternative is to add a HCIUARTSETOPTS or HCIUARTSETVNDFLAGS or similar to allow for driver specific flags.

Entering manufacturer mode is suppose to be no op for LnP for backwards compatible reasons. Leaving the manufacturer mode will fail on LnP. So we could just send that command no matter what. However I remember that LnP really wants a Intel Read Version command first. At least with some bootloader versions.

Regards

Marcel

