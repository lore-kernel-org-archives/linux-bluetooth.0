Return-Path: <cyrus@holtmann.org>
Message-ID: <1329778713.2049.4.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: mgmt: Clear EIR data when disabling SSP
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 20 Feb 2012 23:58:33 +0100
In-Reply-To: <1329778752-23846-1-git-send-email-johan.hedberg@gmail.com>
References: <1329778752-23846-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> EIR shouldn't be enabled if SSP isn't enabled. This patch adds the
> clearing of EIR data when disabling SSP and restores the data when SSP
> is re-enabled.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   20 +++++++++++++++++++-
>  1 files changed, 19 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


