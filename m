Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Subject: Making serial (rfcomm0) work, need magic incantation,
 chicken foot voodoo or what?
Date: Sat, 27 Feb 2010 12:04:04 -0500
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Message-id: <201002271204.04051.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings all;

How does one go about, on linux, making /dev/rfcomm0 available to the likes 
of minicom?

Its there, blueman-manager says I have a good signal most of the time, that 
it is trusted and bonded.  lsof discloses no open paths to the device, but 
minicom claims it is in use and exits.  There is a shell running on the other 
end that should give me a system prompt from that system.

I have restarted /etc/init.d/bluetooth several times to no avail.

It may become usable if I reboot this machine, but that isn't how its 
supposed to work I don't think.

So what sort of a magic spell do I need here?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)

Of course it doesn't work. We've performed a software upgrade.
