Return-Path: <mvdwege@mail.com>
Date: Sat, 2 Sep 2017 09:27:07 +0200
From: Mart van de Wege <mvdwege@mail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@intel.com>, Gustavo Padovan <gustavo@padovan.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, tglx@linutronix.de, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: Possible BT deadlock due to recursive read locking (Was: Re:
 kernel BUG at kernel/locking/rtmutex.c:1059)
Message-ID: <20170902092707.1e8800bb@mail.com>
In-Reply-To: <20170901105107.753617a1@gmail.com>
References: <86val4928u.fsf@gaheris.avalon.lan>
	<20170831145211.xlu6cvocqdkzevsl@linutronix.de>
	<20170901105107.753617a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 1 Sep 2017 10:51:07 +0200
Mart van de Wege <mvdwege@gmail.com> wrote:

> On Thu, 31 Aug 2017 16:52:12 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2017-08-30 23:25:53 [+0200], Mart van de Wege wrote:  
> > > Hi,    
> > Hi,
> >   
> > > The issue persists up to v4.11.12-rt10    
> > Does
> > 	CONFIG_RWLOCK_RT_READER_BIASED=y
> > make it go away?
> >   
> Yes, that does make it go away. -rt8 now boots cleanly, and works
> fine. Building -rt10 now to be sure.
> 
Confirm that as of 4.11.12-rt11 the deadlock still goes away when
enabling CONFIG_RWLOCK_RT_READER_BIASED

Mart
