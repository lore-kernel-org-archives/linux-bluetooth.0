Return-Path: <lurodriguez@suse.de>
Date: Mon, 11 Sep 2017 19:11:38 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Gabriel C <nix.or.die@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Sukumar Ghorai <sukumar.ghorai@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: btusb "firmware request while host is not available" at resume
Message-ID: <20170911171138.GA16216@wotan.suse.de>
References: <CA+55aFztG626Np=z2WUzeVS1O3nmoTj76QRUBPg0J-FBELO7vw@mail.gmail.com>
 <20170911012508.GA17754@kroah.com>
 <9bc9cc83-212a-b39c-75af-b94fe6cab9f4@gmail.com>
 <d68738f6-b079-0fef-dd9c-dca75e756c42@gmail.com>
 <CA+55aFzWABZ+KCKT+r+TgyrWfnc+6YE7ZuHhZmgw-cRQXWTQ2w@mail.gmail.com>
 <E31F8274-519A-4ED7-90C0-2BB71C9CC3ED@holtmann.org>
 <20170911134647.GA3980@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170911134647.GA3980@kroah.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 11, 2017 at 06:46:47AM -0700, Greg Kroah-Hartman wrote:
> On Mon, Sep 11, 2017 at 07:12:44AM +0200, Marcel Holtmann wrote:
> > Hi Linus,
> > 
> > >> Yes 81f95076281f is to blame.. After reverting it all is fine again.
> > >> 
> > >> 15 resume cycles on the one laptop , 10 on the other without to hit the
> > >> trace.
> > > 
> > > Yeah, I think that disable/enable_firmware in the suspend/resume path
> > > is basically just completely random code. There  is nothing that
> > > serializes with anything else, and it has no actual basis for saying
> > > "I am now disabled/enabled" except for some entirely random time of
> > > whenever the suspend/resume callbacks happen.
> > > 
> > > I'm going to revert it.
> > > 
> > > I wonder why 4.13 seemed to work for me. Or maybe it didn't, and I
> > > just didn't notice, because I didn't use bluetooth and I wasn't
> > > traveling. I test my laptop every release, but I don't necessarily
> > > always _use_ it.
> > 
> > we have a bug report that might go into the similar direction. So the
> > problem is that modern Bluetooth controller require full firmware
> > loading (not just ROM patching) and if the controller has the firmware
> > somehow already loaded, but then looses power and needs a reload, then
> > it is not cached (since it was never requested in the first place).

You mean that on resume there may be a requirement to load a different file
than on boot? If so you can just request it proactively at boot.  Note that the
cache is associated for the device with devres, and even if you call
release_firmware() on the firmware it will be cached for you.  The firmware
cache works with the devres entry, and the firmware devres entry is maintained
throughout the lifetime of the device. This means that even if you
release_firmware() the firmware cache will still be used on resume from
suspend.

> > Of course if the reload triggers during resume when not file system is
> > available, it can not request the firmware. That will just fail and
> > thus you might see this issue.

One of the designs of the firmware cache is to circumvent these concerns,
so you just want to request what you need for suspend early on in the
boot cycle, the firmware API will do what it needs for you.

Unfortunately a lot of this was just not well documented, I hoped that
recent love in this are would have helped.

> > We have a few RFC patches on the
> > mailing list that I have to review. It is however not that easy all
> > the time to find the right firmware file (at least not for Intel
> > hardware) since the boot loader provides different information than
> > the fully operational firmware. So I need to make sure that request
> > the right firmware (if we do not need it initially) so that it gets
> > cached.
> 
> To confirm, reverting this fixes the problem I was seeing in 4.13.  I've
> queued it up for the next 4.13-stable release as well.

Commit 81f95076281f ("firmware: add sanity check on shutdown/suspend") may
seem kludgy but the reason for it was to cleanup the horrible forced and
required UMH lock even when the UMH lock was *not* even needed, which was later
removed via commit 06a45a93e7d34aa ("firmware: move umh try locks into the umh
code").

Removing the old UMH lock even when the UMH lock was *not* needed was the right
thing to do but commit 81f95076281f (("firmware: add sanity check on
shutdown/suspend") was put in place as a safe guard as the lock was also
placing an implicit sanity check on the API. It ensures the API with the cache
was used as designed, otherwise you do run the risk of *not getting the
firmware you may need* -- Marcel seems to acknowledge this possibility.

It may be possible for us to already have in place safeguards so that upon
resume we are ensuring the path to the firmware *is* available, so IMHO we
should remove this *iff* we can provide this guarantee.  Otherwise the check is
valid. You see, although the UMH lock was bogus, it did implicitly ask the
question: is it safe for *any* helper to run and make assumptions on the
filesystem then?

In lieu of this question being answered the warning is valid given the design
of the firmware API and the having the cache available as a measure to resolve
this race.

  Luis
