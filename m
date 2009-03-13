Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Mar 2009 17:20:33 +0000
From: James Le Cuirot <chewi@aura-online.co.uk>
To: linux-bluetooth@vger.kernel.org
Subject: Re: PANU currently broken?
Message-ID: <20090313172033.13e0ed4a@symphony>
In-Reply-To: <2d5a2c100903120723m5ce4a0fcp59d5de8a09aa6242@mail.gmail.com>
References: <20090308232215.727f38fa@symphony>
	<20090312111123.2763cd79@symphony>
	<2d5a2c100903120723m5ce4a0fcp59d5de8a09aa6242@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 12 Mar 2009 11:23:40 -0300
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> On Thu, Mar 12, 2009 at 8:11 AM, James Le Cuirot
> <chewi@aura-online.co.uk> wrote:
> > On Sun, 8 Mar 2009 23:22:15 +0000
> > James Le Cuirot <chewi@aura-online.co.uk> wrote:
> >  
> >> I've managed to serve my phone with NAP successfully but using
> >> PANU in the other direction has not worked at all.  
> >
> > I'm not necessarily asking for an immediate fix here but could
> > someone at least explain the situation? That might allow me to fix
> > it myself.  
> 
> I have a fix for it, the problem was that we use
> g_io_channel_set_close_on_unref on BtIO code so we should maintain a
> reference if we want to maintain the socket open.
> 
> Try this patch and see if it helps:
> http://gitorious.org/projects/bluez/repos/vudentzs-clone/commits/adaf1c1d4f2c8764c3d5336759368a0e1dcb44c9
> 
> ps: we are still reviewing the code so it may have some bug left.

Thanks, Luiz.

I'm afraid it's still not working though. I tried the patch on its own
against 4.32 and also the latest from the for-upstream branch. I
generally get "bnep setup failed" as well as "Hangup or error on l2cap
server socket" in the log.

James
