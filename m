Return-Path: <cyrus@holtmann.org>
Message-ID: <1351115330.1785.74.camel@aeonflux>
Subject: Re: [PATCH 3/6] Bluetooth: Fix sending unnecessary
 HCI_LE_Host_Enable
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 24 Oct 2012 14:48:50 -0700
In-Reply-To: <1351112996-9597-4-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
	 <1351112996-9597-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes sending an unnecessary HCI_LE_Host_Enable command if
> the command has already been sent as part of the default HCI init
> sequence.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


