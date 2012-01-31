Return-Path: <cyrus@holtmann.org>
Message-ID: <1327985513.1955.206.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Use GFP_KERNEL in hci_add_adv_entry()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Date: Mon, 30 Jan 2012 20:51:53 -0800
In-Reply-To: <1327977088-32223-1-git-send-email-aguedespe@gmail.com>
References: <1327977088-32223-1-git-send-email-aguedespe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This function is not called in interrupt context anymore, so it
> should use GFP_KERNEL to allocate memory.
> 
> Signed-off-by: Andre Guedes <aguedespe@gmail.com>
> ---
>  net/bluetooth/hci_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


