Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Sep 2013 16:32:27 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix handling of getsockname() for HCI sockets
Message-ID: <20130901153227.GE7440@joana>
References: <1377501637-40861-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377501637-40861-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-08-26 Marcel Holtmann <marcel@holtmann.org>:

> The hci_dev check is not protected and so move it into the socket lock. In
> addition return the HCI channel identifier instead of always 0 channel.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
