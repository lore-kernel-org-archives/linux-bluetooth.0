Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4216700F.5010106@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hcitool scan times
References: <ac72cfc805021801246a15de74@mail.gmail.com>	 <421638BC.2020808@gmx.ch> <ac72cfc8050218143042696ba4@mail.gmail.com>
In-Reply-To: <ac72cfc8050218143042696ba4@mail.gmail.com>
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
Date: Fri, 18 Feb 2005 23:45:35 +0100



Emiliano Heyns wrote:
> On Fri, 18 Feb 2005 19:49:32 +0100, Marco Trudel <mtrudel@gmx.ch> wrote:
> 
>>hello emiliano
>>
>>read the bluetooth specification.
>>you've to allow remote devices ~10.5 seconds to answer... so 13 seconds
>>makes sense...
>>that it is so fast from time to time is, because a cached result is
>>returned. look at the source of hcitool for more information...
> 
> 
> OK, thanks. This could actually work to my benefit if I disable the
> hcitool cache --

you're welcome...

> the device could take the time the user takes from
> walking into range to being at the device for detecting,

I don't know what you mean with this...

 > if you walk
> out of range before that you were only passing the device. Good. Now I
> only have to look at average office walking speeds to see how great I
> want this radius to be :)

I don't understand that as well, but it sounds very interesting. Can you 
explain what you're doing? Just curious...

by the way: do you know that a device does not have to answer to an 
inquiry? if a device is busy or just decides to not answer to an inquiry, 
that's ok (defined in bluetooth specification, my experience showed this as 
well)...


regards
Marco


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
