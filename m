Return-Path: <cyrus@holtmann.org>
Message-ID: <1330008853.3392.1.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Fix return value of add/remove_uuid
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 23 Feb 2012 15:54:13 +0100
In-Reply-To: <1330005781-8185-2-git-send-email-johan.hedberg@gmail.com>
References: <1330005781-8185-1-git-send-email-johan.hedberg@gmail.com>
	 <1330005781-8185-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The Add/Remove UUID commands should return the device class instead of
> an empty parameter list.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


