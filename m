Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] starting hcid
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412050059.34530.pavouk@pavouk.org>
References: <200412050059.34530.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1102224599.8510.10.camel@pegasus>
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
Date: Sun, 05 Dec 2004 06:29:59 +0100

Hi Pavel,

> I have problem, that hcid cannot be started from startup-script
> or manually.
> It says:
> -------------
> hcid[4760]: Bluetooth HCI daemon
> Failed to open connection to system message bus: Failed to connect to 
> socket /var/run/dbus/system_dbus_socket: No such file or directory
> hcid[4760]: Unable to get on D-BUS
> --------------
> I use vanilla-kernel 2.6.9 and hcid 2.10.
> 
> What can be wrong?

you have to choices. Install D-Bus and start it or compile bluez-utils
without D-Bus support.

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
