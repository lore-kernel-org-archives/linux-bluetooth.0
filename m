Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY23-F366AF8461306E4A60B0FC7B13E0@phx.gbl>
In-Reply-To: <1112891841.9047.87.camel@pegasus>
From: "Cesar Diaz" <skagerrad@hotmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Configure PCMCIA Zoom Bluetooth
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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
Date: Thu, 07 Apr 2005 19:17:36 +0200

with dmesg i see a new ttyS14 but when i write "hciattach ttys14 zoom"  i 
received the next message :

unkwon device type or id

thanks

>From: Marcel Holtmann <marcel@holtmann.org>
>Reply-To: bluez-users@lists.sourceforge.net
>To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
>Subject: Re: [Bluez-users] Configure PCMCIA Zoom Bluetooth
>Date: Thu, 07 Apr 2005 18:37:21 +0200
>
>Hi Cesar,
>
> > First sorry by my english is very poor i've a question about to 
>configure a
> > pcmcia card Zoom 4312 Bluetooth i see in your web a description about 
>card
> > information structure of the zoom bluetooth card. i installed ubuntu 
>hoary
> > rc in my laptop (Toshiba 1700-200) and i can not use the multysinc to 
>pairy
> > my SE Phone with the laptop with cardctrl  ident i obtaint the next
> > information:
> >
> > product info :  "PCMCIA", "Bluetoothcard","",""
> > manfid: 0x0279, 0x950b
> > function : 2 (serial)
>
>check with "dmesg" for a new ttyS device after you put in that card and
>then call "hciattach <dev> zoom".
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now.
>http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
