Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Bluetooth: Add missing hci_dev locking when calling
 mgmt functions
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Nov 2011 16:36:42 +0900
In-Reply-To: <1320777616-15794-3-git-send-email-johan.hedberg@gmail.com>
References: <1320777616-15794-1-git-send-email-johan.hedberg@gmail.com>
	 <1320777616-15794-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320824205.15441.317.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Now that the pending commands are within struct hci_dev we can properly
> control access to them throught the hci_dev locking mechanism.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c  |   12 ++++++++++--
>  net/bluetooth/hci_event.c |   45 ++++++++++++++++++++++++++++++++++++++++-----
>  net/bluetooth/mgmt.c      |   13 +++++++------
>  3 files changed, 57 insertions(+), 13 deletions(-)

looks good to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


