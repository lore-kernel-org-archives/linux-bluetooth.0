Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Fred =?ISO-8859-1?Q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
In-Reply-To: <403916CB.3060205@superbug.demon.co.uk>
References: <4034CA08.50500@soft.uni-linz.ac.at>
	 <200402191629.38846.bluez-devel@schaettgen.de>
	 <40376D2B.1060904@superbug.demon.co.uk> <1077452836.2716.42.camel@pegasus>
	 <403916CB.3060205@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1077485446.2832.14.camel@pegasus>
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
Date: Sun, 22 Feb 2004 22:30:47 +0100

Hi James,

> A agree that we need a clearly defined interface for the bluetooth SCO.
> For SCO connections the interface will HAVE to be a callback based 
> interface. SCO is all about realtime data, and we must ensure minimal 
> latency, so that requires a callback interface.
> I.E. We set up the SCO connection, and get it to callback after every X 
> frames received. The same for sending, callback saying I need X samples now!

we already had this discussion and there is no need for such a callback
stuff. If there is too much data, we simply have to drop some samples.

> For alsa to work well with bluetooth, we will need some special handling 
> . The main use of alsa with bluetooth will be for headset communications 
> and therefore use the bluetooth headset profile.

That is wrong. Also Handsfree, Cordless Telephony and Intercom needs a
SCO to audio device mapping. With eSCO we will also have a data link and
maybe more profiles in the future.

> 1) Pairing. Provide a method to pair a bluetooth headset, so that if the 
> headset tried to open the connection. bluez will link to alsa only for 
> that paired device. So, we will need to be able to register alsa as a 
> pairing handler to bluez. Does the concept of a pairing handler even 
> exist yet in bluez?

A headset will never set up the SCO channel. The AG does it.

> 2) There is currently no method in alsa, for alsa to tell the 
> application "I am here now, listen to me!". So, if the headset initiates 
> the connection, there is currently no way to use alsa to inform the 
> application that the headset wishes to do such a thing. Maybe we could 
> implement this with an alsa mixer element that is present all the time 
> the pairing is present. And the application could poll the mixer 
> element, and if the mixer element changed state, we would open the PCM 
> to receive the audio. A sort of on/off hook indication.

See above. And the userspace application must set up the audio device.
Remember that we can't have a SCO link without an ACL link and this
means that we need a control application which knows in detail when to
create the audio device.

> 3) The headset profile consists of a RFCOMM connection for setting 
> volume levels etc. and also a SCO connection for passing audio samples.
> The alsa driver will implement the headset profile when working with 
> bluez. We might be able to expand that to the hands-free profile later.
> The RFCOMM will therefore interface with the alsa mixer. the SCO 
> connection will interface with the alsa PCM.

No. The Bluetooth ALSA driver is not in any way related to a profile.

> 1) The alsa driver for bluetooth will be a kernel mode implementation of 
> the bluetooth headset profile.

No profile implementation in the kernel. It is userspace stuff.

> 2) A userspace tool will be used to configure the bluetooth pairing and 
> configure the alsa-bluez link.

This has nothing to do with it. Pairing is independent from an ALSA
driver.

> 3) We will need to be able to implement bluetooth profiles in kernel 
> modules as well as user space applications.

No. Profiles are userspace stuff.

> 4) The bluez SCO interface should be changed to a callback interface.

I don't see any need for it.

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
