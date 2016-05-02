Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: hci_intel: Fix null gpio desc pointer dereference
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1461862105-23970-1-git-send-email-loic.poulain@intel.com>
Date: Mon, 2 May 2016 10:30:11 -0700
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	heikki.krogerus@linux.intel.com, linux-bluetooth@vger.kernel.org
Message-Id: <44A04441-1CFF-463C-8072-46A107C20957@holtmann.org>
References: <1461862105-23970-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> gpiod_get_optional can return either ERR_PTR or NULL pointer.
> NULL case is not tested and then dereferenced later in desc_to_gpio.
> Fix this by using non optional version which returns ERR_PTR in any
> error case (this is not an optional gpio).
> Use the same non optional version for the host-wake gpio.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

