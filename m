Return-Path: <cyrus@holtmann.org>
Message-ID: <1330386185.3392.72.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Don't send unnecessary write_le_enable
 command
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 27 Feb 2012 15:43:05 -0800
In-Reply-To: <1330386094-19501-1-git-send-email-johan.hedberg@gmail.com>
References: <1330386094-19501-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If the local host features indicate that LE is already in the state that
> is desired there's no point in sending the HCI command to try to change
> the setting.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


