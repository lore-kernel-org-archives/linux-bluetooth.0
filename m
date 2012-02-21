Return-Path: <cyrus@holtmann.org>
Message-ID: <1329841063.2049.25.camel@aeonflux>
Subject: Re: [PATCH 8/9] Bluetooth: mgmt: Fix pairable setting upon
 initialization
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 21 Feb 2012 17:17:43 +0100
In-Reply-To: <1329840005-4977-8-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
	 <1329840005-4977-8-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When mgmt is not in use the HCI_PAIRABLE flag will get implicitly set so
> that pairing still works with old user space versions. However, as soon
> as mgmt comes into play we should clear this flag so that it can be
> properly set through the set_pairable command by user space.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


