Return-Path: <cyrus@holtmann.org>
Message-ID: <1359219790.16748.9.camel@aeonflux>
Subject: Re: [PATCH 1/9 v3] Bluetooth: Store UUIDs in the same order that
 they were added
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 26 Jan 2013 18:03:10 +0100
In-Reply-To: <1359194924-3151-2-git-send-email-johan.hedberg@gmail.com>
References: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
	 <1359194924-3151-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We should be encoding UUIDs to the EIR data in the same order that they
> were added to the kernel, i.e. each UUID should be added to the end of
> the UUIDs list. This patch fixes the issue by using list_add_tail
> instead of list_add for storing the UUIDs.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


