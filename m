Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Feb 2012 10:58:43 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 02/16] Bluetooth: Revert to mutexes from RCU list
Message-ID: <20120213085841.GB21179@aemeltch-MOBL1>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328882113-19810-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAA37ikZ7Ph3D_fBMLFQ_rh2JDJY2LXPzKWkLcQEsXutcj1idxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAA37ikZ7Ph3D_fBMLFQ_rh2JDJY2LXPzKWkLcQEsXutcj1idxA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Fri, Feb 10, 2012 at 04:24:57PM -0200, Ulisses Furquim wrote:
> Hi Andrei,
> 
> On Fri, Feb 10, 2012 at 11:54 AM, Emeltchenko Andrei
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Usage of RCU list looks not reasonalbe for a number of reasons:
> > our code sleep and we have to use socket spinlocks, some parts
> > of code are updaters thus we need to use mutexes anyway.
> >
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> No need to lock and unlock conn->chan_lock in l2cap_disconnect_rsp()?
> This change from RCU to mutexes really should be just one commit IMO.

I try to add chunks which are not in different patches but then this patch
would several hundreds lines long. If this OK I just merge them.

> This series is starting to get all confused. The change to RCU was
> only one commit so it should be possible to do the "revert" without
> breaking anything.

"Anything" is already broken in a sense that RCU updaters are not
protected at all. So the change does not make it more or less broken.

Best regards 
Andrei Emeltchenko 

