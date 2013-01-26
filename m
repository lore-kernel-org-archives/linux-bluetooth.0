Return-Path: <cyrus@holtmann.org>
Message-ID: <1359220353.16748.18.camel@aeonflux>
Subject: Re: [PATCH 6/9 v3] Bluetooth: Remove useless eir_len variable from
 EIR creation
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 26 Jan 2013 18:12:33 +0100
In-Reply-To: <1359194924-3151-7-git-send-email-johan.hedberg@gmail.com>
References: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
	 <1359194924-3151-7-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The amount of data encoded so far in the create_eir() function can be
> calculated simply through the difference between the data and ptr
> pointer variables. The eir_len variable then becomes essentially
> useless.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


