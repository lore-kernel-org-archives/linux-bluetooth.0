Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Serial connection between two Linux machines
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Luby <thomas.luby@nokia.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40FE8D68.9040007@nokia.com>
References: <40FE8D68.9040007@nokia.com>
Content-Type: text/plain
Message-Id: <1090426562.21683.119.camel@pegasus>
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
Date: Wed, 21 Jul 2004 18:16:02 +0200

Hi Thomas,

> I have two Linux machines. I wish to connect to one from the other
> using a terminal over Bluetooth
> 
> The problem I have is annoying because it basically works. Anyway,
> here is the problem
> 
> Master (USB bluetooth):
> 
> modprobe hci_usb
> hciconfig hci0 up
> hciconfig
> 
> mknod -m 666 /dev/rfcomm0 c 216 0
> rfcomm bind 0 00:60:57:18:FB:6E 1
> 
> Slave (UART bluetooth):
> 
> hciattach /dev/ttyS0 -s 115200 csr
> hciconfig hci0 up
> hcid
> dund --persist --listen
> sdpd
> sdptool add SP --channel=1
> 
> 
> I open a terminal on the master. A connection is present.
> 
> I type echo "Hello" > /dev/bluetooth/rfcomm/0
> 
> and on the master terminal I see "Hello"
> 
> And this is where the problem comes. If I repeat the echo, I get:
> cannot create /dev/rfcomm0: No such device
> 
> because the connection was closed
> 
> I have sent huge files down the link with no problem...but when it
> reaches the end of the file, the connection closes everytime!
> 
> If anyone knows what Im doing wrong I would appreciate it! I have
> searched for 2 days now and not managed to find the solution

use "rfconn connect ..." instead of "rfcomm bind ..." or keep the link
opened with "cat /dev/rfcomm0".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
