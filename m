Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hciattach killed
From: Marcel Holtmann <marcel@holtmann.org>
To: Kutschenreuter Matthias <Matthias.Kutschenreuter@siemens.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <AFE91B59A185A5439840B43AB79190470938E8@mchp997a.mch.sbs.de>
References: <AFE91B59A185A5439840B43AB79190470938E8@mchp997a.mch.sbs.de>
Content-Type: text/plain
Message-Id: <1078326250.2787.128.camel@pegasus>
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
Date: Wed, 03 Mar 2004 16:04:11 +0100

Hi Matthias,

> we use the latest available bluez-modules on a 2.4.21
> kernel with the latest available patch.

my fault. I meant what kind of Bluetooth module do you use?

> OK, we did some changes in the hciattach, because we do 
> weired things like attaching a BT Chip that has no EPROM.
> so we have to tell the device its MAC address with 
> "hciattach ttyS0 <special> 115200 <MAC>"
> 
> But we think, the Ctrl-C problem isnt due to our changes, 
> we only adapted the initialisation of the chip, like demanded
> by the chip. 

Show us the code and we will see what you have done. If you really
changed so much then go back and try it with a standard Bluetooth module
and see if it also shows the same problems.

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
