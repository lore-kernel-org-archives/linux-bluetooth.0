Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Extra keyboard events are back with 2.6.8.1 and
	bluez-libs/utils 2.10
From: Marcel Holtmann <marcel@holtmann.org>
To: Vesa Halttunen <vesuri@jormas.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1093375338.560.11.camel@pc.vesuri.net>
References: <1093375338.560.11.camel@pc.vesuri.net>
Content-Type: text/plain
Message-Id: <1093376692.17083.1.camel@pegasus>
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
Date: Tue, 24 Aug 2004 21:44:52 +0200

Hi Vesa,

> I upgraded to Linux 2.6.8.1 and bluez-libs/utils 2.10 and found out that
> the utterly annoying problem I had two months ago has returned: I
> started getting extra characters/keypresses from my Logitech Elite
> keyboard when typing quickly. The symptoms are EXACTLY the same as
> described in my June message:
> 
> http://sourceforge.net/mailarchive/forum.php?
> thread_id=4969052&forum_id=1881
> 
> The problem is simple: when typing quickly multiple keys are down at
> the same time and the key up events are not handled correctly. When
> I type "sources" I get "sourceces".
> 
> I fixed this problem when I was using bthid by patching the bthid source
> to handle the situation explained in my June message. Fortunately the
> problem also kept away after switching to a more recent hcid and hidd:
> 2.6.7-mh1 and bluez-libs/utils 2.7 worked just fine.
> 
> Unfortunately now the problem is back and even though I already patched
> this in bthid I don't know where to look in the current model. Could
> someone please take a look at this problem since it's very annoying?
> See the URL above for my explanation what happens and how I fixed it.

maybe this is a problem of the boot protocol mode. Try using the patch
2.6.8-mh1 with kernel 2.6.8.1.

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
