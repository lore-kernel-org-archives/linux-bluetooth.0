Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Recent CSR BlueCore2 firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: "Rybalkin, Albert" <Albert.Rybalkin@Fiserv.com>
Cc: "'albertr@iral.com'" <albertr@iral.com>,
   "'bluez-devel@lists.sourceforge.net'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <CF8C38B8FA1ED511A92400508BE37F0B0A961D1A@exchange_corp.bhcsecurities.com>
References: 
	 <CF8C38B8FA1ED511A92400508BE37F0B0A961D1A@exchange_corp.bhcsecurities.com>
Content-Type: text/plain
Message-Id: <1081150592.2835.3.camel@pegasus>
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
Date: Mon, 05 Apr 2004 09:36:32 +0200

Hi Albert,

> Already tried it. Of course, they don't have any firmware
> updates. In fact, they seem to use a generic bluecore2
> firmware in their usb dongle, since it has generic CSR
> vendor/product ids.

even if it is has a CSR chip in it does not mean it will accept every
firmware. Your firmware must be signed with the right key otherwise the
bootloader won't boot it.

> It's probably a moot point, but just wondering why CSR
> seems to be so restrictive about letting people update
> firmware in their products? For instance, later releases
> supposed to confirm to 1.2 specs, why not allowing free
> access to it? 

Take a look at the mailing list archive. There is a detailed description
why they did it this way.

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
