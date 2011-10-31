Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 31 Oct 2011 17:55:57 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: bfusb: Fix error path on firmware load
Message-ID: <20111031195557.GL10164@joana>
References: <1319620966-11193-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319620966-11193-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-10-26 11:22:46 +0200]:

> When loading the usb-configuration we do not signal the end of configuration on
> memory allocation error. This patch moves the memory allocation to the top so
> every error path uses "goto error" now to correctly send the usb-ctrl message
> when detecting some error.
> 
> This also replaces GFP_ATOMIC with GFP_KERNEL as we are allowed to sleep here.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/bfusb.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)

Applied, thanks.

	Gustavo
