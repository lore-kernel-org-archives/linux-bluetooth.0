Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCI Config returns Can't Init device
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <f16b04cf050327221766330331@mail.gmail.com>
References: <f16b04cf050327221766330331@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112008411.9016.11.camel@pegasus>
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
Date: Mon, 28 Mar 2005 13:13:31 +0200

Hi Hariharan,

>     i am using 2.4.18 kernel with the RFMD serial port bluetooth
> module. i have ported the Bluez Stack and HCI_H4 protocol modules. The
> RFMD device is get attached by
> 
> hciattach /dev/ttyS0 swave 115200 flow
> 
> the patch added in the hciattach.c is soft reset functionality
> included before sending param acess command in SWAVE function and
> after that reset again. This attaches my UART dongle with the HCI
> layer.
> 
> When i try to hciconfig uration i am getting the following errors.
> 
> hciconfig hci0 up
> 
> Can't init device hci0. Connection timed out(110) ERROR.
> 
> But i could have functionality with Kernel 2.6. The HCI config works fine. 
> 
> Is there any patch to imply for the 2..4 kernel.

you need at least use my 2.4.18-mh15 patch. However if the 2.6 kernel
works then use it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
