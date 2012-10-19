Return-Path: <cyrus@holtmann.org>
Message-ID: <1350667492.1785.5.camel@aeonflux>
Subject: Re: [PATCH 5/6] Bluetooth: Fix HCI command sending when powering on
 LE-only adapters
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 19 Oct 2012 10:24:52 -0700
In-Reply-To: <1350666911-6334-6-git-send-email-johan.hedberg@gmail.com>
References: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
	 <1350666911-6334-6-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch makes sure that we don't send BR/EDR-only commands for
> LE-only adapters when they get powered on. Doing this would just cause
> command errors.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


