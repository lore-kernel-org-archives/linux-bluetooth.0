Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20403581.1140769616667.JavaMail.tomcat@pne-ps5-sn2>
From: <ari.paavilainen@pp.inet.fi>
To: bluez-users@lists.sourceforge.net
Subject: Vs: Re: [Bluez-users] recvfrom/sendto
Mime-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
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
Date: Fri, 24 Feb 2006 09:26:56 +0100 (MET)



>----Alkuper=C3=A4inen viesti----
>L=C3=A4hett=C3=A4j=C3=A4: marcel@holtmann.org
>P=C3=A4iv=C3=A4m=C3=A4=C3=A4r=C3=A4: Feb 23, 2006 11:39:37 AM
>Vastaanottaja: bluez-users@lists.sourceforge.net
>Aihe: Re: [Bluez-users] recvfrom/sendto
>
>Hi Ari,
>
>> Can I use recvfrom and sendto with l2cap sockets (instead of listen,=20
accept,=20
>> connect,...)?
>
>why do you repeat your emails? I already told you to try it and tell if
>it doesn't work.
>
>Regards
>
>Marcel
>

Hi,

Sorry about that. The reason: I sent the message to the list, and waited fo=
r=20
it to appear to my mailbox. It didn't appear and then I realised that I am =
not=20
even subscribing the list. I thought that the message didn't get to the lis=
t=20
and I posted it second time.

I have tried to use sendto this way:

int sock;
struct sockaddr_l2 sock_addr;
char addr[18] =3D "00:12:37:46:bc:2b";

sock =3D socket(AF_BLUETOOTH, SOCK_DGRAM, BTPROTO_L2CAP);
sock_addr.l2_family =3D AF_BLUETOOTH;
sock_addr.l2_psm =3D htobs(6001);
str2ba(addr, &sock_addr.l2_bdaddr);
sendto(sock, "Bluetooth test", 15, 0, (struct sockaddr*)&sock_addr, sizeof
(sock_addr));

sendto returns 'Invalid argument' error.

-Ari


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
