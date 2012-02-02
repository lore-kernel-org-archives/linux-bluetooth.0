Return-Path: <cyrus@holtmann.org>
Message-ID: <1328148317.2062.0.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: mgmt: Implement Cancel Pair Device command
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 01 Feb 2012 18:05:17 -0800
In-Reply-To: <1328148354-14869-1-git-send-email-johan.hedberg@gmail.com>
References: <1328148354-14869-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch implements the Cancel Pair Device command for mgmt. It's used
> by user space to cancel an ongoing pairing attempt which was triggered
> by the Pair Device command.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    1 +
>  net/bluetooth/mgmt.c         |   51 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


