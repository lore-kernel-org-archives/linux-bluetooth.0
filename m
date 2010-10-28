Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 28 Oct 2010 10:58:36 +0100
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Yuri Ershov <ext-yuri.ershov@nokia.com>
Cc: marcel@holtmann.org, davem@davemloft.net, jprvita@profusion.mobi,
	linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
	andrei.emeltchenko@nokia.com
Subject: Re: [PATCH] bluetooth: Fix NULL pointer dereference issue
Message-ID: <20101028095836.GC15997@vigoh>
References: <1987fd374e92ea2e4ebb06b24c6321e65ab933c6.1287676475.git.ext-yuri.ershov@nokia.com>
 <20101022135859.GA15476@vigoh>
 <4CC576D3.2090304@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CC576D3.2090304@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yuri,

Please no top posting in this mainling list. It's not allowed, thanks.

* Yuri Ershov <ext-yuri.ershov@nokia.com> [2010-10-25 16:23:47 +0400]:

> Hello Gustavo,
> 
> The problem appears in case of multiple connect-transfer-disconnect 
> sequence (e.g. by using l2test). The conditions are the following:
> There are 2 BT devices. The first one listens and receives (l2test -r), 
> the second one makes "connect-disconnect-connect..." sequence (l2test -c 
> -b 1000 -i hci0 -P 10 <addr>). After some time this will cause the race 
> between functions bt_accept_dequeue and l2cap_chan_del. The fail sequence:
> 
> struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
> {
> ...
>     list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
>         sk = (struct sock *) list_entry(p, struct bt_sock, accept_q);
> 
>         lock_sock(sk);
> 
> 
> 
> In this time the function l2cap_chan_del sets the socket state to 
> BT_CLOSED, unlinks and kills the socket.
> 
> 
> 
>         /* FIXME: Is this check still needed */
>         if (sk->sk_state == BT_CLOSED) {
>             release_sock(sk);
>             bt_accept_unlink(sk);
>             continue;
>         }
> 
> ...
> 
>         release_sock(sk);
>     }
>     return NULL;
> }


I agree with you, just add this info to your commit message and then
resend your patch so I can apply it.

> ext Gustavo F. Padovan wrote:
> > Hi Yuri,
> >
> > * Yuri Ershov <ext-yuri.ershov@nokia.com> [2010-10-21 20:08:58 +0400]:
> >
> >   
> >> This patch fixes NULL pointer dereference at running test with
> >> connect-transfer-disconnect in loop. Sometimes sk_state is 
> >> BT_CLOSED and sk_refcnt equal to 0, so there is oops in 
> >> bt_accept_unlink. In normal case removed block is not used.
> >>     
> >
> > Question here is: Why sk_refcnt is 0 at that point of the code?  The
> > socket should be destroyed if it ref is 0, but it wasn't, so something
> > in another point of the code went is wrong. "Sometimes" is not a good
> > description of the problem, you have to show why that happened.
> >
> >   
> 

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
