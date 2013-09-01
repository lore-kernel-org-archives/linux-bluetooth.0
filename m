Return-Path: <cyrus@holtmann.org>
Date: Sun, 1 Sep 2013 16:31:01 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Refactor raw socket filter into more readable
 code
Message-ID: <20130901153101.GC7440@joana>
References: <1377498315-22523-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377498315-22523-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-08-25 Marcel Holtmann <marcel@holtmann.org>:

> The handling of the raw socket filter is rather obscure code and it gets
> in the way of future extensions. Instead of inline filtering in the raw
> socket packet routine, refactor it into its own function.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 64 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 41 insertions(+), 23 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
