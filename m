Return-Path: <cyrus@holtmann.org>
Message-ID: <1330034341.3392.6.camel@aeonflux>
Subject: Re: [PATCH 2/3] Bluetooth: mgmt: Fix dev_class related command
 response timing
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 23 Feb 2012 22:59:01 +0100
In-Reply-To: <1330032774-16206-2-git-send-email-johan.hedberg@gmail.com>
References: <1330032774-16206-1-git-send-email-johan.hedberg@gmail.com>
	 <1330032774-16206-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> All mgmt commands that may fire off a hci_write_class_of_device command
> should wait for the completion of the HCI command before sending a
> response to user space.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 65 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


