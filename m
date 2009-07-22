Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Bluetooth: Add initial support for ERTM packets
 transfers
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1248254976-12090-2-git-send-email-gustavo@las.ic.unicamp.br>
References: <1248254976-12090-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248254976-12090-2-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Wed, 22 Jul 2009 11:51:36 +0200
Message-Id: <1248256296.28545.124.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> This patch adds support for ERTM transfers, without retransmission, with
> txWindow up to 63 and with acknowledgement of packets received.  Now the
> packets are queued before call l2cap_do_send(), so packets couldn't be
> sent at the time we call l2cap_sock_sendmsg(). They will be sent in
> an asynchronous way on later calls of l2cap_ertm_send().  Besides if an
> error occurs on calling l2cap_do_send() we disconnect the channel.

we have to fix the basic comments I gave you on IRC. Then send 2/3 first
and then we go trough this one again.

Regards

Marcel


