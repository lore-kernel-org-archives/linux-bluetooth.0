Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Strange hci_get_route() result
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050710224918.A15613CE@arbetsmyra.dyndns.org>
References: <20050710224918.A15613CE@arbetsmyra.dyndns.org>
Content-Type: text/plain
Message-Id: <1121094313.6158.9.camel@notepaq>
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
Date: Mon, 11 Jul 2005 17:05:13 +0200

Hi Ronny,

> On my system there's something fishy going on with the library function 
> "hci_get_route()". When I use several dongels simultaneously it returns 
> wrong value. I might be doing things wrong too of cource. This code 
> below:
> 	str2ba("00:11:22:33:44:55", &ba);
> 	dev_id = hci_get_route(&ba);
> 	printf("%d\n", dev_id);
> 
> Prints "-1" as device id when I have one dongle attached and it prints 
> "1" when I've got two. Both are incorrect, it should be 0.
> 
> However, if I apply the patch below it works much better. I find it 
> very strange though if such a basic function is buggy, so what 
> am I doing wrong? 

check the CVS. I changed the hci_get_route() lately. And the ba is the
address of the remote system.

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
