Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 7 Dec 2010 13:50:38 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Yuri Ershov <ext-yuri.ershov@nokia.com>
Cc: marcel@holtmann.org, davem@davemloft.net, jprvita@profusion.mobi,
	ville.tervo@nokia.com, andrei.emeltchenko@nokia.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] bluetooth: Fix NULL pointer dereference issue
Message-ID: <20101207155037.GA2944@vigoh>
References: <e98b2c6fd02b11300d82577cb54cfdb63e8400d2.1290678703.git.ext-yuri.ershov@nokia.com>
 <20101206211516.GH883@vigoh>
 <4CFE32A0.6090601@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CFE32A0.6090601@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yuri,

* Yuri Ershov <ext-yuri.ershov@nokia.com> [2010-12-07 16:12:00 +0300]:

> Hello Gustavo,
> 
> ext Gustavo F. Padovan wrote:
> > Hi Yuri,
> >
> > * Yuri Ershov <ext-yuri.ershov@nokia.com> [2010-11-25 12:55:33 +0300]:
> >
> >   
> >> This patch is an addition to my previous patch for this issue.
> >> The problem is in resynchronization between two loops:
> >> 1. Main controlling loop (l2cap_connect_req, l2cap_config_req,
> >> l2cap_config_rsp, l2cap_disconnect_req, etc.)
> >> 2. Loop waiting of BT_CONNECTED state of socket (l2cap_sock_accept,
> >> bt_accept_dequeue, etc.).
> >> In case of fast sequence of connect/disconnect operations the loop #1
> >> makes several cycles, while the loop #2 only has time to make one
> >> cycle and it results crash.
> >> The aim of the patch is to skeep handling of sockets queued for
> >> deletion.
> >>
> >> Signed-off-by: Yuri Ershov <ext-yuri.ershov@nokia.com>
> >> ---
> >>  net/bluetooth/af_bluetooth.c |    2 ++
> >>  net/bluetooth/l2cap.c        |    6 ++++--
> >>  2 files changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> >> index c4cf3f5..f9389da 100644
> >> --- a/net/bluetooth/af_bluetooth.c
> >> +++ b/net/bluetooth/af_bluetooth.c
> >> @@ -200,6 +200,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
> >>  	BT_DBG("parent %p", parent);
> >>  
> >>  	list_for_each_safe(p, n, &bt_sk(parent)->accept_q) {
> >> +		if (n == p)
> >> +			break;
> >>     
> >
> > So in which situations (n == p), or (p == p->next)? That should happen only
> > when p is the only element in the list, then p == head, right?
> >   
> The (n == p) is in situation, when sk is unlinked by task responsible 
> for handling connect/disconnect requests while the "bt_accept_dequeue". 
> This condition is indirect checking of sk validity.

Why not using a list lock here instead? Fits a way better.

-- 
Gustavo F. Padovan
http://profusion.mobi
