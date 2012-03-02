Return-Path: <cyrus@holtmann.org>
Message-ID: <1330650974.3392.112.camel@aeonflux>
Subject: Re: [PATCH 2/3] Bluetooth: mgmt: Fix command status error code
 values
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Mar 2012 17:16:14 -0800
In-Reply-To: <1330650900-11420-2-git-send-email-johan.hedberg@gmail.com>
References: <1330650900-11420-1-git-send-email-johan.hedberg@gmail.com>
	 <1330650900-11420-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Error codes in the command status should always be from the set of
> values defined for mgmt and never e.g. POSIX error codes.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


