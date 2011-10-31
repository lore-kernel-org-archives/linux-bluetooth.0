Return-Path: <cyrus@holtmann.org>
Date: Mon, 31 Oct 2011 17:29:55 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Replace rfcomm tty tasklet by workqueue
Message-ID: <20111031192955.GE10164@joana>
References: <1319463058-29311-1-git-send-email-dh.herrmann@googlemail.com>
 <1319463058-29311-2-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319463058-29311-2-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-10-24 15:30:58 +0200]:

> Remove old tasklets and replace by workqueue. To avoid reentrancy (which
> tasklets always avoid) we use the system_nrt_wq.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  net/bluetooth/rfcomm/tty.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)

Both patches have been applied, thanks.

	Gustavo
