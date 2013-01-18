Return-Path: <cyrus@holtmann.org>
Message-ID: <1358528046.5510.5.camel@aeonflux>
Subject: Re: [PATCH 08/10] Bluetooth: Fix checking for valid disconnect
 parameters in unpair_device
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 18 Jan 2013 08:54:06 -0800
In-Reply-To: <1358515558-17861-9-git-send-email-johan.hedberg@gmail.com>
References: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
	 <1358515558-17861-9-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The valid values for the Disconnect parameter in the Unpair Device
> command are 0x00 and 0x01. If any other value is encountered the command
> should fail with the appropriate invalid params response.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


