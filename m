Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/3] bluetooth: Introduce hci_uart_unregister_device()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170708163743.24394-2-ian@mnementh.co.uk>
Date: Sat, 8 Jul 2017 21:59:52 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        sebastian.reichel@collabora.co.uk, ohad@bencohen.org
Message-Id: <54BC1277-752D-41E1-9903-1A0207CBBAD9@holtmann.org>
References: <20170708163743.24394-1-ian@mnementh.co.uk>
 <20170708163743.24394-2-ian@mnementh.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> Several drivers have the same (and incorrect) code in their
> _remove() handler.
> 
> Coalesce this into a shared function.
> 
> Signed-off-by: Ian Molton <ian@mnementh.co.uk>
> ---
> drivers/bluetooth/hci_serdev.c | 12 ++++++++++++
> drivers/bluetooth/hci_uart.h   |  1 +
> 2 files changed, 13 insertions(+)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

