Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
In-Reply-To: <40376D2B.1060904@superbug.demon.co.uk>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <200402191629.38846.bluez-devel@schaettgen.de>
	 <40376D2B.1060904@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1077452836.2716.42.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 22 Feb 2004 13:27:16 +0100

Hi James,

> For those interested, I am planning to write an alsa driver for 
> bluetooth headsets.
> The alsa driver module would load into kernel, but not present any sound 
> devices.
> Once a pairing had been set up (a small tool will be used for the 
> pairing), the alsa driver module would then dynamically add a sound card 
> to the kernel device list, and this sound card would work just like any 
> other sound device in linux.
> The alsa driver would handle both iso and rfcomm connections, iso for 
> the sound, rfcomm for mixer volume etc.

we don't need a kernel module that implements the headset profile as an
audio device. What we need is a generic SCO kernel module with a well
defined interface that is between the Bluetooth HCI SCO traffic and the
ALSA sound layer. This means that if a SCO connection is created the
driver must set up a new sound device, but the mixer stuff is profile
stuff and must be done by a userspace application.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
