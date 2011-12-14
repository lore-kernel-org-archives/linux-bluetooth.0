Return-Path: <cyrus@holtmann.org>
Message-ID: <1323900361.1965.58.camel@aeonflux>
Subject: Re: [PATCH 2/7] Bluetooth: Move mgmt_set_fast_connectable to the
 right location
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Dec 2011 23:06:01 +0100
In-Reply-To: <1323899524-13653-3-git-send-email-johan.hedberg@gmail.com>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
	 <1323899524-13653-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Fast connetable is logically after the connectable property so that's
> where it should show up in the code as well (it's also after connectable
> in the settings bitfield).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    7 ++-----
>  net/bluetooth/mgmt.c         |   12 ++++++------
>  2 files changed, 8 insertions(+), 11 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

However changing the hci_dev_lock in hci_dev_lock_bh would have been
nice as well, but that becomes obsolete anyway when moving to a
workqueue. So not worth bothering.

Regards

Marcel


