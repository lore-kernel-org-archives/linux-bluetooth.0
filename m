Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AmbiCom BT2000C works with hciattach
From: Marcel Holtmann <marcel@holtmann.org>
To: Tony Lindgren <tony@atomide.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040623161414.GA9129@atomide.com>
References: <20040623031119.GA20367@atomide.com>
	 <1087976062.4209.61.camel@pegasus>  <20040623161414.GA9129@atomide.com>
Content-Type: text/plain
Message-Id: <1088008008.4209.126.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 23 Jun 2004 18:26:48 +0200

Hi Tony,

> > how good these news are actually depends on what kernel you are using ;)
> 
> Using 2.6.7.

these are good news, because hci_uart and serial_cs are not working very
nice together with a 2.6 kernel. May you share some more information
about your system. For example lspci, lsmod etc.

>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
> 	Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)

Nice firmware version. Actually it seems we got an alternative for
PCMCIA cards and a 2.6 kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
