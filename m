Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
	do?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40D0CE71.2010208@dark-reality.de>
References: <40A9E6CB.4010505@dark-reality.de>
	 <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>
	 <40A9EE51.2080102@dark-reality.de> <1084881439.5833.108.camel@pegasus>
	 <40AA11AB.6010307@dark-reality.de> <1084888843.4327.1.camel@pegasus>
	 <40D0CE71.2010208@dark-reality.de>
Content-Type: text/plain
Message-Id: <1087427168.4309.30.camel@pegasus>
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
Date: Thu, 17 Jun 2004 01:06:15 +0200

Hi Lars,

> I hope you can remember the issue we had a few weeks ago about
> snd-bt-sco/bt-headset stuff.
> 
> I'm right now moving it from alsa 1.0.3 to 1.0.5a and kernel 2.6.7, and
> I want to get rid of this patch (as it seems you all don't like it).
> 
> But I still don't understand, and can't find out, what I have to do to
> set the dubious "alternate" setting of the hci_usb you spoke of. I'm
> totally lost here, and I hope you can help me out easily :)
> 
> I understand what it does, but I don't have *any* clue right now what I
> have to do to set the usb alternate setting.

the alternate setting is right for one SCO channel and a voice setting
of 0x0060.

> - - parameter to hci_usb on module load or some other CL stuff?
> - - changing something in the btsco userspace daemon that handles the
> rfcomm/sco-stuff?
> 
> If you could just supply a short code snippet that shows how to handle
> this stuff. Right now it does not look very wise to reduce support to
> audio 0x0060, because it seems that not many headsets support that audio
> encoding.

This has nothing to do with the headset, because we are talking about
the input coding and not the air coding.

> As soon as this works again, I'll put a new patch together and make it
> available.

What kind of patch? We need dynamic alternate setting adjustment for the
hci_usb driver. Nothing else.

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
