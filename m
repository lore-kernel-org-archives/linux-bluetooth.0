Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
	do?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lars Grunewaldt <lgw@dark-reality.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40AA11AB.6010307@dark-reality.de>
References: <40A9E6CB.4010505@dark-reality.de>
	 <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>
	 <40A9EE51.2080102@dark-reality.de> <1084881439.5833.108.camel@pegasus>
	 <40AA11AB.6010307@dark-reality.de>
Content-Type: text/plain
Message-Id: <1084888843.4327.1.camel@pegasus>
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
Date: Tue, 18 May 2004 16:00:43 +0200

Hi Lars,

> um, sorry - what's an alternate setting? I mean, what exactly is "set" here?

this has nothing to do with ALSA or BlueZ. It is a USB specific
definition of having alternate settings for an interface. Look at
/proc/bus/usb/devices for your USB Bluetooth dongle.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
