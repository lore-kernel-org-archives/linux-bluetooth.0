Return-Path: <cyrus@holtmann.org>
Message-ID: <1329652707.2246.2.camel@aeonflux>
Subject: Re: [PATCH 3/6] Bluetooth: mgmt: Fix Pair Device response status
 values
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 19 Feb 2012 12:58:27 +0100
In-Reply-To: <1329652469-28973-3-git-send-email-johan.hedberg@gmail.com>
References: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
	 <1329652469-28973-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes the status in Pair Device responses to follow proper
> mgmt status values.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   14 ++++++--------
>  1 files changed, 6 insertions(+), 8 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


