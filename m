Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
In-Reply-To: <40393D4D.5070908@superbug.demon.co.uk>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <200402191629.38846.bluez-devel@schaettgen.de>
	 <40376D2B.1060904@superbug.demon.co.uk> <1077452836.2716.42.camel@pegasus>
	 <403916CB.3060205@superbug.demon.co.uk> <1077485446.2832.14.camel@pegasus>
	 <4039275F.5020802@superbug.demon.co.uk> <1077487791.2832.35.camel@pegasus>
	 <40393D4D.5070908@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1077522938.2832.84.camel@pegasus>
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
Date: Mon, 23 Feb 2004 08:55:38 +0100

Hi James,

> What I am trying to say is that using read/write interfaces for realtime 
> streams like SCO is just the wrong way to do it.
> I have looked at snd-bluez-sco-2003-09-15.tar.gz and from what I can 
> understand from it, the snd-bluez-sco kernel driver is just using simple 
> read/write commands to a file descriptor given to it from the userspace 
> daemon "bluezsco".

I don't see a problem with a read/write interface, because what we get
from the Bluetooth chip is already PCM. I don't wann make it more
complex as needed if the hardware can do most of the stuff for us.

> This approach will get sound to and from the bluetooth headset.
> But SCO has the potential for so much more, so why are we restricting it?
> We must allow for applications like VoIP and DVD playback. These need 
> control over latency and playback timing accuracy. The current "file 
> descriptor read/write" approach does not allow for that.

Where do we restrict this?

> The bluetooth chip should not have to worry about dropping packets, the 
> application should just send the chip packets when the chip wants them.

Yes it have to. You should read the mailing list archive and search for
comments from the CSR guys about SCO. And you can of course take the
Bluetooth specification itself.

> I am only asking for changes to the SCO side of things due to it's real 
> time nature. Using network sockets for RFCOMM and bulk data transfers 
> that are not real time in nature is fine.
> 
> Once we have proper real time SCO support, we can overlay the current 
> SCO file descriptor read/write model on top if you still need it.

Again, I can't follow what you are trying to achieve. The current socket
interface for SCO fits not perfect, because it is audio only data. But
with eSCO we also provide data transmission over SCO.

However I don't wanna continue a socket interface for SCO. What I wan't
is something like:

	1. We need an SCO channel
	2. Connect SCO channel
	3. Attach SCO channel to an ALSA audio device
	4. Find new audio device and use it
	5. Use SCO controls for mixers settings etc.

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
