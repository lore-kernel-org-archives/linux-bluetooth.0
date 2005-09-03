Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Seba T." <dpbasti@wp.pl>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200509031151.32766.dpbasti@wp.pl>
Subject: [Bluez-users] pand host to host stability
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
Date: Sat, 3 Sep 2005 11:51:32 +0200

hey i'm trying to get my bluetooth connection to connect two host with pand
=20
 on both hosts I run
=20
 hciconfig hci0 up
 hcid
 sdpd
=20
 hcitool cc address_of_device_A
=20
 "hcitool con" shows active connection
=20
 so on host A i do
=20
 pand -n --listen --master
=20
 and from host B
 pand -c address_of_device_A
=20
 i have /etc/bluetooth/pan/dev-up files configured so the interfaces bnep0 =
on=20
both mashines come up
=20
 everything works ok- i can ping the mashine -and even using masquerading=20
connect to the internet. i can ping hosts on internet and i could even ente=
r=20
a www page but
 after some seconds when the transfer is high the connection just disapears
 any clue?
=20
 the funny think is i have 2 usb bluetooth dongles of different brends and=
=20
ping works both ways. but when i want to open a www from host A on host B i=
t=20
works and opening www from host B on the host A crashes the connection and =
i=20
have to do the pand -c thing again
=20
my /etc/bluetooth/pan/dev-up:

#!/bin/sh
ifconfig $1 up 192.168.0.130 broadcast 192.168.0.255 netmask 255.255.255.128
route add default gw 192.168.0.129
#end

any clues?


2. i dont have any brctl on my system- do i really need it ?

3. what should be the transfer between 2 bluetooth dongles each for 100mete=
rs=20
=2Dwhen i'm at 3meters - i have 12kB/s i think it's not enough


my bluez version is 2.20





=2D-=20
Powered by Yoper Linux=20
kernel 2.6.11 ; kde 3.4.2
moj nr gg: 149460

Je=B6li musisz by=E6 pod winblowsem u=BFywaj www.firefox.pl


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
