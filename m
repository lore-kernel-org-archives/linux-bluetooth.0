Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <403CAFC0.50807@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link help needed
References: <4034CA08.50500@soft.uni-linz.ac.at> <40393D4D.5070908@superbug.demon.co.uk> <1077522938.2832.84.camel@pegasus> <200402251359.00791.mtortonesi@ing.unife.it>
In-Reply-To: <200402251359.00791.mtortonesi@ing.unife.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 25 Feb 2004 14:22:56 +0000

Mauro Tortonesi wrote:
> 
> i have been trying to transfer pcm data over a sco socket both using scotest 
> and other similar apps of mine, but the actual data tranferred were only a 
> bunch of random bytes, completely unrelated to the data sent. moreover, the 
> behaviour of sco links is very unreliable. in my tests i have used several 
> usb dongles with CSR chips (firmware versions ranging from HCI 15.3 to HCI 
> 16.4) and kernel versions from 2.4.22 to 2.4.25-pre7.
> 
> you have told us many times that there are strong limitations in what you can 
> do with sco sockets, but i still can't understand what are these limitations. 
> i have tried searching trough the archives but i couldn't find anything 
> interesting about this.

The standard SCO link takes data from the user app. The CSR chip (any 
bluetooth device in fact) will take that data and treat it as Audio PCM 
samples. the CSR chip will then use a LOSSY codec called CVSD and 
transmit those samples over the air. Due to interference, some of the 
samples in the air get lost. At the receiving end, CVSD is converted 
back into PCM audio. If any samples have been lost in the air, they are 
replaced with duplicate of the previous sample.
Due to the lossy nature of the CVSD codec, the actual PCM values will be 
different at the destination end as they were at the source end. But the 
differences will be such that they are mostly unnoticeable to the human 
ear. So, if you are wishing to transfer anything other than Sound across 
a SCO link, change your mind. If you look at the video streaming 
bluetooth profiles, you will see that they all use Bulk transfers.
Some CSR chips try to include a "Transparent" feature, which disables 
the CVSD codec, and passes samples directly onto the air, but that also 
has problems associated with it.

If your usb device can do Interrupt OUT, use that instead if you need 
low latency output. Some USB dongles can do it, some cannot.

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
