Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4117A907.7010006@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] "comlicated" setup - known issues for hid and SCO?
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
Date: Mon, 09 Aug 2004 18:40:39 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

right now I'm using two BT devices with my Epox dongle, an MX900 mice
and a Sony Ericcson HBH-35 Headset with snd-bt-sco (voice mode 0x0060,
before you ask ;)

both devices work fluently when used without the other, but when I use
headset and mouse at the same time there are various problems during
connect, scan and usage.

The main usage problem was that the sco layer got scrambled audio
(sounded much like random data) on about every third sco connection.
After a while, mouse and headset began to block each other, and the
stack seemed to get more and more, well, muddy. After some more
connection retries even the mouse, before only "hanging" when the
headset tried to connect, stopped working fully.

dmesg only noticed this:

hci_scodata_packet: hci0 SCO packet for unknown connection handle 76

When even connection was impossible, I plugged the BT dongle out and put
it back in. After reloading the hid module and programs the mouse and
headset worked again.

Are you interested in more specific reports? I could enable debugging
for some modules and try to collect some more data than this, if you
want to have something to debug on. I myself don't have the time right
now to drop too deeply into the subject :(

at least, mostly it works :)


I hope I can deliver some actual patches for snd-bt-sco against
alsa-1.0.5a soon, but right now I'm totally busy :/

thanks,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBF6kHQWC6DTWkDAoRAur6AKCqRgv5pB5rL9PE1V+rtuLmfNklRwCglOrb
NEzF/QeL2Q0z0vlF5H7Bn7s=
=cR7L
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
