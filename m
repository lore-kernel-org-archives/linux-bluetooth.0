Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
From: Marcel Holtmann <marcel@holtmann.org>
To: Terence Rudkin <trexx@pobox.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1074480891.2817.10.camel@localhost.localdomain>
References: <1074457244.3254.17.camel@localhost.localdomain>
	 <1074458664.6070.73.camel@pegasus>
	 <1074480891.2817.10.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1074514935.6070.80.camel@pegasus>
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
Date: Mon, 19 Jan 2004 13:22:15 +0100

Hi Terence,

> Running it I get:
>  
>  trudkin Last rc=1  07:43:17 /space/Bluez
>  $> ./hid2hci -0
> Switching device 046d:c703 to HCI mode was successful
>  trudkin Last rc=0  07:43:20 /space/Bluez
>  $> ./hid2hci -0
> Switching device 046d:c703 to HCI mode was successful
>  trudkin Last rc=0  07:43:22 /space/Bluez
>  $> ./hid2hci -1
> No devices in HID mode found
>  trudkin Last rc=1  07:43:26 /space/Bluez
>  $>
> I can set to HCI twice and cannot reset to HID.  Leads me to believe
> that it did not take.  I think all the right mods are loaded and hcid is
> running.

do you have patched the USB HID driver?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
