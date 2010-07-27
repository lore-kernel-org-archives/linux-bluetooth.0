Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix permission of hci_ath.c
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtman.org,
	suraj@atheros.com, "Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1279944365-15821-1-git-send-email-gustavo@padovan.org>
References: <1279944365-15821-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 12:33:28 -0700
Message-ID: <1280259208.2621.88.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> From: Gustavo F. Padovan <padovan@profusion.mobi>
> 
> .c file shall not have the 'x' permission.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 => 100644 drivers/bluetooth/hci_ath.c

good catch. Patch has been applied.

Regards

Marcel


