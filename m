Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <409BA6F8.2000901@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] questions about BT audio headset support...
References: <409AD45D.6080102@dark-reality.de> <20040507113025.GA23044@gmx.net> <409B833B.8070203@superbug.demon.co.uk>
In-Reply-To: <409B833B.8070203@superbug.demon.co.uk>
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
Date: Fri, 07 May 2004 17:10:48 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

James Courtier-Dutton wrote:
| Nicholas A. Preyss wrote:
|> In my opinion, the whole connection handling should be done in
|> user-space. In kernel-space only a generic "sco channel" - "alsa
|> device" binding interface should stay.
|> nicholas
|
| I think it might be worth trying to find out if one can get alsa-lib to
| use a user-space device driver. Then everything will stay in user space
| until it reaches the bluez code.

I think alsa needs a kernel modul for sound interface handling, but this
is not much of a problem - I think, after revising the code again. But
it might be interesting to check how the other hotplug (USB audio
devices) are handled...

Right now, the snd-bt-sco module for alsa implements the alsa hwdep
interface that is used to transmit sco-specific data (the sco socket, to
be precisly) from the user-space connection handler to the alsa kernel
module after the connection is made up. I think this method is not bad,
because kernel stuff is done in the kernel (sco I/O and audio I/O on the
alsa interfaces), but the connection handling itself is done by the
user-space daemon. The hwdep interface is exactly for this purpose, I
think...

I think it would be best to improve the interoperability of those three.
One thing is the incoming connection listener; is it possible to attach
a listener to the hci0 device that notices the user-space daemon of a
connecting device (like, "listen for connection of bdaddr 00:12:23:45:78
and tell me when we get a slave-mode rfcomm channel")?

Additionally, we need a method to tell the user-space daemon that the BT
~ Headset audio device has been opened to ring the bell in the headset
and make it possible for the user to answer the call - or attach the sco
channel automagically. I'll check if this can be implemented through the
hwdep interface, too. Right now, only the volume settings are polled by
the user-space daemon; it should be possible to check for incoming
(audio) connections the same way.

Keeping all this stuff - bdaddr, channel, different ways of connection
and automatism - in a user-space daemon will make it easy to handle such
data with a configuration file, and you don't have to gamble around with
rmmod/modprobe all the time.

My main concerns right now - I'm using the headset since monday in daily
phone communication, and as a freelancer I'm a lot "on the phone" - are
the automatic connection when the interface is opened (not nice to press
the connection button each time someone calls you), and the possibility
of using different audio codecs (MU_LAW, A_LAW, RAW_S8 and RAW_S16).
This is a problem because I' not sure which part of the chain should
*set* the correct audio mode. I think the mode-set must be done *before*
the sco channel is opened, so it would be best it the user-space daemon
does this change. Is it possible to change the voice setting through the
hci interface functions? Which function? Right now it has to be done
manually by hciconfig hci0 voice 0x0140...

BTW: is there any written interface documentation available for the
bluez stack?

Next I'm going to browse the mail archives for older posts on this topic.

thanks,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAm6b4QWC6DTWkDAoRAgtOAJ9c0FAps6GkdEzph/YLNJFc6HmzMgCgrwf0
0YsfKNqWk8W0kKPQ3w4X8g0=
=PHKG
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
