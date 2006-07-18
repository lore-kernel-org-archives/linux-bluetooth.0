Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1153218888.2497.15.camel@johannes.berg>
References: <1153218888.2497.15.camel@johannes.berg>
Date: Tue, 18 Jul 2006 12:40:54 +0200
Message-Id: <1153219254.4639.2.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] K600i and hidp
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Johannes,

> When I recently tried the remote control feature on my K600i, I noticed
> that it wouldn't work because the phone doesn't advertise proper
> capabilities. I put into my notes:
> 
> [...]
> Apparently the phone has a bug and doesn't describe its subclass
> properly, it seems to never send the bits 0x80 or 0x40 in it, while that
> is required. I had to patch the hidp_setup_input function in
> net/bluetooth/hidp/core.c (lines 546 and 562) to ignore the subclass
> bits.
> [...]
> 
> Can we have some sort of device quirk table here to ignore the subclass
> bits for certain devices?

you can use "hidd --subclass=<val> ..." for this.

> (Oh and another question is -- how about moving all this into the
> userspace daemon and using uinput?)

The overall goal is to merge the USB HID driver with the Bluetooth HID
and this is one reason why it is inside the kernel. The other is that we
need good latency for HID.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
