Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Feb 2013 16:52:51 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 02/16] Bluetooth: change bt_sock_unregister() to return
 void
Message-ID: <20130226195251.GB10898@joana>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
 <1361731026-7428-3-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361731026-7428-3-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@gmail.com> [2013-02-24 19:36:52 +0100]:

> There is no reason a caller ever wants to check the return type of this
> call. _Iff_ a user successfully called bt_sock_register(), they're allowed
> to call bt_sock_unregister().
> All other calls in the kernel (device_del, device_unregister, kfree(), ..)
> that are logically equivalent return void. Lets not make callers think
> they have to check the return type of this call and instead simply return
> void.
> 
> We guarantee that after bt_sock_unregister() is called, the socket type
> _is_ unregistered. If that is not what the caller wants, they're using the
> wrong function, anyway.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  include/net/bluetooth/bluetooth.h |  2 +-
>  net/bluetooth/af_bluetooth.c      | 15 +++------------
>  2 files changed, 4 insertions(+), 13 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
