Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Bluetooth: Fix consistency with u16 integer type in
 mgmt pending_cmd
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Nov 2011 23:45:24 +0900
In-Reply-To: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
References: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320849927.15441.340.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> For consistency the integer type should be u16 and not __u16.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


