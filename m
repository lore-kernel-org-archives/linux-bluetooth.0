Return-Path: <cyrus@holtmann.org>
Message-ID: <1334850818.16897.294.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: Don't check source address in SCO bind
 function
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 19 Apr 2012 17:53:38 +0200
In-Reply-To: <20120419145222.GE4127@joana>
References: <1334835833-21828-3-git-send-email-marcel@holtmann.org>
	 <20120419145222.GE4127@joana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> * Marcel Holtmann <marcel@holtmann.org> [2012-04-19 13:43:53 +0200]:
> 
> > Checking the source address in SCO bind function will prevent from
> > having an incoming and outgoing SCO socket. However that might be
> > needed in case of multiple SCO connections on a single device.
> > 
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > ---
> >  net/bluetooth/sco.c |   16 ++++++----------
> >  1 files changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index 2fb9636..8b2548c 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -463,7 +463,6 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
> >  {
> >  	struct sockaddr_sco *sa = (struct sockaddr_sco *) addr;
> >  	struct sock *sk = sock->sk;
> > -	bdaddr_t *src = &sa->sco_bdaddr;
> >  	int err = 0;
> >  
> >  	BT_DBG("sk %p %s", sk, batostr(&sa->sco_bdaddr));
> > @@ -478,17 +477,14 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
> >  		goto done;
> >  	}
> >  
> > -	write_lock(&sco_sk_list.lock);
> > -
> > -	if (bacmp(src, BDADDR_ANY) && __sco_get_sock_by_addr(src)) {
> > -		err = -EADDRINUSE;
> 
> this patch adds a compiling warning:
> 
>   CC [M]  net/bluetooth/sco.o
>   net/bluetooth/sco.c:277:21: warning: ‘__sco_get_sock_by_addr’ defined
>   but not used [-Wunused-function]

I am fixing that with the next patch. I just ended up splitting them
into two to get this logical correct.

Regards

Marcel


