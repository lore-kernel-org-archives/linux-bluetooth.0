Return-Path: <cyrus@holtmann.org>
Message-ID: <1359220418.16748.19.camel@aeonflux>
Subject: Re: [PATCH 7/9 v3] Bluetooth: Refactor UUID-16 list generation into
 its own function
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 26 Jan 2013 18:13:38 +0100
In-Reply-To: <1359194924-3151-8-git-send-email-johan.hedberg@gmail.com>
References: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
	 <1359194924-3151-8-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We will need to create three separate UUID lists in the EIR data (for
> 16, 32 and 128 bit UUIDs) so the code is easier to follow if each list
> is generated in their own function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   78 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 35 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


