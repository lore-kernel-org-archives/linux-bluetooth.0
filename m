Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Feb 2009 18:22:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        hidave.darkstar@gmail.com, mingo@elte.hu
Subject: Re: [patch 2/2] bluetooth: CONFIG_DEBUG_LOCK_ALLOC ifdefs remove
Message-Id: <20090211182253.1a5b9651.akpm@linux-foundation.org>
In-Reply-To: <1234403558.7293.28.camel@violet>
References: <200902112128.n1BLSCdw000376@imap1.linux-foundation.org>
	<1234403558.7293.28.camel@violet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 12 Feb 2009 02:52:38 +0100 Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Andrew,
> 
> > Due to lockdep changes the CONFIG_DEBUG_LOCK_ALLOC ifdef is not needed
> > now, just remove it here.
> > 
> > The following commit fixed the !lockdep build warnings:
> 
> already part of my bluetooth-testing.git tree.
> 

Well, I have no way of knowing this, because that tree is not
in linux-next.

Please get it added?
