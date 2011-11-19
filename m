Return-Path: <cyrus@holtmann.org>
Message-ID: <1321707222.1894.1.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: cmtp: Fix module reference
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Sat, 19 Nov 2011 13:53:42 +0100
In-Reply-To: <1321705413-2598-1-git-send-email-dh.herrmann@googlemail.com>
References: <1321705413-2598-1-git-send-email-dh.herrmann@googlemail.com>
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
>  net/bluetooth/cmtp/core.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


