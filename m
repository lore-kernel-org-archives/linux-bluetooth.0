Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AB742F.7030807@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] rctest.c : question about do_listen function
References: <BAY102-F33BFE2838AD565BE5C0FE1D2BD0@phx.gbl>
In-Reply-To: <BAY102-F33BFE2838AD565BE5C0FE1D2BD0@phx.gbl>
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
Date: Mon, 29 Nov 2004 20:10:39 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

|     if( listen(s, 10) ) {
|         syslog(LOG_ERR,"Can not listen on the socket. %s(%d)",
| strerror(errno), errno);
|         exit(1);
|     }
|
| I'm somewhat of a newbie to all this stuff (including sockets) so I
| question why the listen return is being checked for a 1 for error when
| the man pages say -1 is returned on error and 0 is returned on success.

If I'm not totally wrong, only "0" is treated as false, why all non-zero
values are treated as "true", so the comparison is true for -1...

greetings,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBq3QvQWC6DTWkDAoRAgH6AJ497Ro9tyOh+VhCIli4T8kSo3IktQCgu9/r
Al2nU6MplBDnok1+NKzhj3M=
=z3q+
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
