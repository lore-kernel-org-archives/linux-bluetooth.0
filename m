Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] error compiling utils2
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?S=E9rgio?= Alcides Fernandes <sergiofernandes@clix.pt>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404082156.34239.sergiofernandes@clix.pt>
References: <200404082156.34239.sergiofernandes@clix.pt>
Content-Type: text/plain
Message-Id: <1081461944.5880.15.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 09 Apr 2004 00:05:44 +0200

Hi Sergio,

> Thks Marcel, but now i get this error compiling utils2:
> 
> /root/utils2/hci/hciconfig.c:56: undefined reference to `ba2str'
> hciconfig.o(.text+0x38):/root/utils2/hci/hciconfig.c:58: undefined reference 
> to `hci_typetostr'

all of them end up in a linking error. Follow this HOWTO

	http://www.bueche.ch/comp/mx900/mx900.html

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
