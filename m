Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Jan 2012 22:36:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: hci-uart-ath: Use GFP_ATOMIC in open()
Message-ID: <20120108203648.GJ16731@x220.P-661HNU-F1>
References: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
 <1325945981-11330-4-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325945981-11330-4-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sat, Jan 07, 2012, David Herrmann wrote:
> The uart_proto open() callback is not called in atomic context so we can safely
> sleep here. The caller hci_uart_set_proto() in hci_ldisc.c is an ioctl-handler
> and therefore can sleep.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/hci_ath.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
