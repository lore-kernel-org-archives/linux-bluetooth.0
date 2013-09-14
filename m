Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Sep 2013 08:50:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Fix waiting for clearing of BT_SK_SUSPEND
 flag
Message-ID: <20130914055018.GB2777@x220.p-661hnu-f1>
References: <1379061827-8595-1-git-send-email-johan.hedberg@gmail.com>
 <1379061827-8595-4-git-send-email-johan.hedberg@gmail.com>
 <4A92D017-F4C7-49FF-BFA3-D9E508E51DED@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A92D017-F4C7-49FF-BFA3-D9E508E51DED@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Sep 13, 2013, Marcel Holtmann wrote:
> > In the case of blocking sockets we should not proceed with sendmsg() if
> > the socket has the BT_SK_SUSPEND flag set. So far the code was only
> > ensuring that POLLOUT doesn't get set for non-blocking sockets using
> > poll() but there was no code in place to ensure that blocking sockets do
> > the right thing when writing to them.
> > 
> > This patch adds a new bt_sock_wait_unsuspend helper function to sleep in
> > the sendmsg call if the BT_SK_SUSPEND flag is set, and wake up as soon
> > as it is unset. It also updates the L2CAP and RFCOMM sendmsg callbacks
> > to take advantage of this new helper function.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> > include/net/bluetooth/bluetooth.h |  1 +
> > net/bluetooth/af_bluetooth.c      | 38 ++++++++++++++++++++++++++++++++++++++
> > net/bluetooth/l2cap_sock.c        |  6 ++++++
> > net/bluetooth/rfcomm/sock.c       |  7 +++++--
> > 4 files changed, 50 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index 10d43d8..3299d42 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -249,6 +249,7 @@ int  bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
> > uint bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
> > int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
> > int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
> > +int  bt_sock_wait_unsuspend(struct sock *sk, unsigned long flags);
> 
> I am not a huge fan of the term unsuspend. Maybe wait_ready is better here.

I'll change it to wait_ready in the next version. I used unsuspend
simply because it waits for the clearing of a flag called SUSPEND.

Johan
