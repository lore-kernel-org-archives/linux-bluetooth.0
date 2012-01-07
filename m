Return-Path: <cyrus@holtmann.org>
Message-ID: <1325970183.6454.123.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: hci-uart-ll: Use GFP_ATOMIC in open()
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Sat, 07 Jan 2012 13:03:03 -0800
In-Reply-To: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> The uart_proto open() callback is not called in atomic context so we can safely
> sleep here. The caller hci_uart_set_proto() in hci_ldisc.c is an ioctl() handler
> and therefore can sleep.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/hci_ll.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


