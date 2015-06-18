Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: hci_uart: Fix speed selection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434624207-393-1-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 18 Jun 2015 13:48:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EB2E54C5-9A7F-4067-8C35-C4399FB45B40@holtmann.org>
References: <1434624207-393-1-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> hu->proto->*speed will always be used for all device where it is set.
> But hu->*speed should be used if exist, so the test should be swapped.
> 
> The equivalent change is needed in bcm_setup() of hci_bcm.c.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c   | 29 +++++++++++++++++++++++------
> drivers/bluetooth/hci_ldisc.c | 12 ++++++------
> 2 files changed, 29 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

