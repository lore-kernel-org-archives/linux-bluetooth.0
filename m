Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.62.0503032051240.10779@block>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] Interference between btsco and hidd
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 3 Mar 2005 20:58:08 +0100 (CET)

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello everyone, I've got a load of questions today:

1. While btsco works fine, I've just noticed that when it's running
   and a connection is established to my headset, my other Bluetooth
   devices (MS Optical Desktop) can't establish a connection by them-
   selves anymore. After keyboard or mouse go to sleep mode with 
   btsco running, they can only be reconnected with hidd --connect
   or by killing btsco first.. Has anyone got an idea how to fix this?

2. I had a look at the hcid source code, as I was thinking about
   implementing a little function to call some script when a
   connection request arrives. However, my understanding of BT
   is still limited, so can somebody give me a hint where to start?
   What kind of event is received when a connection request comes in?

3. Again concerning btsco: has anybody tried to disconnect the SCO
   channel while not in use? Maybe that would fix the problem with
   hidd, too..

Yours, Florian
- -- 
Preserve wildlife - pickle a squirrel today!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCJ2xU7CzyshGvatgRAiY8AJ4hFZph5+njRMNtijJga1WymoJMMACg0fqH
wnFmxKDcWCvgmDG8PC7EbB4=
=elqo
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
