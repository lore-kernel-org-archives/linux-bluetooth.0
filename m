Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Suspend/resume issues with bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: Mitsu Hadeishi <mitsu@syntheticzero.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200403091754.52270.mitsu@syntheticzero.com>
References: <200403022202.19259.mitsu@syntheticzero.com>
	 <200403032224.08229.bluez-devel@cpinkney.org.uk>
	 <200403091754.52270.mitsu@syntheticzero.com>
Content-Type: text/plain
Message-Id: <1078877075.30990.2.camel@pegasus>
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
Date: Wed, 10 Mar 2004 01:04:35 +0100

Hi Mitsu,

> Just a note to the list regarding suspend/resume.  I have a Thinkpad T40p 
> which was having problems with bluez and suspend/resume.  I just tried 
> installing the Affix drivers on my Thinkpad T40p; but I had the same problem 
> (well, it was slightly different, but the upshot was, Bluetooth didn't work 
> when I came back from suspend).

I think the problem is in the USB subsystem at the moment. There are
some outstanding issues with some USB cards, but Alan Stern is going to
fix them. This will only happen for 2.6.x and I don't think that these
issues can be solved in 2.4, too.

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
