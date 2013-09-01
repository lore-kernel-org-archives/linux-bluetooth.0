Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Sep 2013 17:25:45 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Restrict ioctls to HCI raw channel sockets
Message-ID: <20130901162545.GH7440@joana>
References: <1377535195-12121-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377535195-12121-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-08-26 Marcel Holtmann <marcel@holtmann.org>:

> The various legacy ioctls used with HCI sockets are limited to raw
> channel only. They are not used on the other channels and also have
> no meaning there. So return an error if tried to use them.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
