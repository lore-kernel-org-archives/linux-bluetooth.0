Return-Path: <cyrus@holtmann.org>
Message-ID: <1358528129.5510.6.camel@aeonflux>
Subject: Re: [PATCH 01/10] Bluetooth: Fix checking for correct
 mgmt_load_link_keys parameters
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 18 Jan 2013 08:55:29 -0800
In-Reply-To: <1358515558-17861-2-git-send-email-johan.hedberg@gmail.com>
References: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
	 <1358515558-17861-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The debug_keys parameter is only allowed to have the values 0x00 and
> 0x01. Any other value should result in a proper command status with
> MGMT_STATUS_INVALID_PARAMS.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


