Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: Vs: Re: [Bluez-users] recvfrom/sendto
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20403581.1140769616667.JavaMail.tomcat@pne-ps5-sn2>
References: <20403581.1140769616667.JavaMail.tomcat@pne-ps5-sn2>
Content-Type: text/plain
Message-Id: <1140800100.7264.19.camel@localhost>
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
Date: Fri, 24 Feb 2006 17:55:00 +0100

Hi Ari,

> Sorry about that. The reason: I sent the message to the list, and waited for 
> it to appear to my mailbox. It didn't appear and then I realised that I am not 
> even subscribing the list. I thought that the message didn't get to the list 
> and I posted it second time.
> 
> I have tried to use sendto this way:
> 
> int sock;
> struct sockaddr_l2 sock_addr;
> char addr[18] = "00:12:37:46:bc:2b";
> 
> sock = socket(AF_BLUETOOTH, SOCK_DGRAM, BTPROTO_L2CAP);
> sock_addr.l2_family = AF_BLUETOOTH;
> sock_addr.l2_psm = htobs(6001);
> str2ba(addr, &sock_addr.l2_bdaddr);
> sendto(sock, "Bluetooth test", 15, 0, (struct sockaddr*)&sock_addr, sizeof
> (sock_addr));
> 
> sendto returns 'Invalid argument' error.

the SOCK_DGRAM support in L2CAP is not really good and thus might don't
wanna you sendto() at all. Are there any problems with binding and
connection to an L2CAP channel?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
