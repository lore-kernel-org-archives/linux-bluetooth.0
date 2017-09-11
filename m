Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 11 Sep 2017 12:29:55 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Gabriel C <nix.or.die@gmail.com>, Tejun Heo <tj@kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Sukumar Ghorai <sukumar.ghorai@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: btusb "firmware request while host is not available" at resume
Message-ID: <20170911192955.GB23729@kroah.com>
References: <CA+55aFztG626Np=z2WUzeVS1O3nmoTj76QRUBPg0J-FBELO7vw@mail.gmail.com>
 <20170911012508.GA17754@kroah.com>
 <9bc9cc83-212a-b39c-75af-b94fe6cab9f4@gmail.com>
 <d68738f6-b079-0fef-dd9c-dca75e756c42@gmail.com>
 <CA+55aFzWABZ+KCKT+r+TgyrWfnc+6YE7ZuHhZmgw-cRQXWTQ2w@mail.gmail.com>
 <E31F8274-519A-4ED7-90C0-2BB71C9CC3ED@holtmann.org>
 <20170911134647.GA3980@kroah.com>
 <20170911171138.GA16216@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170911171138.GA16216@wotan.suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 11, 2017 at 07:11:38PM +0200, Luis R. Rodriguez wrote:
> On Mon, Sep 11, 2017 at 06:46:47AM -0700, Greg Kroah-Hartman wrote:
> > To confirm, reverting this fixes the problem I was seeing in 4.13.  I've
> > queued it up for the next 4.13-stable release as well.
> 
> Commit 81f95076281f ("firmware: add sanity check on shutdown/suspend") may
> seem kludgy but the reason for it was to cleanup the horrible forced and
> required UMH lock even when the UMH lock was *not* even needed, which was later
> removed via commit 06a45a93e7d34aa ("firmware: move umh try locks into the umh
> code").

So what does this mean now that it is reverted?

> Removing the old UMH lock even when the UMH lock was *not* needed was the right
> thing to do but commit 81f95076281f (("firmware: add sanity check on
> shutdown/suspend") was put in place as a safe guard as the lock was also
> placing an implicit sanity check on the API. It ensures the API with the cache
> was used as designed, otherwise you do run the risk of *not getting the
> firmware you may need* -- Marcel seems to acknowledge this possibility.
> 
> It may be possible for us to already have in place safeguards so that upon
> resume we are ensuring the path to the firmware *is* available, so IMHO we
> should remove this *iff* we can provide this guarantee.  Otherwise the check is
> valid. You see, although the UMH lock was bogus, it did implicitly ask the
> question: is it safe for *any* helper to run and make assumptions on the
> filesystem then?
> 
> In lieu of this question being answered the warning is valid given the design
> of the firmware API and the having the cache available as a measure to resolve
> this race.

I don't understand what you are trying to say here at all.

To be specific, what, if anything, is a problem with the current state
of Linus's tree (and the next 4.13-stable release)?

If something needs to be fixed, can you make a patch showing that?  Or
do we also need to revert anything else as well to get back to a "better
working" state?

thanks,

greg k-h
