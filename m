Return-Path: <cyrus@holtmann.org>
Message-ID: <1330734830.3392.132.camel@aeonflux>
Subject: Re: [RFC] btio: Adjust socket buffers to be at least as big as MTU
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 02 Mar 2012 16:33:50 -0800
In-Reply-To: <1328884361-3909-1-git-send-email-luiz.dentz@gmail.com>
References: <1328884361-3909-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Maybe could be done in kernel automatically as it could be considered
> broken in case of SOCK_SEQPACKET if socket buffer cannot hold a
> write/read of MTU size.

I have actually no idea what the right approach here is, but we should
handle this inside the kernel.

So should setting a too large MTU fail if the socket buffers are too
small? Or just we just adjust the socket buffers when a large MTU is
set? Any comments?

Regards

Marcel


