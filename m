Return-Path: <cyrus@holtmann.org>
Message-ID: <1359297418.16748.25.camel@aeonflux>
Subject: Re: [PATCH 1/2 v2] Bluetooth: Fix link security setting when
 powering on
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 27 Jan 2013 15:36:58 +0100
In-Reply-To: <1359297121-9022-1-git-send-email-johan.hedberg@gmail.com>
References: <1359297121-9022-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If a controller is powered on while the HCI_AUTO_OFF flag is set the
> link security setting (HCI_LINK_SECURITY) might not be in sync with the
> actual state of the controller (HCI_AUTH). This patch fixes the issue by
> checking for inequality between the intended and actual settings and
> sends a HCI_Write_Auth_Enable command if necessary.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


