Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about correctness of hci_usb
	sco	support.
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4041509E.9000402@superbug.demon.co.uk>
References: <403F8EAC.40701@superbug.demon.co.uk>
	 <1077973622.2843.75.camel@pegasus>  <4041509E.9000402@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1078022529.1942.6.camel@pegasus>
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
Date: Sun, 29 Feb 2004 03:42:09 +0100

Hi James,

> __recv_frame()  receives a frame from the USB interface.
> It then joins up frames to create a full HCI packet to send to higher 
> layers.
> "struct sk_buff *skb = __reassembly(husb, type);"
> 
> So we have a skb for each HCI type.
> The skb will not exist the first time we receive an frame of a 
> particular type.
> The current code always assumes that the first frame it receives of a 
> particular type will always be the first frame of an HCI packet that 
> might consist of multiple frames.
> I can't understand how we can be 100% that the first frame seen is 
> always the first frame of the HCI packet.
> I can't see why we cannot ever see a situation where the first frame 
> received of a particular type might instead be the second frame of the 
> HCI packet. As the __recv_frame() uses the contents of that first frame 
> to control the reassembly process. How can we be sure that that first 
> frame does in fact contain the first frame of a valid HCI packet?
> E.g. If a remote bluetooth device somehow creates an HCI packet with 
> bogus HCI header, surely this could (worst case) crash the kernel?

I don't really see a problem here, because remote devices has nothing do
to with the local HCI. We can only be in trouble if we lost an URB.

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
