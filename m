Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] What Bluetooth CF cards do developers use?
From: Marcel Holtmann <marcel@holtmann.org>
To: kyler-dated-1083521560.f4658e@lairds.com
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040429181311.GN1862@snout>
References: <20040428135604.GD1862@snout> <1083161388.4000.40.camel@pegasus>
	 <20040428141637.GE1862@snout> <1083162180.4000.45.camel@pegasus>
	 <20040429181311.GN1862@snout>
Content-Type: text/plain
Message-Id: <1083265520.4000.114.camel@pegasus>
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
Date: Thu, 29 Apr 2004 21:05:20 +0200

Hi Kyler,

> I'd be happy to just get it working in my Toughbook for now.  I inserted
> it and got "cs: pcmcia_socket0: unable to apply power."

I never have seen this. You should ask the guys from the LKML.

> > The USB related kernel oopses should all be fixed with the upcoming
> > 2.6.6, I hope.
> 
> Yea!  Will a BlueZ patch be required or is it all going to be in the
> kernel this time?

Right now 2.6.5-mh3 and 2.6.6-rc2 has every needed fix in it, but new
problems are on the road and we are trying to fix them just in time.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
