Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Feb 2013 16:52:16 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 01/16] Bluetooth: discard bt_sock_unregister() errors
Message-ID: <20130226195216.GA10898@joana>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
 <1361731026-7428-2-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361731026-7428-2-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@gmail.com> [2013-02-24 19:36:51 +0100]:

> After we successfully registered a socket via bt_sock_register() there is
> no reason to ever check the return code of bt_sock_unregister(). If
> bt_sock_unregister() fails, it means the socket _is_ already unregistered
> so we have what we want, don't we?
> 
> Also, to get bt_sock_unregister() to fail, another part of the kernel has
> to unregister _our_ socket. This is sooo _wrong_ that it will break way
> earlier than when we unregister our socket.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  net/bluetooth/bnep/sock.c   | 4 +---
>  net/bluetooth/cmtp/sock.c   | 4 +---
>  net/bluetooth/hci_sock.c    | 4 +---
>  net/bluetooth/hidp/sock.c   | 4 +---
>  net/bluetooth/l2cap_sock.c  | 4 +---
>  net/bluetooth/rfcomm/sock.c | 3 +--
>  net/bluetooth/sco.c         | 3 +--
>  7 files changed, 7 insertions(+), 19 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
