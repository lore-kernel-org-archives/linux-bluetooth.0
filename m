Return-Path: <cyrus@holtmann.org>
Message-ID: <1357761775.1806.49.camel@aeonflux>
Subject: Re: [PATCH 1/8] Bluetooth: Fix missing command complete event for
 mgmt_confirm_name
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Jan 2013 12:02:55 -0800
In-Reply-To: <1357738180-4128-2-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
	 <1357738180-4128-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> All management commands are expected to indicate successful completion
> through a command complete event however the confirm name command was
> missing it. This patch add the sending of the missing event.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


