Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix some bugs in hcidump.
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <403A1693.1060909@superbug.demon.co.uk>
References: <40397111.7000903@superbug.demon.co.uk>
	 <1077522140.2832.70.camel@pegasus>  <403A02FA.60008@superbug.demon.co.uk>
	 <1077545085.13454.1.camel@pegasus>  <403A1693.1060909@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1077557957.2791.58.camel@pegasus>
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
Date: Mon, 23 Feb 2004 18:39:17 +0100

Hi James,

> I have also added some extra checks so that the while loops will not go 
> mad if there is a badly formed packet. I.E. n,n1,n2 get given bad values.

patch is applied with some cosmetical changes.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
