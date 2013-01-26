Return-Path: <cyrus@holtmann.org>
Message-ID: <1359219824.16748.10.camel@aeonflux>
Subject: Re: [PATCH 2/9 v3] Bluetooth: Simplify UUIDs clearing code
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 26 Jan 2013 18:03:44 +0100
In-Reply-To: <1359194924-3151-3-git-send-email-johan.hedberg@gmail.com>
References: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
	 <1359194924-3151-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The code for clearing the UUIDs list can be simplified by using
> list_for_each_entry_safe instead of list_for_each_safe.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


