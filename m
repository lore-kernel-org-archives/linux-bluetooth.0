Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connection not completing????? DT120 and T3 palm
From: Marcel Holtmann <marcel@holtmann.org>
To: J C <jjcar1526@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY14-F18fNwpISMFja000785fd@hotmail.com>
References: <BAY14-F18fNwpISMFja000785fd@hotmail.com>
Content-Type: text/plain
Message-Id: <1079634305.3301.58.camel@pegasus>
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
Date: Thu, 18 Mar 2004 19:25:05 +0100

Hi John,

>   I am using 2.4.22 on both the workstation and embedded cpu.  I
> downloaded the latest tools, bluez-libs-2.5, bluez-pan-1.1,
> bluez-spd-1.5, bluez-utils-2.4, rfcommd-1.2.  I load modules
> crc32,bluez,hci_usb,l2cap,bnep, and rfcomm.  I have a script with
> these commands: ip_script"starts ip-tables", hciconfig hci0 up, sdpd,
> sdptool add LAN, sdptool add SP, hcid, rfcommd -s, dund -s call
> btpalm.  All of these things work on my workstation.  dund will see
> the connection and the pppd daemon will run providing me with a ppp
> connection.  I am able to the get to the internet with my T3.  

don't use the "sdptool add ...", because they are not needed. The dund
will register the SDP record itself and in that case the RFCOMM channel
is correct and not the wrong one. Your T3 tries to connect to channel 2
while dund by default uses channel 1. And don't use rfcommd, because it
is deprecated and not needed anyway.

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
