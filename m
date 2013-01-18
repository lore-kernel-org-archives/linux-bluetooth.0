Return-Path: <cyrus@holtmann.org>
Message-ID: <1358528159.5510.7.camel@aeonflux>
Subject: Re: [PATCH 02/10] Bluetooth: Fix returning proper mgmt status for
 Load LTKs
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 18 Jan 2013 08:55:59 -0800
In-Reply-To: <1358515558-17861-3-git-send-email-johan.hedberg@gmail.com>
References: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
	 <1358515558-17861-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Failures of mgmt commands should be indicated with valid mgmt status
> codes, and EINVAL is not one of them. Instead MGMT_STATUS_INVALID_PARAMS
> should be returned.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


