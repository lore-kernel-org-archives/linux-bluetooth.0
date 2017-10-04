Return-Path: <lurodriguez@suse.de>
Date: Wed, 4 Oct 2017 02:20:38 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Gabriel C <nix.or.die@gmail.com>, Tejun Heo <tj@kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Sukumar Ghorai <sukumar.ghorai@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: btusb "firmware request while host is not available" at resume
Message-ID: <20171004002038.GC5659@wotan.suse.de>
References: <E31F8274-519A-4ED7-90C0-2BB71C9CC3ED@holtmann.org>
 <20170911134647.GA3980@kroah.com>
 <20170911171138.GA16216@wotan.suse.de>
 <20170911192955.GB23729@kroah.com>
 <20170911200651.GB16216@wotan.suse.de>
 <09F52990-796D-4F19-957B-EEFCA6ADC160@holtmann.org>
 <20170912162729.GC16216@wotan.suse.de>
 <3A938253-4CB7-4D24-82B1-6A2E3B794077@holtmann.org>
 <20170913173957.GM16216@wotan.suse.de>
 <CAAd53p4NEL0XvYjPagYuTjHCJyW5jz20cLsf0GU91KvRax17oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAd53p4NEL0XvYjPagYuTjHCJyW5jz20cLsf0GU91KvRax17oQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 02, 2017 at 04:34:11PM +0800, Kai-Heng Feng wrote:
> Hi Luis,
> 
> On Thu, Sep 14, 2017 at 1:39 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> [snipped]
> > Would a fw_cache_hint(device, name_list) be reasonable then sometime *before*
> > suspend? All this would do is ask the firmware API to extend the fw cache
> > list with the entries. It would not load firmware immediately, instead this
> > would trigger a request for the hinted firmware to become available for
> > suspend. Then these drivers could request for firmware at resume and it
> > will pick up the cached firmware.
> 
> I think I am the author the patch [1] mentioned by Marcel. I have to admit,
> it's quite clunky in it's current form.  So yes, the new API you proposed is
> definitely better to solve the issue. I'll send new patch for btusb once we
> have the new API to use.

Note that Linus' recent revert to ensure we can keep the old behaviour
of failing to fetch firmware if we're on our way to suspend means that if
you use direct filesystem firmware fetch today on upstream kernels
you will get an attempt to actually look for the file. That is the old
failures you used to see should be gone.

Although at first I was cautious to avoid moving in this direction it was
the right direction to move in anyway long term. The old mecehanism was
put in place to avoid having the UMH call out given we are freezing
userspace and we'd deadlock as the userspace helper would already be
frozen. The UMH helpers *used* to be our default firmware fetchter,
but the API grew to just do a direct filesystem lookup.

If there are issues or races with suspend / resume those need to be
addressed at an ordering level at the core of the suspend framework.
I just actually proposed *how* to deal with proper filesystem suspend
races today [0], the ordering devised currently there is:

  o device driver pm ops called
  o notifier for suspend issued - *going to suspend*
  o userspace frozen
  o filesystem freeze

On the way back up this order is inverted:

  o filesystem freeze
  o userspace frozen
  o notifier for suspend issued - *going to suspend*
  o device driver pm ops called

With this order in place filesystems should in theory be available
on resume ASAP, any issues that could creep up implicate having
to address and review the above ordering.

As-is upstream though, things should be fine and the race you used to
see should no longer be possible. This does mean older kernels don't
have these fixes, as they were not intended to be fixes. The patch
Linus reverted was the patch I kept purposely to *avoid* us having
to move light years forward in one release, but alas, we've moved
forward. So the way to look at it, in the end, is the work to move
the UMH lock outside of direct FS lookups fixed this issue now.

[0] https://lkml.kernel.org/r/20171003185313.1017-1-mcgrof@kernel.org

> Also, with patch [1], the "firmware request while host is not
> available" may still get hit
> on some corner cases. I proposed another patch [2] to tackle the edge
> case, can you
> take a look?
> 
> [1] https://lkml.org/lkml/2017/8/25/58
> [2] https://lkml.org/lkml/2017/8/22/123

All this crap should not be needed anymore as the cause of the issue,
the UMH lock on direct-fs-lookups, is long gone on direct-fs lookups.

The only case and kernel config that will run into this issue now
is those calls that want to skip the direct-fs-lookup first, and
there are only two stupid device drivers upstream that do this:
dell rbu and some LED crap driver.

So please retest now that the revert happened: commit
f007cad159e99fa2acd3b2e9364fbb32ad28b971 ("Revert "firmware: add sanity check
on shutdown/suspend").

  Luis
