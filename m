Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40A9F4F4.4080601@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
 do?
References: <40A9E6CB.4010505@dark-reality.de> <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk> <40A9EE51.2080102@dark-reality.de>
In-Reply-To: <40A9EE51.2080102@dark-reality.de>
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
Date: Tue, 18 May 2004 13:35:16 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

just wanted to mention that one single SCO connection at a time is
sufficent right now, IMO; I don't think that most people will need more
than one (open) connection for audio right now. Of course, if the core
definition says there must be more than one, we have to implement it.

Or is SCO used for anything else but audio?

cu,
~  Lars

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAqfT0QWC6DTWkDAoRAk1hAJ9jKGqBmKGaffY4wJfy+d0T9phZ4ACgoaaL
GL7p+eYbE7YPM4kgocamyqU=
=IiOx
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
