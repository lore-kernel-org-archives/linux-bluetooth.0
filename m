Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 17 Aug 2007 21:16:09 +0200
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070817191609.GA16745@elmicha>
MIME-Version: 1.0
Subject: [Bluez-users] Pico Modem: cheap BT fax modem, works
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I just got a Sphinx Pico Modem for 1 =A4 (+ 4 =A4 postage) out of ebay. =

It works.  =


The Windows people don't like it very much, probably because apparently
it doesn't have an SDP server, it's about 5 years old, and it's
basically undocumented and unsupported.

The Pico Modem is a Bluetooth fax/voice modem for analog lines.

It can do fax class 1,2,2.0 and works nearly flawlessly with mgetty
over rfcomm.

To get it up and running, plug the cables in and switch it on. It's only
discoverable in the first 3-5 minutes after turning it on.

Use "hcitool scan" to find its device address (only in the first 3-5
minutes after switching it on!).

You want to use rfcomm, so put something like this:

rfcomm5 {
        bind yes;
        device 11:22:33:44:55:66;
	# of course use the real device address here
        channel 1;
        comment "Pico-Modem";
}

in /etc/bluetooth/rfcomm.conf (it doesn't have to be rfcomm5 - use any
rfcomm number that is not yet listed in rfcomm.conf).

For bonding, the PIN of the device is 12345, so start e.g.

  passkey-agent --default 12345

or use the bluez-gnome passkey agent. Then you can use

  rfcomm bind 5

and you should get a /dev/rfcomm5. Use =


  minicom -s rfcomm5

and set the minicom options (Alt+o or "Esc, o" to get to the options
dialog, then set /dev/rfcomm5 as the device instead of /dev/modem).
Exit minicom (save the options of course), and start it again with
"minicom rfcomm5". If it doesn't work immediately, just try it again a
few times. It takes a couple of seconds to establish the Bluetooth
connection, and minicom doesn't wait long enough sometimes.

If you finally are in minicom, you can play with AT commands, e.g.

  ATI

You should get an answer from the modem, like

  Agere Venus V.92 ISA I062503 Voice V2 Mercury

  OK

ATI9, ATI11 and AT&V also give some information.

After that, you can exit minicom and configure mgetty. I won't bore you
with that. The related part of mgetty.config is:

port rfcomm5
speed 115200
init-chat "" \d\d\d+++\d\d\dATZ OK AT OK
modem-type cls2
fax-only y
rings 2
debug 9

There was one catch, though: after successfully receiving a fax, mgetty
couldn't talk to the modem anymore. I worked around that with a little
script that drops the Bluetooth connection after receiving a fax. It's
the /etc/mgetty+sendfax/new_fax that normally only mails the fax:

#! /bin/sh

PATH=3D/usr/bin:/bin:/sbin:/usr/sbin

# call one of the original new_fax scripts:
/etc/mgetty+sendfax/new_fax.orig "$@"

# drop the BT connection and restart it:
rfcomm release 5
sleep 10
rfcomm bind 5
sleep 10
# and restart mgetty:
telinit q


Now it works. While the Bluetooth connection is dropped (about 20
seconds), I can't receive faxes. But that doesn't matter for me.

I only received three test faxes until now, and I made one short test
connection to a BBS. But so far it works. And it's well worth the money.

Feel free to ask if you have any questions.

Regards...
		Michael

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
