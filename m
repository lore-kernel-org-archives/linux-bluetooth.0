Return-Path: <cyrus@holtmann.org>
Message-ID: <1327947822.1955.137.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Use GFP_KERNEL in hci_conn_add()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jan 2012 10:23:42 -0800
In-Reply-To: <1327926130-26149-1-git-send-email-andre.guedes@openbossa.org>
References: <1327926130-26149-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This function is called in process context only, so it should use
> GFP_KERNEL to allocate memory.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


