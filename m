Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
	do?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40D0DFFE.7020701@dark-reality.de>
References: <40A9E6CB.4010505@dark-reality.de>
	 <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>
	 <40A9EE51.2080102@dark-reality.de> <1084881439.5833.108.camel@pegasus>
	 <40AA11AB.6010307@dark-reality.de> <1084888843.4327.1.camel@pegasus>
	 <40D0CE71.2010208@dark-reality.de> <1087427168.4309.30.camel@pegasus>
	 <40D0DFFE.7020701@dark-reality.de>
Content-Type: text/plain
Message-Id: <1087431863.4309.39.camel@pegasus>
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
Date: Thu, 17 Jun 2004 02:24:24 +0200

Hi Lars,

> Now I'm lost again. Is there an audio transcoding somewhere in the SCO
> layer, so that I could simply send PCM_S16 and the SCO layer transcodes
> the audio if the headset does not support this? I mean there must be a
> reason why the original snd-bt-sco developer hardcoded the 8bit format
> instead of using 16 bit.

the reason was me, because my first SCO test was with a 3Com PCMCIA card
and 8bit is less data than 16bit ;)

> What about audio quality during transcoding? MULAW sounds much better
> than PCM_S8.

Default air coding is CVSD with 16bit PCM input coding.

> Sorry that I don't fully understand this bluetooth stuff, I'm trying my
> best here. :(
> 
> I hope I dont make anyone angry or something...

Don't worry, but you should dig through the mailing list archives. You
will find some detailed explanations for SCO.

> sorry, misunderstanding. I'll make a new version of snd-bt-sco that
> builds with alsa-1.0.5a. Nothing for bluez.

Feel free to do so.

> I'd like to help you out with this dynamic alternate setting adjustment,
> but I think I don't know enough usb and/or bluetooth mojo to do anything
> usefull.

Maybe someone should rewrite the hci_usb driver from scratch. There are
more issues with it :(

> To make my headset work for now (need my "phone") I used that bad kernel
> patch again, but I'll try to do everything to avoid that in the release.
> I just have to understand what's going on...

I don't see your problem. Simply use 16bit PCM in the ALSA code.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
