Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Steffen Schwientek <schwientek@web.de>
Message-ID: <amsbr1-glo.ln1@ID-90813.users.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Subject: [Bluez-users] headset
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 01 Jul 2004 00:50:13 +0200

I want to use my plantronics M9000 headset. Since it?s my only bluetooth
part, I can?t figure out, if bluetooth works. Connecting the USB dongle,
the kernel (2.6.6) reports:

usb 3-1: USB disconnect, address 7
usb 3-1: new full speed USB device using address 8
usb 3-1: control timeout on ep0in
usb 3-1: control timeout on ep0in

However, hciconfig detects the dongle.

An hcitool scan detects (if I put the headset in pairing mode)
00:03:89:46:E2:0F       M3000 by Plantronics

So nice, so far. Unfortunately I don?t know what I need next (I tried the
kbluetooth daemon, but this doesn?t detect the headset at all, or failed
due to an timeout.

Next I try an hcitool cc, but nothing happens. kdebluetooth shows me an
connection, but after a while it reports an error (0x22).
/var/log/messages shows no error.

Any suggestions?



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
