Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: Michel Planques <mplanque@laas.fr>
Cc: grpmind+bluez.users@boromir.vpop.net,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2338.82.255.26.193.1076970003.squirrel@www.laas.fr>
References: <20040215000300.0C48932D37@mail.rvs.uni-bielefeld.de>
	 <1076855596.14758.52.camel@pegasus>
	 <2338.82.255.26.193.1076970003.squirrel@www.laas.fr>
Content-Type: text/plain
Message-Id: <1076972291.2840.57.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 16 Feb 2004 23:58:12 +0100

Hi Michel,

> l2test is a good tool to generate Bluetooth traffic between 2 linux
> stations. You can also use the PAN profile with bnep protocol and a
> TCP/UDP traffic generator : I suggest iperf (it works on Linux and
> Windows). I followed these two methods and the results were similar.

of course l2test is one of the best tools, but in case of some iPAQ's
you have the problem that the UART is too slow and you will never reach
the full Bluetooth bandwidth ;)

> I had some bad experiences with the packet type choosen by my dongle's
> link manager. I had to force the packet type to DH5 reach the maximum bit
> rate.

This is one of the biggest problem with bad link managers. I have seen
this very often :(

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
