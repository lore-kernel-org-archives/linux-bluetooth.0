Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Some documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050228180217.44458.qmail@web26404.mail.ukl.yahoo.com>
References: <20050228180217.44458.qmail@web26404.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1109614501.17256.119.camel@pegasus>
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
Date: Mon, 28 Feb 2005 19:15:01 +0100

Hi Imad,

> > the core architecture is different, because BlueZ
> > hardware is not a network device. 
> 
> Wath do you mean?
> 
> >The IrDA stack made this mistake and
> > so did Affix. The
> > BlueZ uses its own hardware interface. 
> 
> wich one ? hci_usb.c? affix also have one: btusb.c
> 
> >Our driver interface is a lot much cleaner.
>  
> Can you give more details?

check the mailing list archive for a detailed analysis from Max.

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
