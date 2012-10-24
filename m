Return-Path: <cyrus@holtmann.org>
Message-ID: <1351115283.1785.73.camel@aeonflux>
Subject: Re: [PATCH 2/6] Bluetooth: Fix sending unnecessary
 HCI_Write_SSP_Mode command
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 24 Oct 2012 14:48:03 -0700
In-Reply-To: <1351112996-9597-3-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
	 <1351112996-9597-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes sending an unnecessary HCI_Write_SSP_Mode command if
> the command has already been sent as part of the default HCI init
> sequence.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/mgmt.c             |    3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


