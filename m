Return-Path: <cyrus@holtmann.org>
Message-ID: <1325829117.6454.75.camel@aeonflux>
Subject: Re: [PATCH 6/9] Bluetooth: Flush inquiry cache when starting mgmt
 triggered inquiry
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Jan 2012 21:51:57 -0800
In-Reply-To: <1325776582-10314-7-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
	 <1325776582-10314-7-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> For the remote name state tracking for the management interface to work
> the cache needs to be flushed whenever inquiry is started. The
> hci_do_inquiry function is only used by the management interface so by
> having the flushing done from it ensures that old ioctl based
> functionality isn't affected.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


