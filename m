Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
	do?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40D19E13.9070005@dark-reality.de>
References: <40A9E6CB.4010505@dark-reality.de>
	 <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>
	 <40A9EE51.2080102@dark-reality.de> <1084881439.5833.108.camel@pegasus>
	 <40AA11AB.6010307@dark-reality.de> <1084888843.4327.1.camel@pegasus>
	 <40D0CE71.2010208@dark-reality.de> <1087427168.4309.30.camel@pegasus>
	 <40D0DFFE.7020701@dark-reality.de> <1087431863.4309.39.camel@pegasus>
	 <E1B5DFDA-C050-11D8-9772-000A95A4D990@dcs.gla.ac.uk>
	 <40D19E13.9070005@dark-reality.de>
Content-Type: text/plain
Message-Id: <1087487912.4309.69.camel@pegasus>
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
Date: Thu, 17 Jun 2004 17:58:32 +0200

Hi Lars,

> won't be a problem. I know what to do because I changed them before,
> from S8 to MULAW_8 :)
> 
> My only problem/wish is that I'd like to support all three audio
> encodings, but I understand this is impossible right now.

only because mulaw and alaw are 8bit.

> What exactly are the influences of the "alternate setting"? Does this
> only change SCO/Audio behaviour, or is the whole bluez stack affected by
> this (if hci_usb is used, of course). I just want to understand the
> pros/cons of 8bit/16bit setting.

Look at the Bluetooth specification of H:2. This is USB specific and it
is because of the ISOC transfers that are used for the SCO packets.

> There's one more (alsa-related) issue I have with the alsa driver. The
> problem is that, if there's no open sco channel, the audio application
> accessing the interface is stalled because the buffer is never read. It
> would be better if the data could be "dumped" or something.
> 
> Is this possible in an easy way, or do I have to look for audio
> sync/timing and stuff instead of just writing the data to /dev/null and
> tell the app "go for the next buffer".

This is a complete other topic and as I said many times before the SCO
driver must be written to be better integrated into the BlueZ core and
the ALSA sound system.

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
