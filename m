Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with RS232 and BT - Can't init device
	hci0
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat@poczta.onet.pl
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403021801.11637.zubiwat@poczta.onet.pl>
References: <200403021801.11637.zubiwat@poczta.onet.pl>
Content-Type: text/plain
Message-Id: <1078257013.1942.200.camel@pegasus>
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
Date: Tue, 02 Mar 2004 20:50:13 +0100

Hi Maciej,

> I have CSR chip connected to my PC by RS232
> When try to use hciattach /dev/ttyS0 any 921600 flow I always get:
> hcid[2594]: HCI daemon ver 2.4 started
> hcid[2594]: HCI dev 0 registered
> hcid[2612]: Can't init device hci0. Connection timed out(110)
> 
> When I use hciattach /dev/ttyS0 csr 921600 flow I get:
> Initialization timed out.
> 
> I also tried to setserial /dev/ttyS0 baud_base 921600
> 
> What is the problem because i red almost every howto and mail on mailing list. 
> I only get some signals from the device but he can't analize what is it.
> Im using bluez-libs 2.5, bluez-utils 2.4  with kernel 2.4.22
> Please help me!

are you sure that your ttyS0 is capable of more than 115200 baud?

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
