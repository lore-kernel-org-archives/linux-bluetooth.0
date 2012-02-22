Return-Path: <cyrus@holtmann.org>
Message-ID: <1329923669.2049.37.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: mgmt: Fix Set SSP supported check
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 16:14:29 +0100
In-Reply-To: <1329922392-25089-1-git-send-email-johan.hedberg@gmail.com>
References: <1329922392-25089-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The test for SSP support needs to be earlier in the set_ssp function so
> that we return an error when SSP is not supported even when the device
> is powered off.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


