Return-Path: <gregkh@linuxfoundation.org>
Date: Mon, 11 Sep 2017 06:46:47 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Gabriel C <nix.or.die@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Sukumar Ghorai <sukumar.ghorai@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>
Subject: Re: btusb "firmware request while host is not available" at resume
Message-ID: <20170911134647.GA3980@kroah.com>
References: <CA+55aFztG626Np=z2WUzeVS1O3nmoTj76QRUBPg0J-FBELO7vw@mail.gmail.com>
 <20170911012508.GA17754@kroah.com>
 <9bc9cc83-212a-b39c-75af-b94fe6cab9f4@gmail.com>
 <d68738f6-b079-0fef-dd9c-dca75e756c42@gmail.com>
 <CA+55aFzWABZ+KCKT+r+TgyrWfnc+6YE7ZuHhZmgw-cRQXWTQ2w@mail.gmail.com>
 <E31F8274-519A-4ED7-90C0-2BB71C9CC3ED@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E31F8274-519A-4ED7-90C0-2BB71C9CC3ED@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 11, 2017 at 07:12:44AM +0200, Marcel Holtmann wrote:
> Hi Linus,
> 
> >> Yes 81f95076281f is to blame.. After reverting it all is fine again.
> >> 
> >> 15 resume cycles on the one laptop , 10 on the other without to hit the
> >> trace.
> > 
> > Yeah, I think that disable/enable_firmware in the suspend/resume path
> > is basically just completely random code. There  is nothing that
> > serializes with anything else, and it has no actual basis for saying
> > "I am now disabled/enabled" except for some entirely random time of
> > whenever the suspend/resume callbacks happen.
> > 
> > I'm going to revert it.
> > 
> > I wonder why 4.13 seemed to work for me. Or maybe it didn't, and I
> > just didn't notice, because I didn't use bluetooth and I wasn't
> > traveling. I test my laptop every release, but I don't necessarily
> > always _use_ it.
> 
> we have a bug report that might go into the similar direction. So the
> problem is that modern Bluetooth controller require full firmware
> loading (not just ROM patching) and if the controller has the firmware
> somehow already loaded, but then looses power and needs a reload, then
> it is not cached (since it was never requested in the first place).
> 
> Of course if the reload triggers during resume when not file system is
> available, it can not request the firmware. That will just fail and
> thus you might see this issue. We have a few RFC patches on the
> mailing list that I have to review. It is however not that easy all
> the time to find the right firmware file (at least not for Intel
> hardware) since the boot loader provides different information than
> the fully operational firmware. So I need to make sure that request
> the right firmware (if we do not need it initially) so that it gets
> cached.

To confirm, reverting this fixes the problem I was seeing in 4.13.  I've
queued it up for the next 4.13-stable release as well.

thanks,

greg k-h
