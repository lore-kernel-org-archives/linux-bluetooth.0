Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pan on zaurus
From: Marcel Holtmann <marcel@holtmann.org>
To: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
Cc: "'Philip Blundell'" <pb@nexus.co.uk>,
   "'Bluez-devel@lists.sourceforge.net'" <Bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB791904709391B@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB791904709391B@mchp997a.mch.sbs.de>
Content-Type: text/plain
Message-Id: <1079625649.3301.50.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 18 Mar 2004 17:00:49 +0100

Hi Matthias,

> pand initialises the l2a-struct with "0"s, before binding.
> 	static bdaddr_t src_addr = *BDADDR_ANY; // where BDADDR_ANY is
> {0,0,0,0,0,0}
> 	l2a.l2_bdaddr = src_addr;
>     if (bind(sk, (struct sockaddr *) &l2a, sizeof(l2a)))

I think it is better if you use

	bacpy(&l2a.l2_bdaddr, BDADDR_ANY);

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
