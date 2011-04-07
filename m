Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 7 Apr 2011 18:48:49 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Jiejing Zhang <kzjeef@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Jiejing Zhang <jiejing.zhang@freescale.com>
Subject: Re: [PATCH] Bluetooth: hci_uart: check the return value of recv()
Message-ID: <20110407214849.GC2366@joana>
References: <1302179826-15745-1-git-send-email-kzjeef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302179826-15745-1-git-send-email-kzjeef@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiejing,

* Jiejing Zhang <kzjeef@gmail.com> [2011-04-07 20:37:06 +0800]:

> Check the return value of hu->proto->recv() in hci_uart_tty_receive()
> the recv() may return error, check it, not add this to statistics.
> 
> Signed-off-by: Jiejing Zhang <jiejing.zhang@freescale.com>
> ---
>  drivers/bluetooth/hci_ath.c   |    6 +++++-
>  drivers/bluetooth/hci_ldisc.c |    6 ++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)

Patch has been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
