Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <421638BC.2020808@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hcitool scan times
References: <ac72cfc805021801246a15de74@mail.gmail.com>
In-Reply-To: <ac72cfc805021801246a15de74@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 18 Feb 2005 19:49:32 +0100

hello emiliano

read the bluetooth specification.
you've to allow remote devices ~10.5 seconds to answer... so 13 seconds 
makes sense...
that it is so fast from time to time is, because a cached result is 
returned. look at the source of hcitool for more information...

regards
Marco


Emiliano Heyns wrote:
> Hi,
> 
> I want to monitor what BT devices come into range of mt BT stick for
> automation. For this I'm currently just using 'hcitool scan' in a
> loop. Sometimes the scan is pretty quick, 2-3 seconds, but most of the
> time the scan takes about 13 seconds, which is too long for my
> purposes. Can I influence these scan times somehow, possibly even with
> a setting on the palm/phone itself? Why do the scan times vary so
> much?
> 
> Thanks,
> Emiliano
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
