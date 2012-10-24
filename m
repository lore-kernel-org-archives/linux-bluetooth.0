Return-Path: <cyrus@holtmann.org>
Message-ID: <1351115154.1785.71.camel@aeonflux>
Subject: Re: [PATCH 1/6] Bluetooth: Fix setting host feature bits for SSP
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 24 Oct 2012 14:45:54 -0700
In-Reply-To: <1351112996-9597-2-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
	 <1351112996-9597-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we get a successful command complete for HCI_Write_SSP_Mode we need
> to update the host feature bits for the hdev struct accordingly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


