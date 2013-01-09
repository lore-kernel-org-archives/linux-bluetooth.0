Return-Path: <cyrus@holtmann.org>
Message-ID: <1357761872.1806.50.camel@aeonflux>
Subject: Re: [PATCH 2/8] Bluetooth: Fix missing command complete for
 mgmt_load_long_term_keys
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Jan 2013 12:04:32 -0800
In-Reply-To: <1357738180-4128-3-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
	 <1357738180-4128-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> All management events are expected to indicate successful completion
> through a command complete event, however  the load long term keys
> command was missing this. This patch adds the missing event.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


