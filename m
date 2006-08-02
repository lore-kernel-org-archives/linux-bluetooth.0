Return-Path: <hch@lst.de>
Date: Wed, 2 Aug 2006 23:00:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] system freeze in 2.6.17-mh5
Message-ID: <20060802210008.GA3043@lst.de>
References: <20060802120735.632c4f18@p4.prod.lan> <1154525837.3905.49.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154525837.3905.49.camel@aeonflux.holtmann.net>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Aug 02, 2006 at 03:37:17PM +0200, Marcel Holtmann wrote:
> > BUG: scheduling while atomic: swapper/0x00000100/0
> >  <c02ecbd2> wait_for_completion+0x82/0xb6  <c0115504>
> > default_wake_function+0x0/0x12 <c0115504>
> > default_wake_function+0x0/0x12  <c0113c8e> wake_up_process+0xd/0xf
> > <c02e8b6f> hidp_idle_timeout+0x0/0x10  <c01297e2>
> > kthread_stop_sem+0x74/0x93 <c012976b> kthread_stop+0xb/0xe  <c01213bb>

> this looks like a problem with the kthread API. We converted BNEP, CMTP
> and HIDP to it with 2.6.17-mh3. So a 2.6.17-mh2 kernel should work
> without any problems.
> 
> Christoph, any ideas. Did you see a similar problem before.

kthread_stop can sleep, hidp_idle_timeout is called from a timer, thus
running in softirq context.

Why does hidp try to tear down the thread on this timeout anyway?  It
seems much more logical to me to only do it in hidp_del_connection so
that it's symmetric to starting the thread in hidp_add_connection.
