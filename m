Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Can't connect.: Function not implemented
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <01LKSFUD1WC0003PT2@beacon.nuigalway.ie>
References: <01LKSFUD1WC0003PT2@beacon.nuigalway.ie>
Content-Type: text/plain
Message-Id: <1108408616.7780.9.camel@notepaq>
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
Date: Mon, 14 Feb 2005 20:16:56 +0100

Hi Triona,

> Ok now I can l2ping any module once I hcitool cc it. 

you are doing something wrong. There is no problem like this.

> Ok, I think my problem is
>  to do with the sdp modules. I know they're supposed to be included in the bluez
> -utils package, and when I type sdpd, l2cap appears in lsmod. However, Between l
> inux modules, it seems as if sdpd is not present. 
> 
> I've been searching google, 
> and have seen the same error, always with, "sdpd is not installled" as a solutio
> n.  Is there any way I could have unsuitable packages installed?

You only need to install bluez-libs and bluez-utils.

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
