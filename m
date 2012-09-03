Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
CC: Gustavo Padovan <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Use GFP_KERNEL in read_index_list
Date: Mon, 3 Sep 2012 15:07:36 +0200
Message-ID: <1621656.TPhNxgHnm6@uw000953>
In-Reply-To: <4083892.2VCRePhfBH@uw000953>
References: <1346396746-3479-1-git-send-email-szymon.janc@tieto.com> <20120903123404.GA2789@aemeltch-MOBL1> <4083892.2VCRePhfBH@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 03 of September 2012 14:49:59 Szymon Janc wrote:
> On Monday 03 of September 2012 15:34:11 Andrei Emeltchenko wrote:
> > Hi all,
> 
> Hi Andrei,
> 
> > 
> > On Fri, Aug 31, 2012 at 10:54:58AM -0700, Gustavo Padovan wrote:
> > > Hi Szymon,
> > > 
> > > * Szymon Janc <szymon.janc@tieto.com> [2012-08-31 09:05:46 +0200]:
> > > 
> > > > read_index_list is executed by user thread running in kernel-mode
> > > > thus is allowed to sleep.
> > > > 
> > > > Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> > > > ---
> > > >  net/bluetooth/mgmt.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Patch has been applied to bluetooth-next. Thanks.
> > 
> > Was this tested? Gustavo please remove this patch from the tree untill
> > this issue is fixed.
> 
> read_index_list() is only called from mgmt_control() (via mgmt_handlers[]).
> mgmt_control (as well as other mgmt_handlers) allocate memory with
> GFP_KERNEL flag.
> 
> I'm not sure why do you get this warning...

Ahhh, rwlock is held while doing memory allocation..
Yes, this should be reverted.

-- 
Szymon Janc
