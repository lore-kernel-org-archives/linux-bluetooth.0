Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050228180217.44458.qmail@web26404.mail.ukl.yahoo.com>
From: benbouzid imad <imad_benb@yahoo.fr>
Subject: Re: [Bluez-users] Some documentation
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107880993.7327.190.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Mon, 28 Feb 2005 19:02:17 +0100 (CET)

Hi Marcel,


> the core architecture is different, because BlueZ
> hardware is not a network device. 

Wath do you mean?

>The IrDA stack made this mistake and
> so did Affix. The
> BlueZ uses its own hardware interface. 

wich one ? hci_usb.c? affix also have one: btusb.c

>Our driver interface is a lot much cleaner.
 
Can you give more details?


tank you for your clarifications.
regards,
imad


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
