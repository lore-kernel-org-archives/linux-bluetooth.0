Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40D0DFFE.7020701@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
 do?
References: <40A9E6CB.4010505@dark-reality.de>	 <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>	 <40A9EE51.2080102@dark-reality.de> <1084881439.5833.108.camel@pegasus>	 <40AA11AB.6010307@dark-reality.de> <1084888843.4327.1.camel@pegasus>	 <40D0CE71.2010208@dark-reality.de> <1087427168.4309.30.camel@pegasus>
In-Reply-To: <1087427168.4309.30.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 17 Jun 2004 02:04:14 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
|>If you could just supply a short code snippet that shows how to handle
|>this stuff. Right now it does not look very wise to reduce support to
|>audio 0x0060, because it seems that not many headsets support that audio
|>encoding.
|
|
| This has nothing to do with the headset, because we are talking about
| the input coding and not the air coding.

Now I'm lost again. Is there an audio transcoding somewhere in the SCO
layer, so that I could simply send PCM_S16 and the SCO layer transcodes
the audio if the headset does not support this? I mean there must be a
reason why the original snd-bt-sco developer hardcoded the 8bit format
instead of using 16 bit.

What about audio quality during transcoding? MULAW sounds much better
than PCM_S8.

I have just a hard time with "accept 0x0060 because - ."

Sorry that I don't fully understand this bluetooth stuff, I'm trying my
best here. :(

I hope I dont make anyone angry or something...

|
|
|>As soon as this works again, I'll put a new patch together and make it
|>available.
|
|
| What kind of patch? We need dynamic alternate setting adjustment for the
| hci_usb driver. Nothing else.

sorry, misunderstanding. I'll make a new version of snd-bt-sco that
builds with alsa-1.0.5a. Nothing for bluez.

I'd like to help you out with this dynamic alternate setting adjustment,
but I think I don't know enough usb and/or bluetooth mojo to do anything
usefull.

To make my headset work for now (need my "phone") I used that bad kernel
patch again, but I'll try to do everything to avoid that in the release.
I just have to understand what's going on...

cu,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA0N/+QWC6DTWkDAoRArSUAJ4p4tJgUHZNgynBUdmQVyyGLR53lwCdGAe/
KLuMLz+uvuTKLaIO1yB8s9E=
=ZqlF
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
