Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 31 Oct 2011 17:55:19 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH 2/2] Bluetooth: bcm203x: Use GFP_KERNEL in workqueue
Message-ID: <20111031195519.GK10164@joana>
References: <1319570016-7439-1-git-send-email-dh.herrmann@googlemail.com>
 <1319570016-7439-2-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319570016-7439-2-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-10-25 21:13:36 +0200]:

> A workqueue is allowed to sleep so we can safely use GFP_KERNEL instead of
> GFP_ATOMIC. This is still legacy code when the driver used timer BHs and not a
> worqueue.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/bcm203x.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
