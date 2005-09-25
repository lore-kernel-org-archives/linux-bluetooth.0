Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN and DHCP
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <9c68c0a7050924002074e002c9@mail.gmail.com>
References: <9c68c0a7050924002074e002c9@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1127644225.6362.2.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Sun, 25 Sep 2005 12:30:25 +0200

Hi,

> I have three usb adapters and three linux pc.
> Now one pc is a pan server, the other two are clients.
> 
> At the server side I allocate ip with a DHCP server.
> using the following command to start pan server:
> =============================
> sdpd
> pand -s -M --role=NAP -n
> 
> echo '1' > /proc/sys/net/ipv4/ip_forward
> 
> iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> iptables -A FORWARD -i bnep0 -j ACCEPT
> iptables -A FORWARD -i bnep1 -j ACCEPT
> iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
> =============================
> and the /etc/bluetooth/pan/dev-up file is:
> =============================
> #!/bin/sh
> echo "dev-up working ,interface is $1!!!"
> ifconfig $1 10.0.0.1
> 
> /etc/init.d/dhcp3-server restart 2>&1 > /dev/null
> =============================
> restart the DHCP server when a bnep interface is created.
> 
> 
> and at the two client sides using the following command to start
> =============================
> sdpd
> pand --role PANU --search --persist -n
> =============================
> and the /etc/bluetooth/pan/dev-up file is
> =============================
> #!/bin/sh
> dhclient bnep0
> =============================
> 
> /etc/dhcpd.conf is
> =============================
> subnet 10.0.0.0 netmask 255.255.255.0 {
> 	option routers 10.0.0.1;
> 	option subnet-mask 255.255.255.0;
> 
> 	option domain-name "example.com";
> 	option domain-name-servers 202.112.17.33;
> 
> 	option time-offset -18000; # Eastern Standard Time
> 
> 	range 10.0.0.3 10.0.0.100;
> }
> 
> =============================
> 
> the question is two client can get their ip address for the DHCP server
> but only the first one connected to the servercan ping the server, the
> later one can not.
> I don't know why?
> I try to modify the /etc/bluetooth/pan/dev-up at the server side
> =============================
> #!/bin/sh
> echo "dev-up working ,interface is $1!!!"
> ifconfig bnep0 10.0.0.1
> ifconfig bnep1 10.0.0.2
> 
> /etc/init.d/dhcp3-server restart 2>&1 > /dev/null
> =============================
> the result is the same.
> How can I get multi pan client online?

use a bridge over the bnepX devices.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
