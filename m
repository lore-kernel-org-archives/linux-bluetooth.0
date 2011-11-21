Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 14:30:03 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: bnep: Fix module reference
Message-ID: <20111121163003.GH2552@joana>
References: <1321705413-2598-1-git-send-email-dh.herrmann@googlemail.com>
 <1321705413-2598-2-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321705413-2598-2-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-11-19 13:23:33 +0100]:

> We cannot call module_put(THIS_MODULE) if this is our last reference. Otherwise,
> this call may cleanup our module before it returns.
> 
> Gladly, the kthread API provides a simple wrapper for us. So lets use
> module_put_and_exit() to avoid a race condition with the module cleanup code.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  net/bluetooth/bnep/core.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)

Both patches have been applied, thanks.

	Gustavo
