Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alberto Garcia Hierro <tcpdevil@linuxlover.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] automatic bnep0 configuration
References: <opseq1blhheocfdv@debian>
In-Reply-To: <opseq1blhheocfdv@debian>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11662947.dUxmDEyutT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200409230437.30844.tcpdevil@linuxlover.org>
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
Date: Thu, 23 Sep 2004 04:37:12 +0200

--nextPart11662947.dUxmDEyutT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El Jueves, 23 de Septiembre de 2004 00:12, Christoph Torens escribi=F3:
> Hello List,
>
> I wonder if there is a way to automatically set up and
> configure the bnep0 device that comes into existing after
> a pand connection was set up. At the moment I create the
> connection and do 'ifconfig bnep0 10.10.0.5'.
> But when setting up something like a server you normally
> can't do this ifconfig by hand.
>
> I tried to configure this with /etc/network/interfaces
> but that didn't help. I also tried to set 'auto bnep0'
> but this only works at boot time, when the device is
> not there yet.
> What's the trick?
>
> By the way: thanks for all the previous help, already :-)

 When a pand connection is established, /etc/bluetooth/pan/dev-up is execut=
ed,=20
passing args "interface baddr" (for example /etc/bluetooth/pan/dev-up bnep0=
=20
00:10:60:A2:3A:0B) . These are the scripts I use, you may find them usefull=
=2E=20
On the client side:

fiam@americana 100% ~ $ cat /etc/bluetooth/pan/dev-up
#!/bin/bash

if [ "$2" =3D "00:10:60:A2:3A:0B" ]
then
        ifconfig $1 192.168.3.2
        if ! ifconfig | egrep "eth0|wlan0"
        then
                route add default gw 192.168.3.1
        fi
else
        mesg y
        echo "Pand connection to $2" | write fiam
        mesg n
fi

And on the server side:


fiam@ignition fiam $ cat /etc/bluetooth/pan/dev-up
#!/bin/bash

PAN_IFACE=3Dpan0

if [ -z "$1" ]
then
        exit 1
fi

if ! ifconfig -a |grep ${PAN_IFACE} &> /dev/null
then
        brctl addbr ${PAN_IFACE}
        brctl setfd ${PAN_IFACE} 0
        brctl stp ${PAN_IFACE} disable
        ifconfig ${PAN_IFACE} 192.168.3.1
fi

if ! iptables -t nat -L -v | \
egrep "REDIRECT( )*tcp( )*--( )*${PAN_IFACE}
( )*any( )*anywhere( )*!192.168.232.0/24
( )*tcp( )*dpt:www( )*redir( )*ports( )*3128"
then
        iptables -t nat -A PREROUTING -i ${PAN_IFACE} -p tcp -d !=20
192.168.3.0/24 --dport 80 -j REDIRECT --to-port 3128
fi

brctl addif ${PAN_IFACE} $1
ifconfig $1 0.0.0.0

 Sorry for the ausence of comments, but I wrote these scripts yesterday and=
 I=20
hadn't time to comment them. If you need further explanations, just ask :)

Regards,
 Alberto

=2D-=20
/* Alberto Garc=EDa Hierro (Skyhusker) */

--nextPart11662947.dUxmDEyutT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBUjbq4O6JklHkL2cRAugcAJ4l97J9LZRC/PE3KEty8KoT9HLtfgCfTk9o
26MtpGYWrNeXNsQ4+t6aWc0=
=Lj7W
-----END PGP SIGNATURE-----

--nextPart11662947.dUxmDEyutT--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
