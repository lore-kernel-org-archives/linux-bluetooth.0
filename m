Return-Path: <cyrus@holtmann.org>
Message-ID: <1325828882.6454.72.camel@aeonflux>
Subject: Re: [PATCH 3/9] Bluetooth: Move Extended Inquiry Response defines
 to hci.h
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Jan 2012 21:48:02 -0800
In-Reply-To: <1325776582-10314-4-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
	 <1325776582-10314-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The EIR defines are needed also outside of mgmt.c (e.g. in hci_event.c
> to check if EIR data has the complete name) so it's better to have them
> in a single public place, i.e. hci.h.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h |   13 +++++++++++++
>  net/bluetooth/mgmt.c        |   12 ------------
>  2 files changed, 13 insertions(+), 12 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


