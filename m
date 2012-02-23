Return-Path: <cyrus@holtmann.org>
Message-ID: <1330008817.3392.0.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: mgmt: Fix update_eir/class with
 HCI_AUTO_OFF flag set
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 23 Feb 2012 15:53:37 +0100
In-Reply-To: <1330005781-8185-1-git-send-email-johan.hedberg@gmail.com>
References: <1330005781-8185-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we're powered but still have the HCI_AUTO_OFF flag set the
> update_eir and update_class functions should not do anything.
> Additionally these functions need to be called when the flag is finally
> cleared through set_powered or when powering on for real.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


