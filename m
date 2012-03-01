Return-Path: <cyrus@holtmann.org>
Message-ID: <1330634908.3392.109.camel@aeonflux>
Subject: Re: [PATCH 5/5] Bluetooth: mgmt: Centralize message length checks
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Mar 2012 12:48:28 -0800
In-Reply-To: <1330634012-4502-5-git-send-email-johan.hedberg@gmail.com>
References: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
	 <1330634012-4502-5-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch moves the command length information into the command handler
> table allowing the removal of length checks from the handler functions
> and doing the check in a single place before calling the handler
> function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |  220 ++++++++++++--------------------------------------
>  1 files changed, 52 insertions(+), 168 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


