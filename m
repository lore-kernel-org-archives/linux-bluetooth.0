Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DBT-120 and Siemens S65
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <6ae156900503060610175d3992@mail.gmail.com>
References: <6ae1569005030604105d08a56e@mail.gmail.com>
	 <1110111350.8302.9.camel@pegasus>
	 <6ae1569005030605485547bf58@mail.gmail.com>
	 <1110117308.8302.12.camel@pegasus>
	 <6ae15690050306060128edc405@mail.gmail.com>
	 <1110117912.8302.14.camel@pegasus>
	 <6ae156900503060610175d3992@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1110118790.8302.17.camel@pegasus>
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
Date: Sun, 06 Mar 2005 15:19:50 +0100

Hi Adis,

> Was following this howto http://gentoo-wiki.com/HOWTO_The_host-to-host_Bluetooth
> and stuff that was added are as following:Device Drivers  --->
>   Networking Support  --->
>     <*> Bluetooth subsystem support  --->
>         <*> L2CAP protocol support
>         <*> SCO links support
>         <*> RFCOMM protocol support
>             [*] RFCOMM TTY support
>         <*> BNEP protocol support
>             [*] Multicast filter support
>             [*] Protocol filter support
>               Bluetooth device drivers  --->
>                 <*> HCI USB driver
>                     [*] SCO (voice) support
> USB support  --->
>    <*> Support for Host-side USB
>    --- USB Host Controller Drivers
>    <M> EHCI HCD (USB 2.0) support
>    <M> OHCI HCD support
>    <*> UHCI HCD (most Intel and VIA) support
>    --- USB Device Class drivers
>    <*> USB Audio support
> 
> Please tell me if this is wrong and.
> You are also suggesting modules? Which one as a module ?
> Can you point me to a howto that explains it ?

I never checked again, if Bluetooth built-in is still working. Most
people are using a full modular kernel and this includes Bluetooth as
well as USB.

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
