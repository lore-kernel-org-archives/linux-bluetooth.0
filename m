Return-Path: <cyrus@holtmann.org>
Message-ID: <1351019068.1785.47.camel@aeonflux>
Subject: Re: [PATCH 5/7] Bluetooth: Fix updating host feature bits for LE
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 12:04:28 -0700
In-Reply-To: <1351011241-32515-6-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	 <1351011241-32515-6-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When LE has been enabled with the simultaneous BR/EDR & LE parameter set
> to true we should also update the host features stored in struct hci_dev
> accordingly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |    5 +++++
>  1 file changed, 5 insertions(+)

should go first as well.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


