Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42357B08.7020009@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Patch] Some btsco modifications
References: <1110683934.5056.43.camel@pc7.dolda2000.com>	 <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>
In-Reply-To: <1110762698.5056.73.camel@pc7.dolda2000.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 14 Mar 2005 12:52:40 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


|>>On the bad side, the coding is pretty unelegant in its places, and I've
|>>completely violated your coding style. Also, backward compatibility for
|>>userspace communication is broken since I had to extend the structure
|>>for incorporating usage status. I haven't updated the btsco2 program
|>>either.

I really like the changes you made in this patch, but why don't you
simply follow the coding style and send in a patch that's actually
usefull to the community? It's not that hard to comply to coding
style...? *scratchinghishead*

maybe you could fix the coding style and send it in again :)

Is it possible to have the headset buttons work as they did without the
patch, like, switching between both behaviours? there are scenarios for
both methods, and even the BT specs cover both of them.

best regards & thanks for helping out,
~  Lars

- --
Lars Grunewaldt
* software development
* multimedia design
skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
web: http://www.dark-reality.de
mail: lgw@dark-reality.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCNXsHQWC6DTWkDAoRAty+AJ9aa55eTNBHLL9A5xgTzwVT6c7lmACfQ5mm
+Nw6fldrnKKJlRGwHV7qLkc=
=nWCb
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
