Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050208125725.38505.qmail@web26402.mail.ukl.yahoo.com>
From: benbouzid imad <imad_benb@yahoo.fr>
Subject: Re: [Bluez-users] PAN-BNEP-and TCP/IP
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107860946.7327.177.camel@pegasus>
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
Date: Tue, 8 Feb 2005 13:57:25 +0100 (CET)

Hi Marcel,

Tanks for your help I see the bnep.c file and the
pand.h, when we perform a connection the pan call a
bnep fonction which create the bnep0 interface. Bnep
interface interact directlly with the TCP/IP stack so
we can immagine that bnep is in the layer 2 just under
IP.
ps: pand.c doesn't exist because we dosen't need it.
All is being do by bnep, isn't it? 


 --- Marcel Holtmann <marcel@holtmann.org> a écrit : 
> Hi,
> 
> > But bnep is under PAN and PAN is under layer 3 in
> the
> > OSI model.
> 
> first thing to learn. This is a model and not real
> life. Check the IEEE
> part for Bluetooth up to L2CAP.
> 
> > How PAN work with IP datagramme.
> > in a piconet if a ping a PANU how this PANU will
> > annalyse if it's his adresse IP or not?
> 
> It is all in the PAN and BNEP specifications. Read
> them.
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
