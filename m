Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Radha Thiagarajan <rthiaga1@urbana.css.mot.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   William List <WLIST@motorola.com>
In-Reply-To: <412CB7E9.30408@urbana.css.mot.com>
References: <412CB7E9.30408@urbana.css.mot.com>
Content-Type: text/plain
Message-Id: <1093452811.537.10.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: TIOCMIWAIT & TIOCGICOUNT
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
Date: Wed, 25 Aug 2004 18:53:31 +0200

Hi Radha,

> I am interested in implementing the two ioctls TIOCMIWAIT and TIOCGICOUNT 
> for RFCOMM that mimic the serial driver behavior. Do you have any 
> recommendations on how this could be done? My initial thought would be to 
> put a process that calls TIOCMIWAIT to sleep and then wake it up when a 
> MSC packet is received. The user could then call TIOCGICOUNT to 
> retrieve which control lines have changed. Any suggestions on this topic 
> would be greatly appreciated.

I never thought about it before, so come up with a patch for it and we
will see. Check first how other serial drivers implemented this.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
