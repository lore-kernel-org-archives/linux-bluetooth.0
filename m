Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <420CE4EA.8060409@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net, i_p_a_u_l@yahoo.com
Subject: Re: [Bluez-users] btsco and headsets questions
References: <pan.2005.01.14.17.57.33.66150@yahoo.com>
In-Reply-To: <pan.2005.01.14.17.57.33.66150@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 11 Feb 2005 10:01:30 -0700

Paul

> I was playing with btsco and my bt headset, and I noticed that as long as
> btsco is connected, the headset is active and there is SCO traffic even
> if the alsa device is not used by anything.
> This means that the headset has no chance to enter idle mode in order to
> save power. 
> Is this the intended behavior or is my setup flawed ?
> Otherwise the headset is working ok.

our server should time out the connection when not busy. I will add this 
to the bug list now.

> Another question is how to set up my linux to automatically connect to the
> headset when I press the button on it ?
> I think of something like inetd for tcp/ip, which should listen for bt
> connections and route them to the appropriate programs.
> I need something to listen for my headset, and when I press the button on
> it and it tries to connect to my computer (last paired device), then it
> will launch btsco MAC-ADDR-OF-REQUESTER.
> Is this possible without writing a new program ?

This is in our bug list already. Yes, it needs to be written [by someone].

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
