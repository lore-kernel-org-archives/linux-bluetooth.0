Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez nap problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041206200122.89431.qmail@web52006.mail.yahoo.com>
References: <20041206200122.89431.qmail@web52006.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1102364164.8447.0.camel@pegasus>
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
Date: Mon, 06 Dec 2004 21:16:04 +0100

Hi,

> I have problems setting up NAP.
> 
> Here are my configurations:
> 
> This is the NAP side
> Linux version 2.4.27 (root@goner) (gcc version 3.3.4
> 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2,
> pie-8.7.6)) #1 Fri Dec 3 13:09:59 EET 2004
>   
> This is the PANU side
> Linux version 2.4.26 (root@Knoppix) (gcc version
> 2.95.4 20011002 (Debian prerelease)) #1 SMP Sa Apr 17
> 19:33:42 CEST 2004
> 
> My Steps to setup NAP side:
> root@goner ~ # hcid
> root@goner ~ # hcitool dev
> Devices:
>         hci0    00:02:72:03:D3:F2
> root@goner ~ # sdpd
> root@goner ~ # pand --listen --master --nodetach
> pand[11105]: Bluetooth PAN daemon
> 
> PANU side:
> root@miniscule ~ # hcid
> root@miniscule ~ # hcitool dev
> Devices:
>         hci0    00:0D:18:01:19:3B
> root@miniscule ~ # sdpd
> root@miniscule ~ # pand --search --persist --role PANU
> --service NAP --nodetach
> pand[1703]: Bluetooth PAN daemon
> pand[1703]: Inquiring
> pand[1703]: Searching for NAP on 00:02:72:03:D3:F2
> pand[1703]: Failed to connect to the SDP server.
> Function not implemented(38)
> 
> and this goes on and on...
> If I run hcidump on the NAP side i get these:
> > HCI Event: Connect Request (0x04) plen 10
> < HCI Command: Accept Connection Request (0x01|0x0009)
> plen 7
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connect Complete (0x03) plen 11
> 
> I cant run hcidump on PANU side because i dont hcidump
> on the laptop, and i dont have a means to tranfer
> hcidump binary (at least not an easy means) to it.
> This whole thing is really weird because I got bnep0
> working twice. Now I can't. 

do it with "hcidump -x" and show us the output of "hciconfig -a".

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
