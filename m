Return-Path: <cyrus@holtmann.org>
Message-ID: <1329919525.2049.36.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: Explicitly clear EIR data upon hci_dev
 setup
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 15:05:25 +0100
In-Reply-To: <1329919363-23660-3-git-send-email-johan.hedberg@gmail.com>
References: <1329919363-23660-1-git-send-email-johan.hedberg@gmail.com>
	 <1329919363-23660-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Some controllers preserve their EIR data even after a reset so we need
> to explicitly clear this during the device setup procedure.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


