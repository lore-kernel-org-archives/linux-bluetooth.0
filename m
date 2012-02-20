Return-Path: <cyrus@holtmann.org>
Message-ID: <1329776843.2049.3.camel@aeonflux>
Subject: Re: [PATCH 4/4] Bluetooth: mgmt: Fix Set SSP check for supported
 feature
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 20 Feb 2012 23:27:23 +0100
In-Reply-To: <1329776676-22800-4-git-send-email-johan.hedberg@gmail.com>
References: <1329776676-22800-1-git-send-email-johan.hedberg@gmail.com>
	 <1329776676-22800-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If the local controller doesn't support SSP we should always return an
> error for the Set SSP command.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


