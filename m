Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems when connect Nokia 7650 to an arm box
	with BlueZ
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <c93f2a29050629233978453a1c@mail.gmail.com>
References: <c93f2a29050629200733f9acd6@mail.gmail.com>
	 <1120108334.15397.141.camel@pegasus>
	 <c93f2a29050629233978453a1c@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120118434.7502.342.camel@justakiss>
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
Date: Thu, 30 Jun 2005 10:00:34 +0200

Am Don, den 30.06.2005 schrieb Embedded System um 8:39:
> hi, Marcel
>  
> Thanks for the prompt reply! But for my case, the kernel is hard to
> change, could you please advice me what can I do for the time being,
> to ensure the data can be sent & received correctly?
>  
> Regards,
> Andy
>  
> On 6/30/05, Marcel Holtmann <marcel@holtmann.org> wrote: 
>         Hi Andy,
>         
>         > I am currently connect Nokia 7650 to an arm box (kernel
>         2.4.27) via
>         > Serial Profile using BlueZ( libs-2.14, utils-2.14,
>         hcidump-1.16). 

which bluetooth adpater do you use, and what is your cpu? Have you
checked that you don't get overrun errors on the serial port?

Erwin




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
