Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Sep 2013 16:31:22 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix handling of getpeername() for HCI sockets
Message-ID: <20130901153122.GD7440@joana>
References: <1377500790-36821-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377500790-36821-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-08-26 Marcel Holtmann <marcel@holtmann.org>:

> The HCI sockets do not have a peer associated with it and so make sure
> that getpeername() returns EOPNOTSUPP since this operation is actually
> not supported on HCI sockets.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 3 +++
>  1 file changed, 3 insertions(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
