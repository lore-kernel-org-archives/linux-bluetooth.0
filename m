Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 14:25:38 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 1/8] Bluetooth: Move clean up code and set of SOCK_ZAPPED
 to l2cap_sock.c
Message-ID: <20120524172538.GB10754@samus>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
 <20120524093557.GJ24715@aemeltch-MOBL1>
 <20120524165611.GB3105@joana>
 <20120524171431.GI3105@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120524171431.GI3105@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 14:14 Thu 24 May, Gustavo Padovan wrote:
> * Gustavo Padovan <gustavo@padovan.org> [2012-05-24 13:56:11 -0300]:
> 
> > > >  
> > > > +static void l2cap_sock_finalize_cb(void *data, int err)
> > > > +{
> > > > +	struct sock *sk = data;
> > > 
> > > Why we cannot just use l2cap_sock_finalize_cb(struct sock *sk, int err)
> > > what is the reason for extra assignment?
> > 
> > Because we want to be generic here, we don't know who else will use finalize()
> > so we need to keep a void * here.
> > 
> > > 
> > > I also think finalize is not good name since it does not mean what is
> > > actually finalized.
> > 
> > And it is not, I failed to come with a better name here. The initial one was
> > delete, even worse.
> 
> Maybe we can go with prepare_finalize() or prepare_close() here.

That sounds better, there's "teardown" too.

> 
> 	Gustavo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
