Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050317161431.45633.qmail@web26607.mail.ukl.yahoo.com>
From: BZ Benny <bennybbz@yahoo.fr>
Subject: Re: [Bluez-users] Adresse resolution in BlueZ
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
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
Date: Thu, 17 Mar 2005 17:14:31 +0100 (CET)


Hi all.


> Hi Benny,
> 
> > > This BNEP virtual network card is as dumb as a
> > normal 
> > > Ethernet network card. The networklayer knows
> our
> > MAC
> > > address (BD_ADDR) and 
> > 
> > Actually I'm talking about the peer MAC address.
> 
> you know that even BNEP is point-to-point and so you
> know the MAC
> address of the peer, because it is the remote
> BD_ADDR of the underlaying
> ACL link.
>
Am I not undertandbale ?
Is there someone who can understand me? 

I know that BNEP know the BD_ADDR of the peer device.
But BNEP need to make a coresspondance beteewn the
peer BD_ADDR address and the peer IP adress. This
corespondance is made by ARP? how did bnep ask it from
ARP.
If you read all my example in my last mail you will
understand my question.

regards,
imad.



	

	
		
Découvrez nos promotions exclusives "destination de la Tunisie, du Maroc, des Baléares et la Rép. Dominicaine sur Yahoo! Voyages :
http://fr.travel.yahoo.com/promotions/mar14.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
