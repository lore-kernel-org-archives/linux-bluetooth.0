Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection timeout after interrupted software
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050208143303.GA5194@cirrus.madduck.net>
References: <20050208143303.GA5194@cirrus.madduck.net>
Content-Type: text/plain
Message-Id: <1107880590.7327.180.camel@pegasus>
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
Date: Tue, 08 Feb 2005 17:36:30 +0100

Hi Martin,

> I use a bluetooth software that establishes connections with my
> phone via libbluetooth.so.1. Sometimes this software has to be
> killed. When I do this, it leaves the bluetooth stack in a broken
> state:
> 
>   # hcitool scan
>   Scanning ...
>   Inquiry failed: Connection timed out
> 
> How can I prevent this? What is the best way to rectify the
> situation? So far, only reloading the hci_usb kernel module (I use
> a dongle) and reconfiguring hci0 works. Since some of my machines
> have monolithic kernels, this requires a restart. I'd prefer if
> there was a different solution.

the shouldn't be any problems, but anyway what kernel version is this
and what does hciconfig show after you discover this problem. Are there
any other information in dmesg or the logfiles?

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
