Return-Path: <charles@bueche.ch>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
From: Charles Bueche <charles@bueche.ch>
To: Terence Rudkin <trexx@pobox.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075346991.1793.65.camel@localhost.localdomain>
References: <1074457244.3254.17.camel@localhost.localdomain>
	 <1074458664.6070.73.camel@pegasus>
	 <1074480891.2817.10.camel@localhost.localdomain>
	 <1074514935.6070.80.camel@pegasus>
	 <1074568150.7831.5.camel@localhost.localdomain>
	 <20040120081245.GA1871@smartdata.ch>  <1074597908.7088.5.camel@pegasus>
	 <1075234547.3064.13.camel@localhost.localdomain>
	 <1075276833.12766.56.camel@pegasus>
	 <1075306699.1793.38.camel@localhost.localdomain>
	 <1075307541.26729.18.camel@pegasus>
	 <1075346991.1793.65.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1075405293.7036.7.camel@bluez.bueche.ch>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 20:41:33 +0100
List-ID: <bluez-users.lists.sourceforge.net>

Hi Terence (and Marcel),

I'm the maintainer of the MX900 page, so you can submit your changes
directly to me, I have some people waiting on my update.

Marcel, let me know when the CVS repo is updated.

Nothing urgent, my MX900 right button died, and I sent it to repair, I
should have it back in a few days.

Regs,
Charles

On Thu, 2004-01-29 at 04:29, Terence Rudkin wrote:
> Marcel,  et al,
> 
> The keyboard and mouse now work!  The last issue on getting them to work
> was I needed to umount/mount the /proc/bus/usb file system. 
> 
> Actually just umount and reinsert the USB devices.  I restarted hcid and
> bthid after umount'ing and before the insert.  Getting the right modules
> in /etc/modules should be all that is needed. 
> 
> I'll get the steps needed I used put together as an addendum the the
> MX900 page referenced eariler
...
