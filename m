Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/2] Bluetooth: Remove LE fixed channel mask bits
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1409553903-25260-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 1 Sep 2014 07:18:55 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3004C19F-A3E8-4F77-9480-0BF7540233A2@holtmann.org>
References: <1409553903-25260-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The LE fixed channels are never exposed through the supported channels
> bit mask so just remove their defines to avoid any mistaken usage.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/l2cap.h | 3 ---
> 1 file changed, 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index be25eddea615..a8ac05b0e8e3 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -137,9 +137,6 @@ struct l2cap_conninfo {
> #define L2CAP_FC_SIG_BREDR	0x02
> #define L2CAP_FC_CONNLESS	0x04
> #define L2CAP_FC_A2MP		0x08
> -#define L2CAP_FC_ATT		0x10
> -#define L2CAP_FC_SIG_LE		0x20
> -#define L2CAP_FC_SMP_LE		0x40

actually I put these into on purpose. Mainly for the broken Bluedroid stack that requires L2CAP_FC_ATT to be set to allow ATT over BR/EDR working correctly. So even while they are not valid for BR/EDR and fixed channel info is not (yet) defined for LE, I prefer we keep them here for completeness.

Regards

Marcel

