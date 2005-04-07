Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Configure PCMCIA Zoom Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5c638dc050407101411cc85d3@mail.gmail.com>
References: <BAY23-F26E455C08371E7C6201733B13E0@phx.gbl>
	 <1112891841.9047.87.camel@pegasus>
	 <b5c638dc050407101411cc85d3@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112894824.9047.97.camel@pegasus>
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
Date: Thu, 07 Apr 2005 19:27:04 +0200

Hi David,

> this is how i connected my billionton card (same way with the zoom i
> bought and returned after i figurd out how to get my card working)
> 
> well that's my script at startup that doesn' twork actually :)  but
> the commands in line work.. the attach is for your ttys device once u
> figure it out from dmesg.. then run the hcid, an hciconfig to see if
> it's running.. then you can run hidd --connect and the mac of the
> device..
> 
> hey marcel i have a question..   it seems everytime i run my connect
> thing.. ineed to have my mouse in the pairing mode (solid light.. like
> when i pair it with windows) is there a way to just have the mouse
> connect without paring it everytime i reboot hte machine. ?
> 
> 
> anyway i hope this helps anybody else that has a billionton card..
> good work with the drivers..
> 
> #!/bin/sh
> 
> hciattach ttyS14 bcsp 921600
> hcid
> hciconfig
> 
> hidd --server
> 
> hidd --connect 00:0E:A1:03:09:AC

the connect is needed only once. After that the mouse will reconnect by
itself if needed.

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
