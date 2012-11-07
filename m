Return-Path: <cyrus@holtmann.org>
Message-ID: <1352303814.16204.3.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: Fix updating advertising state flags and
 data
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 07 Nov 2012 16:56:54 +0100
In-Reply-To: <1352239600-5840-3-git-send-email-johan.hedberg@gmail.com>
References: <1352239600-5840-1-git-send-email-johan.hedberg@gmail.com>
	 <1352239600-5840-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a callback for the HCI_LE_Set_Advertise_Enable command.
> The callback is responsible for updating the HCI_LE_PERIPHERAL flag
> updating as well as updating the advertising data flags field to
> indicate undirected connectable advertising.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h |    2 ++
>  net/bluetooth/hci_event.c   |   31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


