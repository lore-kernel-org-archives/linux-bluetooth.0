Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebiroth@web.de>
Message-ID: <cvael0$d6q$1@sea.gmane.org>
References: <20050219182455.68861.qmail@web53009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <20050219182455.68861.qmail@web53009.mail.yahoo.com>
Subject: [Bluez-users] Re: USB Bluetooth works manually, but won't hotplug with the SAME
 script
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
Date: Sun, 20 Feb 2005 17:45:48 +0100

Hi Alfredo,

I can't say what exactly the problem is but IMHO the script
is not structured very wise. Maybe the script is executed before
the needed modules are loaded when used for hotplugging.
Here is my suggestion for a script:

#!/bin/sh
# get the bluetooth things ready
PATH=/bin:/sbin:/usr/bin:/usr/sbin

# load all modules
modprobe bluetooth
modprobe hci_usb
modprobe l2cap
modprobe rfcomm

# start the deamons
# AFAIK the configfile paths are default
# so there is no need to specify these
hcid
sdpd
rfcomm bind all

# this is done by hcid!
# hciconfig hci0 up

# don't really know what these
# commands do but seems ok to me
sdptool add --channel=3 SP
dund --listen --channel 3 --msdun noauth
:192.168.1.240 crtscts 115200 ms-dns 192.168.1.1 lock


I have not tested this script but it _should_ work.

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
