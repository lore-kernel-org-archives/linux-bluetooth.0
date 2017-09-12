Return-Path: <lurodriguez@suse.de>
Date: Tue, 12 Sep 2017 18:27:29 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Gabriel C <nix.or.die@gmail.com>, Tejun Heo <tj@kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Sukumar Ghorai <sukumar.ghorai@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: btusb "firmware request while host is not available" at resume
Message-ID: <20170912162729.GC16216@wotan.suse.de>
References: <20170911012508.GA17754@kroah.com>
 <9bc9cc83-212a-b39c-75af-b94fe6cab9f4@gmail.com>
 <d68738f6-b079-0fef-dd9c-dca75e756c42@gmail.com>
 <CA+55aFzWABZ+KCKT+r+TgyrWfnc+6YE7ZuHhZmgw-cRQXWTQ2w@mail.gmail.com>
 <E31F8274-519A-4ED7-90C0-2BB71C9CC3ED@holtmann.org>
 <20170911134647.GA3980@kroah.com>
 <20170911171138.GA16216@wotan.suse.de>
 <20170911192955.GB23729@kroah.com>
 <20170911200651.GB16216@wotan.suse.de>
 <09F52990-796D-4F19-957B-EEFCA6ADC160@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <09F52990-796D-4F19-957B-EEFCA6ADC160@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 12, 2017 at 07:13:42AM +0200, Marcel Holtmann wrote:
> >> If something needs to be fixed, can you make a patch showing that?  Or
> >> do we also need to revert anything else as well to get back to a "better
> >> working" state?
> > 
> > I took a look at the driver and it seems that btusb_setup_intel_new() is
> > not called after the driver is initialized, rather its called only when
> > hci_dev_do_open() is called. Its not clear to me how you can end up calling
> > this on resume but not prior to this on a running system. Feedback from
> > someone more familiar with bt would be useful.
> > 
> > I'd have the call for firmware on probe, no processing would be needed, just
> > a load to kick the cache into effect would suffice. This may require a bit
> > of code shift so its best someone more familiar do this.
> > 
> > If it confirmed this information is helping avoid these races we can reconsider
> > re-instating the warn as a firmware dev debugging aid for developers.
> > 
> > If the race this warning complained about is indeed possible the same race is
> > also possible for other usermode helpers. Its *why* the UMH lock was
> > implemented, it however was never generalized.
> 
> we can not load firmware on probe() in most cases. The btusb.ko driver
> establishes the HCI transport. It is setup in probe() and then started in
> hci_dev_do_open() and if there is a vendor setup routine like
> btsub_setup_intel_new(), then it is executed. Most Bluetooth controllers (not
> all, but most) are doing firmware loading over the HCI transport with vendor
> specific commands.
> 
> And yes, if the firmware was already loaded, we would skip requesting it at
> all. Which means after suspend/resume cycle where the power to the controller
> is cut, then we are missing the firmware from the cache. Since we never
> loaded it in the first place.

I checked and prior to commit 81f95076281f ("firmware: add sanity check on
shutdown/suspend") and commit 06a45a93e7d34aa ("firmware: move umh try locks
into the umh code") I believe we could end up also failing at a firmware
request as well. Can you confirm? I see one bug report which confirms this
since v3.13:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1356076

For the sync case we had:

-               ret = usermodehelper_read_trylock();
-               if (WARN_ON(ret)) {
-                       dev_err(device, "firmware: %s will not be loaded\n",
-                               name);
-                       goto out;
-               }

The warning splat in launchpad bug 1356076 is the above case.

For the async case we had:

-               timeout = usermodehelper_read_lock_wait(timeout);
-               if (!timeout) {
-                       dev_dbg(device, "firmware: %s loading timed out\n",
-                               name);
-                       ret = -EBUSY;
-                       goto out;

This would be the more silent case.

If this is accurate than the error case has just been modified to be
a bit clearer, and without being implicated by the UMH lock. This was
the design change after all. Nothing more *broken* should have happened.

In other words if fixing your issues goes away by reverting commit
81f95076281f, to be fair you should also try reverting commit 06a45a93e7d34aa
which did the actual removal of the UMH lock when we don't use the UMH. *That*
was previously the failure trigger point.

> So yes, we would have to redo parts of the vendor specific handling to always
> request the firmware, even if we do not need it right now. And frankly that
> is not obvious to anybody.

I agree. I thought a bit about the above and tried co come to a clever resolution,
for instance one resolution could be to use the MODULE_FIRMWARE() declarations
of sorts to then let the firmware API do the pre-fetching for you at init. This
would just require a 1 line change to drivers and some already have this.
There are two issues with this though, one is that the firmware cache works with
devres and devres requires a device already present. Second is firmware names
can be very dynamic, so one can only know the firmware name later at boot.

Another issues is that most driver developers use the firmware API and without
knowing *are* creating a firmware cache entry, whereas a few times they don't
need a firmware cache entry. This is more of performance / optimization thing,
but something to consider long term as well.

> We seem to have some patches for doing exactly
> that, but I have not gotten to review them in detail since they deal with
> vendor specific complex setup handling.

Correct me if I'm wrong but some of this work very likely came from the above
old errors, not the new ones?

> Also this affects more than just Intel since all hardware where firmware
> loading is skipped if there is already firmware loaded are affected.

Right, its a core firmware API issue, but this issue has been present for a
while, it was however in different form. I'm glad we're able to think ahead
and address this now though, it would seem there are quite a bit of intrusive
changes required to use the API right, I'd hope we could help on the firmware
API front to make these changes smaller.

First, I'd like to understand a bit more how a device ends up with firmware
loaded, without having gone through the firmware API.

Second, while requesting firmware at probe seems not necessary, would it
at least be reasonable to require a struct device and a list of possible
firmware that could be used be made available? If so a separate hook could
be provided to help pre-load these only onto the firmware cache. Ie, we would
not actually look for the firmware but just create a firmware cache instance
so that when we suspend we *do* go fetch for these so that they are ready and
available upon resume.

  Luis
