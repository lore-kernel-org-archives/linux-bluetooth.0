Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050208104605.16394.qmail@web26410.mail.ukl.yahoo.com>
From: benbouzid imad <imad_benb@yahoo.fr>
Subject: Re: [Bluez-users] PAN-BNEP-and TCP/IP
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107855015.7327.159.camel@pegasus>
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
Date: Tue, 8 Feb 2005 11:46:05 +0100 (CET)

Hi marcel,

But bnep is under PAN and PAN is under layer 3 in the
OSI model.
How PAN work with IP datagramme.
in a piconet if a ping a PANU how this PANU will
annalyse if it's his adresse IP or not?


 --- Marcel Holtmann <marcel@holtmann.org> a écrit : 
> Hi,
> 
> > I was thinking about how PAN profile interact with
> the
> > TCP/IP stacks in blueZ.
> > PAN uses the BNEP layer to provide layer 3 IP data
> and
> > for instance how do we detect a ping answer or a
> ping
> > request? 
> 
> when using BNEP you get a virtual network card in
> your system for every
> connection. So call ifconfig and you see bnep0,
> bnep1 and so on network
> devices. They work like physical network cards and
> so every IP stuff in
> Linux also works over Bluetooth.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users.
> Discover which products truly live up to the hype.
> Start reading now.
>
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
>  


	

	
		
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
