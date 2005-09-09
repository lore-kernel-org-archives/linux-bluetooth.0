Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Seba T." <dpbasti@wp.pl>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pand host to host stability
References: <200509031151.32766.dpbasti@wp.pl>
In-Reply-To: <200509031151.32766.dpbasti@wp.pl>
MIME-Version: 1.0
Message-Id: <200509092057.27121.dpbasti@wp.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
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
Date: Fri, 9 Sep 2005 20:57:26 +0200

Dnia sobota, 3 wrze=B6nia 2005 11:51, Seba T. napisa=B3:
> hey i'm trying to get my bluetooth connection to connect two host with pa=
nd
>
>  on both hosts I run
>
>  hciconfig hci0 up
>  hcid
>  sdpd
>
>  hcitool cc address_of_device_A
>
>  "hcitool con" shows active connection
>
>  so on host A i do
>
>  pand -n --listen --master
>
>  and from host B
>  pand -c address_of_device_A
>
>  i have /etc/bluetooth/pan/dev-up files configured so the interfaces bnep0
> on both mashines come up
>
>  everything works ok- i can ping the mashine -and even using masquerading
> connect to the internet. i can ping hosts on internet and i could even
> enter a www page but
>  after some seconds when the transfer is high the connection just disapea=
rs
>  any clue?
>
>  the funny think is i have 2 usb bluetooth dongles of different brends and
> ping works both ways. but when i want to open a www from host A on host B
> it works and opening www from host B on the host A crashes the connection
> and i have to do the pand -c thing again
>
> my /etc/bluetooth/pan/dev-up:
>
> #!/bin/sh
> ifconfig $1 up 192.168.0.130 broadcast 192.168.0.255 netmask
> 255.255.255.128 route add default gw 192.168.0.129
> #end
>
> any clues?
>
>
> 2. i dont have any brctl on my system- do i really need it ?
>
> 3. what should be the transfer between 2 bluetooth dongles each for
> 100meters -when i'm at 3meters - i have 12kB/s i think it's not enough
>
>
> my bluez version is 2.20

no answers ?


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
