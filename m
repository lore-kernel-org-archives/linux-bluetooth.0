Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
In-Reply-To: <4039275F.5020802@superbug.demon.co.uk>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <200402191629.38846.bluez-devel@schaettgen.de>
	 <40376D2B.1060904@superbug.demon.co.uk> <1077452836.2716.42.camel@pegasus>
	 <403916CB.3060205@superbug.demon.co.uk> <1077485446.2832.14.camel@pegasus>
	 <4039275F.5020802@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1077487791.2832.35.camel@pegasus>
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
Date: Sun, 22 Feb 2004 23:09:51 +0100

Hi James,

> So you only want a basic read/write interface? No possibility for 
> specifying low latency and setting accurate playback timing?
> What would happen if the user wanted to use bluetooth headphones, and 
> wanted sound to come out of the headphones, and the video from a DVD to 
> be displayed on the computer screen. We need some way to ensure the two 
> are in sync. A simple read/write interface cannot do that.
> For playing a DVD, latency does not matter, what matters in accurate 
> playback timing.
> For Voice over IP, low latency is what matters.
> I cannot see how your simple read/write interface can handle these 
> options. The SCO interface should be able to handle all these.

for incoming SCO data packets we can trust the timing of the Bluetooth
chip. For outgoing SCO data from our side we should make sure that we
don't send to much and overload the Bluetooth chip, but any good
Bluetooth chip should be able to handle this and simply drop the
unneeded packets.

> Ok, so you only want alsa to interface PCM (alsa's term for an audio 
> channel, where the audio samples go.) directly to a SCO channel.
> So, what about an application that supports alsa now. How will it set 
> volume and mic levels on a bluetooth headset? Will the user have to add 
> special bluetooth support to their application?

This is what I meant with SCO interface. A SCO kernel module must also
present an ALSA mixer, but it sends and receives the settings to and
from an userspace application. So if you receive the AT command for
increasing the volume on the RFCOMM channel, you signal this to the SCO
kernel module and this changes the mixer settings. We will see what is
best solution here after the SCO to ALSA PCM mapping is working.

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
