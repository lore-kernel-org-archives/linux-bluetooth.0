Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] A PAN newbie
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <a0580c51050317055564fe7f55@mail.gmail.com>
References: <a0580c510503160953311ea8e2@mail.gmail.com>
	 <1111012139.11792.46.camel@pegasus>
	 <a0580c51050317055564fe7f55@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1111068329.11792.78.camel@pegasus>
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
Date: Thu, 17 Mar 2005 15:05:29 +0100

Hi Eduardo,

>   Thanks for the quick response. It's truth that I get a second bnep
> in the GN, the bnep1. But
> I tried to continue the configuration with a "ifconfig bnep1 10.0.0.4"
> and the problem kept.
> I thinked that at this point (with the two PANU connected and
> configured), I could ping
> the bnep0 with the old PANU and ping the bnep1 with the new PANU, even
> without the
> bridge configuration in the GN.

get yourself a network howto to understand why this is not working.

>   Ok, and how can I do a bridge configuration in the master ??
>   Is it just creating statics routes between the two bnep's?

The bridge is another virtual network card the combines your two BNEP
interface into a new one. This is of course not all a bridge can do, but
this is what you need. However this is not BlueZ specific. This is about
network administration and thus read a howto about that or take a look
at the PAN howto.

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
