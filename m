Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] headset connection problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Guang <m9187@cn.ee.ccu.edu.tw>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <002801c3f55d$e5c9d800$7b6b7b8c@guang>
References: <002801c3f55d$e5c9d800$7b6b7b8c@guang>
Content-Type: text/plain
Message-Id: <1077032640.2665.14.camel@pegasus>
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
Date: Tue, 17 Feb 2004 16:44:00 +0100

Hi Guang,

> I  find  a small problem which  Bluez communicate to headset.
>  I  have a PC(red hat linux8.0), and headset( sony ericsson HBH-65).
> And I inital bluez;
> [root@Bluez bluetooth}#  hcid
> [root@Bluez bluetooth}#  hciconfig
> hci0:  Type:USB
>           BD Address:  00:AA:.................
>  
> [root@Bluez bluetooth}#  hcitool  scan
> Scanning ...
>                00:0A:0A:AA:AA:AA     HBH-65
>  
> [root@Bluez bluetooth}# modprobe  l2cap
> [root@Bluez bluetooth}#  modprobe  rfcomm
> [root@Bluez bluetooth}#  l2ping 00:0A:0A:AA:AA:AA
> Can't connect. : Permission denied
> [root@Bluez bluetooth}# sdptool browse 00:0A:0A:AA:AA:AA
> Failed to connect to SDP server on 00:0A:0A:AA:AA:AA  : Permission
> denied
>  
> What   is   happen?  Why  does headset deny permission? Should I enter
> PIN number to tell headset ,or  others solution?

run "hcidump -w <file>" (as root) and show us the dump.

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
