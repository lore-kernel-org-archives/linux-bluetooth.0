Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <409AD45D.6080102@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] questions about BT audio headset support...
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
Date: Fri, 07 May 2004 02:12:13 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

I decided to invest some of my precious time into improving audio
support for BT headsets; I'm going to take over maintenance of the
snd-bt-sco project.

I already did some minor improvements, but I don't know how to address
some critical design issues.

Right now, the way it works is this:
there's a user space program that handles the rfcomm and sco connection
(my enhanced version listens on open rfcomm for a connection request by
the headset, and opens the sco channel on demand), and an alsa audio
device driver. The device driver polls audio data to and from the
headset; the connection is managed by the user-space program.

Of course this is possibly not the best way of implementing things, but
I'm a bit stuck here.

The nicest way of implementing a better audio support would be having a
daemon that
a) listens for an incoming rfcomm connection that is open by the headset
itself
b) waits for a connection attempt (say, alsa audio interface opened) and
initiate such a connection
c) has the (optional) possibilty of keeping an open rfcomm session.
Reason for this one is the not-so-short rfcomm handshake time. The
rfcomm channel does not drain to much power from the headset, so it
might be a good idea to keep a steady connection at least as an option.

I don't have any clues how to implement this; what do you experts mean?
Should I try to enhance sco support itself, or should this stuff
(connection handling) be done in user-space? What is the easiest way to
recognize incoming rfcomm connections (listener on hci devices or
something?)

I'm really new to bluetooth, but I think I can adopt. I already worked
on some audio drivers and porting from 2.4 to 2.6 kernel, so I'm not a
total newbie, at least, I hope so :)

thanks for spending your time & any suggestions,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAmtRcQWC6DTWkDAoRAm5VAJ9SOvKb0nN6T52Zmsgsyv7B9+woPQCeNyv7
pwr9T8IISJCBLi55MoISpb0=
=J4nD
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
