Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Strange hci_get_route() result
References: <20050710224918.A15613CE@arbetsmyra.dyndns.org> <1121094313.6158.9.camel@notepaq>
In-Reply-To: <1121094313.6158.9.camel@notepaq>
Cc: Albert Huang <ashuang@gmail.com>
MIME-Version: 1.0
Message-Id: <20050711180747.C34033A4@arbetsmyra.dyndns.org>
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
Date: Mon, 11 Jul 2005 20:07:24 +0200


> > function "hci_get_route()". When I use several dongels
> > simultaneously it returns wrong value. I might be doing things
> > wrong too of cource. This code below:
> > 	str2ba("00:11:22:33:44:55", &ba);
> > 	dev_id = hci_get_route(&ba);
> > 	printf("%d\n", dev_id);
> >
>
> check the CVS. I changed the hci_get_route() lately.

Hi
My lib is up to date with CVS so that's not the problem.



> And the ba is
> the address of the remote system.

Really? umm, ok. The "manual" by Albert Huang 
http://people.csail.mit.edu/albert/pubs/ashuang-sm-thesis-2005.pdf  
states the opposite. If you happen to already know the bdaddr of a 
*local* adapter you can look up its device id with hci_get_rotue(). I 
guess there is no such handy utility function then? 

Thanks anyway
/Ronny



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
