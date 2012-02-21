Return-Path: <cyrus@holtmann.org>
Message-ID: <1329840904.2049.22.camel@aeonflux>
Subject: Re: [PATCH 4/9] Bluetooth: mgmt: Fix current settings values when
 powered off
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 21 Feb 2012 17:15:04 +0100
In-Reply-To: <1329840005-4977-4-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
	 <1329840005-4977-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We should not stop iterating through the various settings if powered off
> since most may still be set even then.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


