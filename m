Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40AA11AB.6010307@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
 do?
References: <40A9E6CB.4010505@dark-reality.de>	 <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>	 <40A9EE51.2080102@dark-reality.de> <1084881439.5833.108.camel@pegasus>
In-Reply-To: <1084881439.5833.108.camel@pegasus>
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
Date: Tue, 18 May 2004 15:37:47 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
| Hi Lars,
|
|
|>I already looked up the voice number stuff in the core docs, and was
|>able to find out that 0x0140 is ideal right now (MU_LAW encoded). Works
|>here, already.
|
|
| for this you must use alternate setting 1, because it is 8 bit.
|

um, sorry - what's an alternate setting? I mean, what exactly is "set" here?

I have a working setup with
hciconfig hci0 voice 0x0140
the above kernel patch and the default snd-bt-sco driver stuff (of
course alsa codec information has changed from PCM to MU_LAW)

so I don't exactly know that this alternate setting means :)

Or is it a setting that makes the 8bit-modes possible without using that
kernel patch?

sorry, but I'm a bit new to Bluez :)
~  Lars

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAqhGqQWC6DTWkDAoRAruDAJ4+ovPkHM6M7YvCI2nh6T82RcXy+QCfV8xf
Cc+MRgtEf1rE96S3NHmcV/g=
=mc1o
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
