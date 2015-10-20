Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [RFC] Bluetooth: Remove __l2cap_wait_ack
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1444914416-27666-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 20 Oct 2015 15:42:54 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <23564B56-4366-41F0-A1D8-91970EC7E61C@holtmann.org>
References: <1444914416-27666-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> __l2cap_wait_ack probably cause more harm than good since it was added as
> a feature to wait until all unacked packets are processed and properly
> acked by the remote but it ignored the fact that the remote may probably
> wait some window threshold before start acking.
> 
> Since the window threshold is implementation specific, we ack when the
> window is 3/4th full, it should probably be the receiving side that
> should ack or discard the packets in the queue when processing the
> Disconnect request.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 50 ----------------------------------------------
> 1 file changed, 50 deletions(-)

I would feel a lot better if we had a l2cap-tester test case or two to confirm the expected behavior.

Additionally has anyone tested this patch and confirmed that it does not do harm or break qualification?

Regards

Marcel

