Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Jul 2013 16:32:13 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Adam Lee <adam.lee@canonical.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Wen-chien Jesse Sung <jesse.sung@canonical.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	Anthony Wong <anthony.wong@canonical.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btusb: fix overflow return values
Message-ID: <20130709153213.GC1772@joana>
References: <1372941783-30657-1-git-send-email-adam.lee@canonical.com>
 <25CD2206-7B7B-4DAD-A714-A79976C9DB13@holtmann.org>
 <20130709025501.GA6369@adam-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130709025501.GA6369@adam-laptop>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

* Adam Lee <adam.lee@canonical.com> [2013-07-09 10:55:01 +0800]:

> On Mon, Jul 08, 2013 at 11:50:54AM -0700, Marcel Holtmann wrote:
> > Hi Adam,
> > 
> > > PTR_ERR() returns a long type value, but btusb_setup_intel() and
> > > btusb_setup_intel_patching() should return an int type value.
> > > 
> > > This bug makes the judgement "if (ret < 0)" not working on x86_64
> > > architecture systems, leading to failure as below, even panic.
> > > ...
> > > For not affecting other modules, I choose to modify the return values
> > > but not extend btusb_setup_intel() and btusb_setup_intel_patching()'s
> > > return types. This is harmless, because the return values were only
> > > used to comparing number 0.
> > 
> > there are tons of examples in various subsystems and drivers where we
> > return PTR_ERR from a function calls returning int.
> > 
> > So I wonder what is actually going wrong here. If this is x86_64
> > specific problem with PTR_ERR vs int, then we should have this problem
> > everywhere in the kernel.
> 
> Hi, Marcel
> 
> I see you point, the difference between here and other subsystems are:
> 
> 1, it returns -PTR_ERR() here but all other places return PTR_ERR(), I
> checked.

Please sending a patch fixing this. We got this right in other parts of the
bluetooth subsystems but somehow we failed to check this when this code came
in. And then another updating the checks if needed.

	Gustavo
