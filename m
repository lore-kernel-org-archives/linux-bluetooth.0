Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Oct 2010 15:05:40 -0700
From: Greg KH <greg@kroah.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, stable@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [stable] [PATCH 0/1] Bluetooth: fix crash in L2CAP
Message-ID: <20101029220540.GA16819@kroah.com>
References: <1287638393-8573-1-git-send-email-padovan@profusion.mobi>
 <20101021133507.GB20184@kroah.com>
 <20101025111530.GC7721@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101025111530.GC7721@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 25, 2010 at 09:15:30AM -0200, Gustavo F. Padovan wrote:
> Hi Greg,
> 
> * Greg KH <greg@kroah.com> [2010-10-21 06:35:07 -0700]:
> 
> > On Thu, Oct 21, 2010 at 03:19:52AM -0200, Gustavo F. Padovan wrote:
> > > Hi Greg,
> > > 
> > > The following patch is good for 2.6.36.1. It arrived too late in linux-bluetooth
> > > and we didn't had time to put it into 2.6.36. It fixes a serious crash into
> > > the L2CAP layer. The issue isn't in 2.6.35 and below.
> > 
> > It needs to get into Linus's tree before I can accept it into the
> > -stable trees.  Please get it there and then send stable@kernel.org the
> > git commit id and I will add it.
> 
> It is now on Linus' tree, sorry for doing this wrong first time. It was
> my first report to stable. ;)

No problem.

> commit d793fe8caa3911e6a1e826b45d4ee00d250cdec8

Now queued up, thanks.

greg k-h
