Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Use non-sleep version of gpio_set_value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1439820021-24802-1-git-send-email-loic.poulain@intel.com>
Date: Mon, 17 Aug 2015 16:00:18 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <E1579C00-8BC7-474F-A510-EB3289390638@holtmann.org>
References: <1439820021-24802-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> We should not sleep while holding a spinlock.
> bcm_gpio_set_power is called while holding the bcm_device_list lock.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

