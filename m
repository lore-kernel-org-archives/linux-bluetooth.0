Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Strange hci_get_route() result
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Albert Huang <ashuang@gmail.com>
In-Reply-To: <20050711180747.C34033A4@arbetsmyra.dyndns.org>
References: <20050710224918.A15613CE@arbetsmyra.dyndns.org>
	 <1121094313.6158.9.camel@notepaq>
	 <20050711180747.C34033A4@arbetsmyra.dyndns.org>
Content-Type: text/plain
Message-Id: <1121109721.5934.17.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Jul 2005 21:22:01 +0200

Hi Albert,

> > check the CVS. I changed the hci_get_route() lately.
> 
> My lib is up to date with CVS so that's not the problem.

please try again. What happens if you use NULL as address argument.

> > And the ba is
> > the address of the remote system.
> 
> Really? umm, ok. The "manual" by Albert Huang 
> http://people.csail.mit.edu/albert/pubs/ashuang-sm-thesis-2005.pdf  
> states the opposite. If you happen to already know the bdaddr of a 
> *local* adapter you can look up its device id with hci_get_rotue(). I 
> guess there is no such handy utility function then? 

It is really the remote address. Otherwise this function wouldn't make
any sense. We need to find a local adapter that can connect to the
remote one. This is the reason why it is called *_route().

Use hci_devid() if you wanna get the dev_id of a local adapter when you
know its address.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
