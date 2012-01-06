Return-Path: <cyrus@holtmann.org>
Message-ID: <1325829082.6454.74.camel@aeonflux>
Subject: Re: [PATCH 5/9] Bluetooth: Return updated name state with
 hci_inquiry_cache_update
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Jan 2012 21:51:22 -0800
In-Reply-To: <1325776582-10314-6-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
	 <1325776582-10314-6-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If user-space has already confirmed the name for a remote device we
> shouldn't request confirmation again. The simplest way to do this is to
> return the name state from hci_inquiry_cache_update (if it is anything
> else than unknown then we do not need confirmation from user-space).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_core.c         |    9 +++++++--
>  net/bluetooth/hci_event.c        |   21 ++++++++++++++-------
>  3 files changed, 22 insertions(+), 10 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


