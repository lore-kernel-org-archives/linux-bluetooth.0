Return-Path: <cyrus@holtmann.org>
Message-ID: <1329841015.2049.24.camel@aeonflux>
Subject: Re: [PATCH 7/9] Bluetooth: mgmt: Fix set_fast_connectable error
 return
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 21 Feb 2012 17:16:55 +0100
In-Reply-To: <1329840005-4977-7-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
	 <1329840005-4977-7-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch ensures that Set Fast Connectable fails apropriately if we
> are not already in a connectable state (which is a pre-requisite for
> fast connectable).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


