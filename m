Return-Path: <lurodriguez@suse.de>
Date: Wed, 13 Sep 2017 19:39:57 +0200
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
Message-ID: <20170913173957.GM16216@wotan.suse.de>
References: <d68738f6-b079-0fef-dd9c-dca75e756c42@gmail.com>
 <CA+55aFzWABZ+KCKT+r+TgyrWfnc+6YE7ZuHhZmgw-cRQXWTQ2w@mail.gmail.com>
 <E31F8274-519A-4ED7-90C0-2BB71C9CC3ED@holtmann.org>
 <20170911134647.GA3980@kroah.com>
 <20170911171138.GA16216@wotan.suse.de>
 <20170911192955.GB23729@kroah.com>
 <20170911200651.GB16216@wotan.suse.de>
 <09F52990-796D-4F19-957B-EEFCA6ADC160@holtmann.org>
 <20170912162729.GC16216@wotan.suse.de>
 <3A938253-4CB7-4D24-82B1-6A2E3B794077@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3A938253-4CB7-4D24-82B1-6A2E3B794077@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 13, 2017 at 08:52:15AM +0200, Marcel Holtmann wrote:
> > I checked and prior to commit 81f95076281f ("firmware: add sanity check on
> > shutdown/suspend") and commit 06a45a93e7d34aa ("firmware: move umh try locks
> > into the umh code") I believe we could end up also failing at a firmware
> > request as well. Can you confirm? I see one bug report which confirms this
> > since v3.13:
> > 
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1356076

Have you seen these sorts of issues before BTW?

> >> So yes, we would have to redo parts of the vendor specific handling to always
> >> request the firmware, even if we do not need it right now. And frankly that
> >> is not obvious to anybody.
> > 
> > I agree. I thought a bit about the above and tried co come to a clever resolution,
> > for instance one resolution could be to use the MODULE_FIRMWARE() declarations
> > of sorts to then let the firmware API do the pre-fetching for you at init. This
> > would just require a 1 line change to drivers and some already have this.
> > There are two issues with this though, one is that the firmware cache works with
> > devres and devres requires a device already present. Second is firmware names
> > can be very dynamic, so one can only know the firmware name later at boot.
> 
> I don’t like that idea since we have drivers like btusb.ko that support
> devices from many manufactures. So the only difference is the firmware
> loading and setup. After that they behave all the same. So pre-loading all
> Bluetooth firmwares is pretty crazy.

Makes sense. My point was also to explain how the dynamic aspect of the strings
for firmware make that approach not practical.

> > Another issues is that most driver developers use the firmware API and without
> > knowing *are* creating a firmware cache entry, whereas a few times they don't
> > need a firmware cache entry. This is more of performance / optimization thing,
> > but something to consider long term as well.
> > 
> >> We seem to have some patches for doing exactly
> >> that, but I have not gotten to review them in detail since they deal with
> >> vendor specific complex setup handling.

Do you happen to know if some of this code implemented because of the obscure
and perhaps random issues as noted in the above bug URL. If you are not sure,
who can I ask to see what the original motivation was?

> > Correct me if I'm wrong but some of this work very likely came from the above
> > old errors, not the new ones?
> > 
> >> Also this affects more than just Intel since all hardware where firmware
> >> loading is skipped if there is already firmware loaded are affected.
> > 
> > Right, its a core firmware API issue, but this issue has been present for a
> > while, it was however in different form. I'm glad we're able to think ahead
> > and address this now though, it would seem there are quite a bit of intrusive
> > changes required to use the API right, I'd hope we could help on the firmware
> > API front to make these changes smaller.
> > 
> > First, I'd like to understand a bit more how a device ends up with firmware
> > loaded, without having gone through the firmware API.
> > 
> > Second, while requesting firmware at probe seems not necessary, would it
> > at least be reasonable to require a struct device and a list of possible
> > firmware that could be used be made available? If so a separate hook could
> > be provided to help pre-load these only onto the firmware cache. Ie, we would
> > not actually look for the firmware but just create a firmware cache instance
> > so that when we suspend we *do* go fetch for these so that they are ready and
> > available upon resume.
> 
> The devices come with boatloader mode and operational mode and both are
> independent. And most of them only fallback when fully power cycling the
> device. So a simple boot linux and reboot linux would get you into the
> situation that the firmware is already loaded. There are also some UEFI
> bioses that can load the firmware. So there are multitudes of possibilities
> where we can end up with a firmware loaded.

I see thanks.

Would a fw_cache_hint(device, name_list) be reasonable then sometime *before*
suspend? All this would do is ask the firmware API to extend the fw cache
list with the entries. It would not load firmware immediately, instead this
would trigger a request for the hinted firmware to become available for
suspend. Then these drivers could request for firmware at resume and it
will pick up the cached firmware.

  Luis
