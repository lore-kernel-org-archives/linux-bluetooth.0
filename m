Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jan 2010 10:15:21 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: need understanding about bt
Message-ID: <20100107101521.010b16b3@strolchi.home.s3e.de>
In-Reply-To: <201001061610.22914.gene.heskett@verizon.net>
References: <201001051910.08204.gene.heskett@verizon.net>
	<20100106092350.47ba4a63@strolchi.home.s3e.de>
	<201001061610.22914.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 06 Jan 2010 16:10:22 -0500
Gene Heskett <gene.heskett@verizon.net> wrote:

> On Wednesday 06 January 2010, Stefan Seyfried wrote:
> [...]
> 
> >Note that the test-serial has a fixed timeout of 1000 seconds and will
> >close the link afterwards, but that should be trivial to hack out of
> >the script.
> 
> I already had a script I'd played the 10,000 monkeys scene writing, so I just 
> streamlined that one.  No timeouts in it. ;)


Good ;-)

> >If you want to use the old-fashioned style, I had written some
> >documentation about that in a former life. It's still available through
> >http://en.opensuse.org/Bluetooth/rfcomm (it's not SUSE-specific at all,
> >if anything, you might need to put a call to "rfcomm bind all" into a
> >late-running init script for your distro).
> 
> I've done that, except the bind is issued for the bdaddr, enabled the script 
> and it works for at least the last reboot.

That's fine, the "bind all" just means "bind all the entries from the
config file". You can of course also configure it manually without the
config file.

> I think the newer kernels have helped make it dependable now.

I'm not sure if it's the kernel or newer bluez or whatever, and it
probably does not matter as long as it works for you ;-)

Have fun,

	seife

-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
