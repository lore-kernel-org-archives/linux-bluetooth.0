Return-Path: <cyrus@holtmann.org>
Message-ID: <1329652739.2246.3.camel@aeonflux>
Subject: Re: [PATCH 4/6] Bluetooth: mgmt: Fix Start Discovery return
 parameters
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 19 Feb 2012 12:58:59 +0100
In-Reply-To: <1329652469-28973-4-git-send-email-johan.hedberg@gmail.com>
References: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
	 <1329652469-28973-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The same address type that was passed to the Start Discovery command
> should also be returned in the response message.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


