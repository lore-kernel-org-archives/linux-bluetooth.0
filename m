Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <363732598@web.de>
MIME-Version: 1.0
From: dominic.werner@email.de
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] PC can't receive files from SE K750i
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
Date: Mon, 26 Sep 2005 10:18:55 +0200


Hi there,

i've got an ACER bluetooth-dongle and a Sony Ericsson K750i mobilephone.
All things i write, i've tried with Debian.

1. I startet the dongle with "hciconfig hci up"

2. I search my phone with "hcitool search" --> I found it

3. I used "sdptool browse (MAC of the phone)" to get the OBEX push channel. --> channel is 5

4. "sdptool add --channel=5 OPUSH"

5. I started "obexserver"

now the PC is waiting for incoming files

the first problem: my mobile phone doesn't find my PC
problem fixed: I changed the line "0x100;" in "/etc/bluetooth/hci.conf" to "0x100100;" i read in an Ubuntu-forum. 
no my phone finds the PC

but the 2nd problem:
when I try to send an image to my PC an error appears "connection refused"

who can help?

thanks!

greetings Dominic

p.s.: sorry about my bad english


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
