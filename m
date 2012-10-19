Return-Path: <cyrus@holtmann.org>
Message-ID: <1350667438.1785.4.camel@aeonflux>
Subject: Re: [PATCH 4/6] Bluetooth: Add setting of the LE event mask
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 19 Oct 2012 10:23:58 -0700
In-Reply-To: <1350666911-6334-5-git-send-email-johan.hedberg@gmail.com>
References: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
	 <1350666911-6334-5-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds setting of the LE event mask to the HCI init procedure
> for LE-capable controllers. Right now we only set the default mask which
> is good enough for the events available in the 4.0 core specification.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


