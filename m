Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Apr 2009 19:32:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Stuart Pook <linux-bluetooth4@pook.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd 4.37 -> Segmentation fault
Message-ID: <20090429163255.GA27251@jh-x301>
References: <49F8638C.5070205@pook.es> <20090429160430.GA25611@jh-x301> <49F87CFF.4090804@pook.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F87CFF.4090804@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

On Wed, Apr 29, 2009, Stuart Pook wrote:
> > It'd be good if you could get a trace with debug symbols so we see the
> > exact line numbers.
> 
> Why don't I have debug symbols? Does the default make not add debug
> symbols? I guess that I'll have to look at how I call configure.

I think --enable-debug should be enough.

> > However, before that could you check with latest git
> > if you still experience this crash.
> 
> Do I have to update the client plugins as well or can I mix a bluetoothd 
> from git with the plugins from 4.37?

The easiest way to try git and avoid messing with your current system is 
to build using ./bootstrap-configure && make and run bluetoothd directly 
from the source tree. bootstrap-configure uses the 
--enable-maintainer-mode configure switch which makes bluetoothd load the 
plugins right out of the source tree, so you don't need to worry about 
version conflicts with your existing system.

> > There's at least one commit since
> > 4.37 (7fb4d906c00bf6e2ed03cc3e880bab52b8a984d6) that fixes a crash issue
> > with client_free.
> 
> Should I always try the git version before reporting bugs?

If possible, yes please. It eliminates the question "has this been fixed 
since the last release?" and makes it easier for the developers to match 
the line numbers in the backtrace (assuming you have debug symbols) to 
their development trees which are mostly based on latest git.

Johan
