Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v2] Bluetooth: hci_uart: Add Intel/AG6xx support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1456134483-29815-1-git-send-email-loic.poulain@intel.com>
Date: Wed, 24 Feb 2016 07:54:00 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4F6CCC11-D01D-4BAD-B2DB-FD89C7C5BEEC@holtmann.org>
References: <1456134483-29815-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> This driver implements support for iBT2.1 Bluetooth controller embedded
> in the AG620 communication combo. The controller needs to be configured
> with bddata and can be patched with a binary patch file (pbn).
> These operations are performed in manufacturing mode.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: Add PBN file description
>     Convert le PBN addr and plen before usage
>     Remove firmware fallback, we need full hw/fw ids
> 
> drivers/bluetooth/Kconfig     |  11 ++
> drivers/bluetooth/Makefile    |   1 +
> drivers/bluetooth/hci_ag6xx.c | 326 ++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/hci_ldisc.c |   6 +
> drivers/bluetooth/hci_uart.h  |   8 +-
> 5 files changed, 351 insertions(+), 1 deletion(-)
> create mode 100644 drivers/bluetooth/hci_ag6xx.c

patch has been applied to bluetooth-next tree.

However please send an additional patch to work in the check for the default Intel BD_ADDR so that we have the quirk for missing public address set correctly.

Regards

Marcel

