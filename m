Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Sep 2013 17:21:01 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix error handling for HCI socket options
Message-ID: <20130901162101.GG7440@joana>
References: <1377534579-5781-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377534579-5781-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-08-26 Marcel Holtmann <marcel@holtmann.org>:

> The HCI sockets for monitor and control do not support any HCI specific
> socket options and if tried, an error will be returned. However the
> error used is EINVAL and that is not really descriptive. To make it
> clear that these sockets are not handling HCI socket options, return
> EBADFD instead.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
