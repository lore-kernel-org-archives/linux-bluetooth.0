Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Jun 2011 18:50:26 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/6] Bluetooth: add close() callback to l2cap_chan_ops
Message-ID: <20110602215026.GC2790@joana>
References: <1307031329-8001-1-git-send-email-padovan@profusion.mobi>
 <1307031329-8001-2-git-send-email-padovan@profusion.mobi>
 <1307031329-8001-3-git-send-email-padovan@profusion.mobi>
 <alpine.DEB.2.02.1106021412530.3205@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1106021412530.3205@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-06-02 14:30:41 -0700]:

> 
> Hi Gustavo -
> 
> 
> On Thu, 2 Jun 2011, Gustavo F. Padovan wrote:
> 
> >close() calls l2cap_sock_kill() on l2cap_sock.c
> >
> >Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> >---
> >include/net/bluetooth/l2cap.h |    3 +--
> >net/bluetooth/l2cap_core.c    |   17 +++++++++--------
> >net/bluetooth/l2cap_sock.c    |   10 +++++++++-
> >3 files changed, 19 insertions(+), 11 deletions(-)
> 
> <snip>
> 
> >--- a/net/bluetooth/l2cap_sock.c
> >+++ b/net/bluetooth/l2cap_sock.c
> >@@ -679,7 +679,7 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
> >/* Kill socket (only if zapped and orphan)
> > * Must be called on unlocked socket.
> > */
> >-void l2cap_sock_kill(struct sock *sk)
> >+static void l2cap_sock_kill(struct sock *sk)
> >{
> >	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
> >		return;
> >@@ -762,10 +762,18 @@ static int l2cap_chan_recv_cb(void *data, struct sk_buff *skb)
> >	return sock_queue_rcv_skb(sk, skb);
> >}
> >
> >+static void l2cap_chan_close_cb(void *data)
> >+{
> >+	struct sock *sk = data;
> >+
> >+	l2cap_sock_kill(sk);
> >+}
> >+
> >static struct l2cap_ops l2cap_chan_ops = {
> >	.name		= "L2CAP Socket Interface",
> >	.new_connection	= l2cap_chan_new_connection_cb,
> >	.recv		= l2cap_chan_recv_cb,
> >+	.close		= l2cap_chan_close_cb,
> >};
> >
> >static void l2cap_sock_destruct(struct sock *sk)
> 
> 
> It looks like we'll have l2cap_ops for sock, rfcomm, and AMP's A2MP
> channel -- so I would suggest using unique names for the callbacks
> for each of those modules:
> 
> l2cap_sock_new_connection_cb
> l2cap_sock_recv_cb
> l2cap_sock_close_cb
> 
> l2cap_a2mp_new_connection_cb
> l2cap_a2mp_recv_cb
> l2cap_a2mp_close_cb
> 
> etc., instead of "l2cap_chan_*_cb"
> 
> Even though the functions are (or will be) static within their
> respective files, it will be less confusing if their names tie them
> to the specific module.

I'm not sure, what I'm trying to avoid here is create a false relation between
l2cap_sock_close and l2cap_sock_close_cb for example, thus I called it
l2cap_chan_close_cb. But unique names are indeed a good idea.

Maybe, l2cap_sock_chan_new_cb, l2cap_sock_chan_close_cb,
l2cap_sock_chan_recv_cb. But those are a bit big.

> 
> I hope you can check these in to bluetooth-next soon, it would help
> with the patch set I'm working on.

Btw, I really want to fix this L2CAP mess before push any A2MP stuff into the
tree. A2MP code shouldn't touch sockets at all. I don't want to bring more
issues to the stack like the many we have for RFCOMM.
I intend to finish this soon. Patches are welcome. :)

-- 
Gustavo F. Padovan
http://profusion.mobi
