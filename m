Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] creation of Bnep0
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050308132455.92993.qmail@web26604.mail.ukl.yahoo.com>
References: <20050308132455.92993.qmail@web26604.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1110391117.5462.32.camel@notepaq>
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
Date: Wed, 09 Mar 2005 18:58:36 +0100

Hi Benny,

> I was reading the archive about the story of BNEP.
> and I see that Max was more interested in an
> implementation with TUN/TAP device.
> a breif description of fabricio was a VTun support of
> BNEP packet:
> 
> 
> >>extending VTun so it implements BNEP
> 
> >One way would be to implement BNEP support in vtund.
> >Packets would be sent to a TAP (virtual Ethernet) and
> >vtund would format the Ethernet packet to BNEP. Only,
> >all packets would have to go to user space before
> >being sent to the Bluetooth socket.
>  
> My quetsion is : was there a Bluez release which use
> TUN/TAP device? 

not that I know of.

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
