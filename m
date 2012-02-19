Return-Path: <cyrus@holtmann.org>
Message-ID: <1329652804.2246.5.camel@aeonflux>
Subject: Re: [PATCH 6/6] Bluetooth: mgmt: Fix OOB command response parameters
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 19 Feb 2012 13:00:04 +0100
In-Reply-To: <1329652469-28973-6-git-send-email-johan.hedberg@gmail.com>
References: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
	 <1329652469-28973-6-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The response to the Add/Remove Out Of Band Data commands should include
> the same address as was given in the command itself.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   30 ++++++++++++++++++------------
>  1 files changed, 18 insertions(+), 12 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


