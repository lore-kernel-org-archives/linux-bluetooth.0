Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40A9EE51.2080102@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
 do?
References: <40A9E6CB.4010505@dark-reality.de> <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>
In-Reply-To: <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>
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
Date: Tue, 18 May 2004 13:06:57 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| There are different voice encodings over the isochronous USB channel
| that is used for the SCO connection. Which encoding is used is selected
| by running 'hciconfig hci0 voice <somenumber>', where <somenumber> is,
| for example, 0x0040 for one 8 bit 8000Hz stream and 0x0060 for one 16
| bit 8000Hz stream.
|
| Depending on how many SCO channels are open and what format is used,
| different isoc USB frames are used by the bluetooth device. The
| possibilities are enumerated in the documentation that is referenced in
| that comment.
|

I already looked up the voice number stuff in the core docs, and was
able to find out that 0x0140 is ideal right now (MU_LAW encoded). Works
here, already.

Hm, is there any chance to get this implemented "the proper" way, so all
audio codecs (8bit 8kHz and 16bit 8kHz) can be used with hci_usb?

I changed from PCM to MU_LAW because of the better quality, but of
course PCM/16bit would sound best. If - and only if - the sound data is
not already in PCM/8bit or MU_LAW.

I'd like to enhance the driver that it can handle all those three audio
modes (should not be that complicated; PCM/8 and MU_LAW are the same,
anyway, because they only use a different encoding, but same buffer
sizes, and 16 bit should simply use a double-size buffer ( or transmit
1/2 of the data)).

So, what has to be done to the hci_usb?

thanks,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAqe5QQWC6DTWkDAoRAueiAKCKzNV8FlhsIh6FcBnupj3N2o70eQCfYZCa
jvLzfRN71qitW4l8oXJNRA4=
=EgiL
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
