Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Apr 2014 18:59:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] core: don't set BR/EDR support when no flags present
Message-ID: <20140404155930.GA21082@t440s.P-661HNU-F1>
References: <CAHZ1yCmu26xibOaeGUP3HGhp7cvC0eXuviJBRq2VDD0fE6U6SQ@mail.gmail.com>
 <1396564054-20566-1-git-send-email-scott@netsplit.com>
 <20140404072528.GA16753@t440s.lan>
 <CA+bD78i-x0O2odFSEGwSKHULg-uZ=rR7f9TTetBVnVFrf2T3LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+bD78i-x0O2odFSEGwSKHULg-uZ=rR7f9TTetBVnVFrf2T3LA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Fri, Apr 04, 2014, Scott James Remnant wrote:
> On Fri, Apr 4, 2014 at 12:25 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> 
> > One thing to note regarding this first one: this is actually not a
> > problem with current bluetooth-next since there we merge the adv_ind and
> > scan_rsp into a single mgmt device found event. I.e. with such a kernel
> > we will not need to have this extra non-zero flags check. I added an
> > extra code comment to this place so we don't forget to fix it.
> >
> 
> Makes sense, we're testing with the current
> bluetooth-next/for-upstream tag, and it looks like the
> ADV_IND/SCAN_RSP merging patches aren't submitted yet ;-)
> 
> Won't this mean that the flag checking will be needed on kernels prior
> to 3.15 in either case?

Correct. Prior to 3.16 actually since that's where the merging patches
will land. Once we know the mgmt revision that 3.16 will have (probably
the current one + 1) we can add a check for this to the user space code.

Johan
