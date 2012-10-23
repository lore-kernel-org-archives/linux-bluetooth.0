Return-Path: <cyrus@holtmann.org>
Message-ID: <1351018956.1785.45.camel@aeonflux>
Subject: Re: [PATCH 2/7] Bluetooth: mgmt: Restrict BR/EDR settings to
 BR/EDR-only adapters
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 12:02:36 -0700
In-Reply-To: <1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	 <1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch makes sure that settings which are specific for BR/EDR
> capable adapters are not allowed for non-BR/EDR (e.g. LE-only) adapters.
> Instead, a "not supported" error is returned of such a setting is
> attempted to be set for a non-BR/EDR adapter.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

can we lead with this patch. It seems to be useful no matter what we do
for LE peripheral or single-mode controllers.

Regards

Marcel


