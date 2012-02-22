Return-Path: <cyrus@holtmann.org>
Message-ID: <1329919472.2049.35.camel@aeonflux>
Subject: Re: [PATCH 2/3] Bluetooth: mgmt: Fix clearing of hdev->eir
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 15:04:32 +0100
In-Reply-To: <1329919363-23660-2-git-send-email-johan.hedberg@gmail.com>
References: <1329919363-23660-1-git-send-email-johan.hedberg@gmail.com>
	 <1329919363-23660-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hdev->eir buffer needs to be cleared when clearing the EIR data.
> Otherwise subsequent attempts at setting the EIR to something valid
> again may fail because the code thinks that the EIR hasn't changed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


