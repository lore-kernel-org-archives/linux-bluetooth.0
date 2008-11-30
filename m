Return-Path: <cyrus@holtmann.org>
Subject: Re: patch: Respect HCI_UART_DEBUG config in hci_ll.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960811201824o64e0d814s8cf55ba6ee145517@mail.gmail.com>
References: <35c90d960811201824o64e0d814s8cf55ba6ee145517@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 30 Nov 2008 10:04:01 +0100
Message-Id: <1228035841.9176.9.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> Author: Nick Pelly <npelly@google.com>
> Date:   Mon Apr 21 12:18:51 2008 -0700
> 
>     bluetooth: Respect HCI_UART_DEBUG config in hci_ll.c
> 
>     Following the pattern from hci_*.c, turn off BT_DBG messages unless
>     they have been requested via HCI_UART_DEBUG
> 
>     Signed-off-by: Brian Swetland <swetland@google.com>

you have to fix your mail client to _NOT_ send mutli-part crap. Please
follow the proper guidelines for sending kernel patches. Otherwise you
make it complicated for me to apply patches. Especially these no
brainers.

So who wrote this patch? You are Brian. If you wrote the patch like
author indicated, then Brian should do an Acked-by unless he actually
sends the patch to me. In this case you send the patch so it should look
like this:

Signed-off-by: Nick Pelly <npelly@google.com>
Acked-by: Brian Swetland <swetland@google.com>

If you wrote the patch and Brian sent it to me, then he has to do
Signed-off since he is part of the chain. It is all documented in the
kernel source code :)

Regards

Marcel


