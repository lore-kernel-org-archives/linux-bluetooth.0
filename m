Return-Path: <cyrus@holtmann.org>
Message-ID: <1337385587.2058.31.camel@aeonflux>
Subject: Re: [PATCH -v3] Bluetooth: Add MSG_MORE support to L2CAP sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 18 May 2012 16:59:47 -0700
In-Reply-To: <1337384778-25135-1-git-send-email-gustavo@padovan.org>
References: <1337384778-25135-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> MSG_MORE enables us to save buffer space in userspace, the packet is
> built directly in the kernel and sent only when a msg with the MSG_MORE
> flag not set arrives. If a send() tries to add more chan->omtu bytes
> -EMSGSIZE is returned.
> 
> Only MSG_MORE for Basic Mode is supported right now. chan->skb_more keeps
> a pointer to the L2CAP packet that is being build through many calls to
> send().

so this is really not acceptable. We need to start supporting all modes
with MSG_MORE at the same time. Otherwise we can not merge this.

Regards

Marcel


