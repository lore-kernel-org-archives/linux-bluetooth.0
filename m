Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DBT-120 and Siemens S65
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <6ae1569005030604105d08a56e@mail.gmail.com>
References: <6ae1569005030604105d08a56e@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1110111350.8302.9.camel@pegasus>
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
Date: Sun, 06 Mar 2005 13:15:50 +0100

Hi Adis,

> Trying to connect my mobile phone and PC using blue tooth.
> 
> 1.Added needed stuff in my kernel 2.6.11 on gentoo box.
> When I plug inn my Dlink DBT-120 lights are ON and hcitools scan reports
> this:
> Scanning ...
>        00:01:E3:3C:79:45       Bash
> where bash is my mobile phone.
> and link quality is -->hcitool lq 00:01:E3:3C:79:45
> Link quality: 255
> 
> Does this means that blue tooth works?

if "hciconfig -a" doesn't show any errors it is working.

> 2.How do I connect to devices?

This depends on what you wanna do, but in general you will setup a
RFCOMM connection with the "rfcomm" tool.

> 3. What tools can use for file transfer ?

The Gnome desktop and also KDE have some nice Bluetooth integration that
allows you to send and receive files.

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
