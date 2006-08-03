Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20060802210008.GA3043@lst.de>
References: <20060802120735.632c4f18@p4.prod.lan>
	<1154525837.3905.49.camel@aeonflux.holtmann.net>
	<20060802210008.GA3043@lst.de>
Date: Thu, 03 Aug 2006 12:39:39 +0200
Message-Id: <1154601579.3905.64.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] system freeze in 2.6.17-mh5
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Christoph,

> > > BUG: scheduling while atomic: swapper/0x00000100/0
> > >  <c02ecbd2> wait_for_completion+0x82/0xb6  <c0115504>
> > > default_wake_function+0x0/0x12 <c0115504>
> > > default_wake_function+0x0/0x12  <c0113c8e> wake_up_process+0xd/0xf
> > > <c02e8b6f> hidp_idle_timeout+0x0/0x10  <c01297e2>
> > > kthread_stop_sem+0x74/0x93 <c012976b> kthread_stop+0xb/0xe  <c01213bb>
> 
> > this looks like a problem with the kthread API. We converted BNEP, CMTP
> > and HIDP to it with 2.6.17-mh3. So a 2.6.17-mh2 kernel should work
> > without any problems.
> > 
> > Christoph, any ideas. Did you see a similar problem before.
> 
> kthread_stop can sleep, hidp_idle_timeout is called from a timer, thus
> running in softirq context.
> 
> Why does hidp try to tear down the thread on this timeout anyway?  It
> seems much more logical to me to only do it in hidp_del_connection so
> that it's symmetric to starting the thread in hidp_add_connection.

previously, it was only marking the connection for disconnect:

        atomic_inc(&session->terminate);
        hidp_schedule(session);

After the conversion to kthread API we call kthread_stop() directly and
this is not gonna work.

The hidp_del_connection() is triggered from userspace to terminate an
active HIDP session. Additionally we also need to terminate the HIDP
session after a certain amount of idle time to safe power. In general
the HID input device itself should take care of this, but some of them
simply don't.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
