Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   James Courtier-Dutton <James@superbug.demon.co.uk>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
In-Reply-To: <200402222254.53781.bluez-devel@schaettgen.de>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <1077452836.2716.42.camel@pegasus> <403916CB.3060205@superbug.demon.co.uk>
	 <200402222254.53781.bluez-devel@schaettgen.de>
Content-Type: text/plain
Message-Id: <1077487210.2832.25.camel@pegasus>
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
Date: Sun, 22 Feb 2004 23:00:10 +0100

Hi Fred,

> I don't understand why the whole headset profile has to be implemented as a 
> part of an alsa driver. Everything can be done completely in user space 
> already, completely independent from alsa. The only reason one might wish to 
> have a special alsa driver is better responsiveness only, or what else did I 
> miss? 
> The rfcomm stuff isn't performance critical at all, so there is need for it to 
> go into an alsa driver.

the headset profile will never be in kernel space, because profiles are
application specific. An ALSA Bluetooth driver should map between a SCO
channel and an audio device, so that you can for example use XMMS or
GnomeMeeting with your Bluetooth headset.

> I really don't like the idea that an alsa driver would decide if a sco 
> connection is going to be accepted or not. This should all be up to the a 
> regular userspace application. The alsa driver should not accept incoming 
> connections itself. 
> Instead their should be a way for the application to create or accept (or not 
> accept) a SCO connection the usual way and - only if it wishes to - tell alsa 
> to take care of that connection by creating a new alsa device for it.
> The only job the driver should do is to connect an existing sco socket to an 
> alsa device and make sure that there are no cracks in the audio stream, 
> nothing more.

You always have a control application on an ACL link before any SCO
channel will be open.

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
