Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Error when compiling bluez-utils
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4dfd570904122509237f2a2f48@mail.gmail.com>
References: <4dfd570904122402134ec2fd32@mail.gmail.com>
	 <BAY104-F28B10D34C6CA29EC4D37E9C1A70@phx.gbl>
	 <4dfd5709041225041648e1f356@mail.gmail.com>
	 <1103980205.8758.22.camel@pegasus>
	 <4dfd570904122505192221bf97@mail.gmail.com>
	 <1103982455.8758.26.camel@pegasus>
	 <4dfd570904122507297384376d@mail.gmail.com>
	 <1103989211.8758.29.camel@pegasus>
	 <4dfd570904122509237f2a2f48@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1103995727.8758.31.camel@pegasus>
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
Date: Sat, 25 Dec 2004 18:28:47 +0100

Hi,

> Cocozz .fvwm # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN 
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1 
>         Link policy: 
>         Link mode: SLAVE ACCEPT 

maybe the word "DOWN" gives you a little impression why it can't work.
Call "hciconfig hci0 up" or start "hcid".

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
