Return-Path: <cyrus@holtmann.org>
Message-ID: <1329919439.2049.34.camel@aeonflux>
Subject: Re: [PATCH 1/3] Bluetooth: mgmt: Fix EIR toggling with SSP
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 15:03:59 +0100
In-Reply-To: <1329919363-23660-1-git-send-email-johan.hedberg@gmail.com>
References: <1329919363-23660-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes setting the EIR properly when the SSP flag has been set
> when powered off (in such a case there is no pending Set_SSP command).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


