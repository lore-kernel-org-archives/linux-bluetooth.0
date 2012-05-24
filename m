Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 14:08:11 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 8/8] Bluetooth: Add chan->ops->authorize
Message-ID: <20120524170811.GG3105@joana>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
 <1337821964-4618-3-git-send-email-gustavo@padovan.org>
 <1337821964-4618-4-git-send-email-gustavo@padovan.org>
 <1337821964-4618-5-git-send-email-gustavo@padovan.org>
 <1337821964-4618-6-git-send-email-gustavo@padovan.org>
 <1337821964-4618-7-git-send-email-gustavo@padovan.org>
 <1337821964-4618-8-git-send-email-gustavo@padovan.org>
 <1337821964-4618-9-git-send-email-gustavo@padovan.org>
 <20120524095551.GO24715@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120524095551.GO24715@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2012-05-24 12:55:53 +0300]:

> Hi Gustavo,
> 
> On Wed, May 23, 2012 at 10:12:44PM -0300, Gustavo Padovan wrote:
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > 
> > When DEFER_SETUP is set authorize() will trigger an authorization request
> > to the userspace.
> 
> Looks good.
> 
> > +static void l2cap_sock_authorize_cb(void *data)
> > +{
> > +	struct sock *sk = data;
> > +	struct sock *parent;
> > +
> > +	parent = bt_sk(sk)->parent;
> 
> But why not:
> 
> l2cap_sock_authorize_cb(struct sock *sk)
> {
> 	struct sock *parent = bt_sk(sk)->parent;

We need to be generic, I said that in the other patch already. The chan->sk
should disappear and the only thing l2cap_core.c will see is chan->data void *

	Gustavo
