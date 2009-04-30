Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Apr 2009 20:58:57 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Marc Pignat <Marc.Pignat@hevs.ch>,
	Roger Quadros <ext-roger.quadros@nokia.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.30-rc4 hid bluetooth not working
In-Reply-To: <1241103783.3389.35.camel@localhost.localdomain>
Message-ID: <alpine.LNX.2.00.0904302056270.5012@wotan.suse.de>
References: <49F9C1AD020000BF00029086@mailgw2.hevs.ch>  <alpine.LRH.2.00.0904301556310.2050@twin.jikos.cz> <1241103783.3389.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 30 Apr 2009, Marcel Holtmann wrote:

> > > My bluetooth keyboard is not working any more in rc4, but was 
> > > working in rc3. Here is the dmesg output, triggered by the first key 
> > > press on the keyboard, fortunately, this is 100% reproductible (once 
> > > per boot).
> > Does reverting f3784d834c7 fix the problem?
> we have seen a similar report where reverting f3784d834c7 didn't fix it. 
> And I don't see anything wrong with that patch. Did something important 
> got changed in the work queue code that I am missing?

Calling flush() from work->func() is not safe. That's what the WARN_ON() 
in flush_cpu_workqueue() is there for, right?

-- 
Jiri Kosina
SUSE Labs
