Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix cancel_delayed_work_sync usage with locks
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Nov 2011 16:40:30 +0900
In-Reply-To: <1320795862-18741-1-git-send-email-johan.hedberg@gmail.com>
References: <1320795862-18741-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320824433.15441.322.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The cancel_delayed_work_sync function should not be used if we hold any
> locks. Luckily all places where this is the case it is also safe to use
> the non-sync version.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |    6 +++---
>  net/bluetooth/mgmt.c     |    4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


