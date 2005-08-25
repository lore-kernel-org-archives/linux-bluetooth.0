Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430E2002.2060309@hasborg.com>
From: Joshua Wright <jwright@hasborg.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Picky about coding style
References: <ef9938ec0508251208621847fd@mail.gmail.com> <1124997684.8019.76.camel@pegasus>
In-Reply-To: <1124997684.8019.76.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 25 Aug 2005 15:46:10 -0400

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

While reading up on the Linux kernel coding style to satisfy patch
requirements, I came the kernel scripts/Lindent script:

mercury:/usr/src/linux/scripts $ cat Lindent
#!/bin/sh
indent -kr -i8 -ts8 -sob -l80 -ss -ncs "$@"
mercury:/usr/src/linux/scripts $

Is it safe to use this script to satisfy formatting requirements for
patch submissions for BlueZ?

Thanks,

- -Josh
- --
- -Joshua Wright
jwright@hasborg.com

2005-2006 pgpkey: http://802.11ninja.net/pgpkey.htm
fingerprint: F00E 7A42 8375 0C55 964F E5A4 4D2F 22F6 3658 A4BF

Today I stumbled across the world's largest hotspot.  The SSID is "linksys".
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDDiABTS8i9jZYpL8RAswwAKCxavrFA1OkutWuEaO3oG9zbDgPEQCcC6mY
OhwJfaVZkmDv/ge2nIJLgpI=
=zsw5
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
