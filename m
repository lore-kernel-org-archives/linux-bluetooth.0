Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <404392DE.2010500@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO. Some ideas.
References: <A1F0D47583A2D711919F00600819B3A45BDAF5@goofy.vitronics.com>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A45BDAF5@goofy.vitronics.com>
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
Date: Mon, 01 Mar 2004 19:45:34 +0000

Williams, Richard wrote:
> James,
> 
> Thanks for the reply. But I am having trouble getting SCO to work on my
> platform. Can you point me to any documentation that explains how
> to get this to work ? I want to have a Sony-Ericsson BT headset to 
> send/receive audio to/from my Linux box - 2.4.19. 
> 
> I do have BT working: rfcomm, SDP, Obex, but SCO is giving me more 
> trouble.
> 
> Thanks very much,
> 
> Rich
> 

So, you have applied this patch to the kernel ?
http://www.holtmann.org/linux/kernel/patch-2.4.19-mh14.gz

To test it use the hstest program in bluez-utils/test

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
