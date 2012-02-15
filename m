Return-Path: <cyrus@holtmann.org>
Message-ID: <1329309080.28848.91.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: DISCOVERY_STOPPED state
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 15 Feb 2012 13:31:20 +0100
In-Reply-To: <1329158462-28914-2-git-send-email-andre.guedes@openbossa.org>
References: <1329158462-28914-1-git-send-email-andre.guedes@openbossa.org>
	 <1329158462-28914-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> We are not supposed to send mgmt_discovering events if we are
> transiting from DISCOVERY_STARTING to DISCOVERY_STOPPED state.
> It doesn't make sense to send mgmt_discovering event once
> discovery procedure has not been even started.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


