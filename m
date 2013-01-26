Return-Path: <cyrus@holtmann.org>
Message-ID: <1359220317.16748.17.camel@aeonflux>
Subject: Re: [PATCH 5/9 v3] Bluetooth: Simplify UUID16 list generation for
 EIR
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 26 Jan 2013 18:11:57 +0100
In-Reply-To: <1359194924-3151-6-git-send-email-johan.hedberg@gmail.com>
References: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
	 <1359194924-3151-6-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's no need to use two separate loops to generate a UUID list for
> the EIR data. This patch merges the two loops previously used for the
> 16-bit UUID list generation into a single loop, thus simplifying the
> code a great deal.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   46 +++++++++++++++-------------------------------
>  1 file changed, 15 insertions(+), 31 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


