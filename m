Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Roderick Taylor <rtaylor@hcvwireless.com>
Reply-To: rtaylor@hcvwireless.com
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1090833153.3497.4005.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] Motorola HS810 problems
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
Date: Mon, 26 Jul 2004 10:12:34 +0100

I have a Motorola HS810 headset.

To pair with BlueZ, I put the headset in paring mode and use the command

hcitool cc <bd_addr>

I've set the pin helper to output PIN#:0000 and The blue light on the
headset flashes 10 times to indicate that paring was successful.  But
hcitool has given an error message.

sh-2.03# hcitool cc 00:07:A4:2A:47:50
Can't create connection: Connection timed out
sh-2.03# hcitool con
Connections:
        < ACL 00:07:A4:2A:47:50 handle 42 state 1 lm MASTER AUTH ENCRYPT
sh-2.03#

When I try and use hstest.  I get 

.sh-2.03# ./hstest play 12345.wav  00:07:A4:2A:47:50
Voice setting: 0x0060
Can't connect RFCOMM channel: Connection refused
sh-2.03#

I am trying to get sound to play out of the headset.

Is anybody working on an implementation of the headset and handsfree
profiles?  I'd be keen to help out if they are.

Rod.



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
