Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EE4ACD.9070105@fastwebnet.it>
From: WiseLYNX <wiselynx.naima@fastwebnet.it>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth headset - connects but no audio
References: <41EE3974.1010604@fastwebnet.it> <41EE5112.1040502@dark-reality.de>
In-Reply-To: <41EE5112.1040502@dark-reality.de>
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
Date: Wed, 19 Jan 2005 12:55:57 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| Do you have another dongle available to test this? I use an epox bt-dg0=
3.

sure, I'll have a try with the dongle of a friend of mine. what's sure
is that with my dongle on another computer, the headset doesn't work..

| What kernel version do you use? Make sure it's 2.6.10 and you have the
| -mh1 patches added.

the kernel is a 2.6.10-r5 from gentoo; I don't know if it's patched, but
I'll check

| you might also want to try to fire up alsamixer [-c1] and enable the
| "loopback" so that you can/should hear yourself (simply fires back the
| audio to the headset directly).

I tried alsamixer, and could set the volume level (and even hear the
hissing sound become louder or weaker). I can't remember if unmuting the
loopback didn't simply work, or if I wasn't able to unmute, for a reason
or another it didn't work :(

- --

=B0=B0=B0 Wise
~ O  LYNX

GPG key: http://wiselynx.interfree.it/wiselynx.naima.asc
MD5 checksum: http://wiselynx.interfree.it/wiselynx.naima.asc.md5

- -----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GE>$/IT/S d+ s: !a>? C++(+++)>$ U P>+ L++>++++ E--- W++ N ?o ?K w-- ?O ?M
?V>+ PS+ !PE Y+ PGP+ t- ?5 X- R+(*) tv- b+(++)>+++ DI(++) !D G e++ h!*@
r%>++ y-->+
- ------END GEEK CODE BLOCK------

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFB7krMkYE9G6fXLlgRAvA8AJIDNTQwrv4ts3S8R4hVgei/7ceKAJ0TNine
bTEflMqvhHQXNsjSnli0TA=3D=3D
=3DWjwi
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
