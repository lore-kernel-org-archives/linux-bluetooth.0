Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 3/3] Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379061827-8595-4-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 13 Sep 2013 18:43:58 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4A92D017-F4C7-49FF-BFA3-D9E508E51DED@holtmann.org>
References: <1379061827-8595-1-git-send-email-johan.hedberg@gmail.com> <1379061827-8595-4-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In the case of blocking sockets we should not proceed with sendmsg() if
> the socket has the BT_SK_SUSPEND flag set. So far the code was only
> ensuring that POLLOUT doesn't get set for non-blocking sockets using
> poll() but there was no code in place to ensure that blocking sockets do
> the right thing when writing to them.
> 
> This patch adds a new bt_sock_wait_unsuspend helper function to sleep in
> the sendmsg call if the BT_SK_SUSPEND flag is set, and wake up as soon
> as it is unset. It also updates the L2CAP and RFCOMM sendmsg callbacks
> to take advantage of this new helper function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/bluetooth.h |  1 +
> net/bluetooth/af_bluetooth.c      | 38 ++++++++++++++++++++++++++++++++++++++
> net/bluetooth/l2cap_sock.c        |  6 ++++++
> net/bluetooth/rfcomm/sock.c       |  7 +++++--
> 4 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 10d43d8..3299d42 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -249,6 +249,7 @@ int  bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
> uint bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
> int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
> int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
> +int  bt_sock_wait_unsuspend(struct sock *sk, unsigned long flags);

I am not a huge fan of the term unsuspend. Maybe wait_ready is better here.

Regards

Marcel

