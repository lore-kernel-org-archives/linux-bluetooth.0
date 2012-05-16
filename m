Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.4.0-rc7 regression: bluetooth vs. s2ram
Date: Wed, 16 May 2012 11:03:50 +0200
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org, johan.hedberg@gmail.com
References: <20120515131453.GA1936@elf.ucw.cz> <201205151529.01603.oneukum@suse.de> <20120515180105.GA1923@elf.ucw.cz>
In-Reply-To: <20120515180105.GA1923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201205161103.50317.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag, 15. Mai 2012, 20:01:06 schrieb Pavel Machek:
> On Tue 2012-05-15 15:29:01, Oliver Neukum wrote:
> > Am Dienstag, 15. Mai 2012, 15:14:57 schrieb Pavel Machek:
> > > If I suspend without bnep0 active, resume works. 
> > > 
> > > (This has worked before, but "before" may mean 3.2 in this case).
> > > 
> > > Can someone test/reproduce this? Ideas?
> > > 
> > > PS: Under normal suspend/resume, I see these warnings in the
> > > log. Maybe relevant?
> > 
> > Most likely. Something has introduced a bug that crashes if the controller
> > over which a bnep is run is getting away. Does it survive a surprise removal
> > of the BT device while bnep is up?
> 
> No, it does not. If I turn off hardware radio kill switch, machine
> dies in the same way. So not just sleep related...

You lose power, btusb cannot deal with that and you get an unplug/replug cycle.
Can you get an oops when you are hitting the kill switch?

	Regards
		Oliver
