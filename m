Return-Path: <cyrus@holtmann.org>
Message-ID: <1351115395.1785.75.camel@aeonflux>
Subject: Re: [PATCH 4/6] Bluetooth: Fix unnecessary EIR update during
 powering on
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 24 Oct 2012 14:49:55 -0700
In-Reply-To: <1351112996-9597-5-git-send-email-johan.hedberg@gmail.com>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
	 <1351112996-9597-5-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When powered on the EIR data gets updated as the last step by mgmt.
> Therefore avoid an update when getting a local name update as that's
> part of the normal HCI init sequence.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


