Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
	do?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40D1FA27.20407@dark-reality.de>
References: <40A9E6CB.4010505@dark-reality.de>
	 <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>
	 <40A9EE51.2080102@dark-reality.de> <1084881439.5833.108.camel@pegasus>
	 <40AA11AB.6010307@dark-reality.de> <1084888843.4327.1.camel@pegasus>
	 <40D0CE71.2010208@dark-reality.de> <1087427168.4309.30.camel@pegasus>
	 <40D0DFFE.7020701@dark-reality.de> <1087431863.4309.39.camel@pegasus>
	 <E1B5DFDA-C050-11D8-9772-000A95A4D990@dcs.gla.ac.uk>
	 <40D19E13.9070005@dark-reality.de> <1087487912.4309.69.camel@pegasus>
	 <40D1FA27.20407@dark-reality.de>
Content-Type: text/plain
Message-Id: <1087504096.4309.76.camel@pegasus>
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
Date: Thu, 17 Jun 2004 22:28:16 +0200

Hi Lars,

> you could as well say "an elephant won't fit into a mousewhole until it
> get's a dynamic interface". Of course mulaw and alaw differ from pcm/16
> bit only because they are 8bit/sample. so what. Would not work if it
> would be 7 or 9 bit, either. Also it's not likely that the bit count
> will change sooner or later :)

that is not the point here. The H:2 alternate setting for ISOC interface
only differs between 8bit or 16bit and the number of SCO connections.

> Suggestions are welcome. If anyone has an idea how to improve this
> "alternate setting" handling, i.e. make it possible for an
> application/driver to set the setting in runtime without rewriting the
> whole code, that would be a great thing.

Only the hci_usb driver has to take care of it and the needed notify()
framework from the BlueZ core is already in place.

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
