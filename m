Return-Path: <cyrus@holtmann.org>
Message-ID: <1326138222.6454.155.camel@aeonflux>
Subject: Re: [PATCH 3/4] Bluetooth: Fix resetting HCI_MGMT flag
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 09 Jan 2012 11:43:42 -0800
In-Reply-To: <1326109565-32631-3-git-send-email-johan.hedberg@gmail.com>
References: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
	 <1326109565-32631-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The HCI_MGMT flag should not be cleared when resetting a HCI device.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


