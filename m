Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050308132455.92993.qmail@web26604.mail.ukl.yahoo.com>
From: BZ Benny <bennybbz@yahoo.fr>
Subject: Re: [Bluez-users] creation of Bnep0
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
Date: Tue, 8 Mar 2005 14:24:54 +0100 (CET)

Hi Marcel,

I was reading the archive about the story of BNEP.
and I see that Max was more interested in an
implementation with TUN/TAP device.
a breif description of fabricio was a VTun support of
BNEP packet:


>>extending VTun so it implements BNEP

>One way would be to implement BNEP support in vtund.
>Packets would be sent to a TAP (virtual Ethernet) and
>vtund would format the Ethernet packet to BNEP. Only,
>all packets would have to go to user space before
>being sent to the Bluetooth socket.
 
My quetsion is : was there a Bluez release which use
TUN/TAP device? 

regards,
benny


--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Benny,
> 
> > It's exactly wath I wanted to know.
> > 
> > I will see that in the archive. But i think that
> you
> > choose to create it in the kernel for better
> > performance.
> 
> it is a matter of performance and a matter of a
> better native
> integration and thus making it easier to use.
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
