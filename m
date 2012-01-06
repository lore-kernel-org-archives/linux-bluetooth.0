Return-Path: <cyrus@holtmann.org>
Message-ID: <1325828850.6454.71.camel@aeonflux>
Subject: Re: [PATCH 2/9] Bluetooth: Convert inquiry cache to use standard
 list types
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Jan 2012 21:47:30 -0800
In-Reply-To: <1325776582-10314-3-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
	 <1325776582-10314-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This makes it possible to use the convenience functions provided for
> standard kernel list types and it also makes it easier to extend the use
> of the cache for the management interface where e.g. name resolving
> control will be needed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   10 ++++------
>  net/bluetooth/hci_core.c         |   31 +++++++++++++++++--------------
>  net/bluetooth/hci_sysfs.c        |    2 +-
>  3 files changed, 22 insertions(+), 21 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


