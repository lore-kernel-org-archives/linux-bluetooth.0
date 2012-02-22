Return-Path: <cyrus@holtmann.org>
Message-ID: <1329938082.2049.41.camel@aeonflux>
Subject: Re: [PATCH 2/3] Bluetooth: Fix read_name updating when HCI_SETUP is
 not set
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 20:14:42 +0100
In-Reply-To: <1329937615-29893-2-git-send-email-johan.hedberg@gmail.com>
References: <1329937615-29893-1-git-send-email-johan.hedberg@gmail.com>
	 <1329937615-29893-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The local name should only be updated as a consequence of a
> hci_read_local_name if we are in the HCI_SETUP state. In all other
> scenarios it should only be updated through hci_write_local_name.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


