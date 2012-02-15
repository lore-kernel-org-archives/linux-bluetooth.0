Return-Path: <cyrus@holtmann.org>
Message-ID: <1329309057.28848.90.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Fix discovery state machine
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 15 Feb 2012 13:30:57 +0100
In-Reply-To: <1329158462-28914-1-git-send-email-andre.guedes@openbossa.org>
References: <1329158462-28914-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> In case of Start Discovery command failure, we should set the
> discovery state to DISCOVERY_STOPPED. Otherwise, we stuck at
> DISCOVERY_STARTING state and subsequent Start Discovery commands
> will simply fail.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


