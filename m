Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ac72cfc8050218143042696ba4@mail.gmail.com>
From: Emiliano Heyns <emiliano.heyns@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hcitool scan times
In-Reply-To: <421638BC.2020808@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <ac72cfc805021801246a15de74@mail.gmail.com>
	 <421638BC.2020808@gmx.ch>
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
Date: Fri, 18 Feb 2005 23:30:20 +0100

On Fri, 18 Feb 2005 19:49:32 +0100, Marco Trudel <mtrudel@gmx.ch> wrote:
> hello emiliano
> 
> read the bluetooth specification.
> you've to allow remote devices ~10.5 seconds to answer... so 13 seconds
> makes sense...
> that it is so fast from time to time is, because a cached result is
> returned. look at the source of hcitool for more information...

OK, thanks. This could actually work to my benefit if I disable the
hcitool cache -- the device could take the time the user takes from
walking into range to being at the device for detecting, if you walk
out of range before that you were only passing the device. Good. Now I
only have to look at average office walking speeds to see how great I
want this radius to be :)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
