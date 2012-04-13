Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 11:29:56 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix registering HCI devices with duplicate
 name
Message-ID: <20120413082946.GA12968@aemeltch-MOBL1>
References: <1334158328-6956-1-git-send-email-marcel@holtmann.org>
 <1334230797-11212-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334230797-11212-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Apr 12, 2012 at 02:39:57PM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> When adding HCI devices hci_register_dev assigns the same name
> hci1 for subsequently added AMP devices. This is modified version
> of Marcel Holtmann patch.
> 
> ...
> [ 6958.381886] sysfs: cannot create duplicate filename
>         '/devices/virtual/bluetooth/hci1

Please do not consider this patch. I think bitmask approach is better.

Best regards 
Andrei Emeltchenko 
