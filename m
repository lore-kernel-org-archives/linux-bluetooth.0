Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050302152111.60949.qmail@web26605.mail.ukl.yahoo.com>
From: BZ Benny <bennybbz@yahoo.fr>
Subject: Re: [Bluez-users] creation of Bnep0
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1109775195.8284.19.camel@pegasus>
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
Date: Wed, 2 Mar 2005 16:21:11 +0100 (CET)

Tanks Marcel,

It's exactly wath I wanted to know.

I will see that in the archive. But i think that you
choose to create it in the kernel for better
performance.

regards
benny


 --- Marcel Holtmann <marcel@holtmann.org> a écrit : 
> Hi Benny,
> 
> > I see how you create bnep0 with the netdev.c using
> > linux/netdevice.c
> > 
> > Is it the only way for linking bnep with TCP/IP
> layers?
> 
> I do not fully understand this question, but in
> general it is also
> possible to use TUN/TAP and a daemon dealing with
> BNEP in userspace. It
> was discussed a long time ago and you will find the
> details in the
> mailing list archive.
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
