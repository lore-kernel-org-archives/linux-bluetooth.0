Return-Path: <cyrus@holtmann.org>
Message-ID: <1321707246.1894.2.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: bnep: Fix module reference
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Sat, 19 Nov 2011 13:54:06 +0100
In-Reply-To: <1321705413-2598-2-git-send-email-dh.herrmann@googlemail.com>
References: <1321705413-2598-1-git-send-email-dh.herrmann@googlemail.com>
	 <1321705413-2598-2-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

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

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


