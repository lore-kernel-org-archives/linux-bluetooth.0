Return-Path: <sjoerd@spring.luon.net>
Date: Thu, 30 Sep 2004 19:06:02 +0200
From: Sjoerd Simons <sjoerd@spring.luon.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Sending files from phone to ppc machine fails
Message-ID: <20040930170602.GA13427@spring.luon.net>
References: <20040930161652.GA10170@spring.luon.net> <1096563173.4371.5.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096563173.4371.5.camel@notepaq>
List-ID: <bluez-users.lists.sourceforge.net>

On Thu, Sep 30, 2004 at 06:52:53PM +0200, Marcel Holtmann wrote:
> Hi Sjoerd,
> 
> >   Since some time i've got an Ericsson T630. Sending files via obex from
> >   both my ppc and x86 machine to the phone works fine. But from the phone i
> >   can only send stuff to the x86. When sending to my powerbook the phone
> >   almost immediatly indicates ``connection failed''. 
> > [...]
> > 
> >   Any ideas what could be going wrong here ?
> 
> stop hidd and see if it works then.

That does indeed solve it (should have though about trying that). Could you
explain what's going wrong with hidd (yes i'm curious) ?

Thanks,
  Sjoerd
-- 
Never worry about theory as long as the machinery does what it's supposed to do.
		-- R. A. Heinlein
