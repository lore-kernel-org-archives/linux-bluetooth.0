Return-Path: <cyrus@holtmann.org>
Message-ID: <1329652774.2246.4.camel@aeonflux>
Subject: Re: [PATCH 5/6] Bluetooth: mgmt: Fix (Un)Block Device return
 parameters
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 19 Feb 2012 12:59:34 +0100
In-Reply-To: <1329652469-28973-5-git-send-email-johan.hedberg@gmail.com>
References: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
	 <1329652469-28973-5-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The same address as was passed to the (Un)Block Device command should
> also be returned in the command response message.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   31 ++++++++++++++++++-------------
>  1 files changed, 18 insertions(+), 13 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


