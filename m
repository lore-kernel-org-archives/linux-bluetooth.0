Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] BNEP kernel oops
From: Marcel Holtmann <marcel@holtmann.org>
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
Cc: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A4028BB9@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A4028BB9@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1092424437.4501.31.camel@pegasus>
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
Date: Fri, 13 Aug 2004 21:13:57 +0200

Hi Richard,

> I had been using PAN with a 2.4.19 kernel on my embedded system, and this worked somewhat. 
> I could usually get the PAN up and running but I'd get a kernel panic after a few minutes. 
> Since my group had lots of other application problems, we decided to concentrate the group 
> effort to correct all our applications problems. Now our system is quite stable and we have 
> many BT devices connected and sending/receiving data via rfcomm. But we want to have PAN 
> running so we can use some common TCP applications.
> 
> Last week a 2.4.26 kernel became available for my embedded board, so I upgraded to 2.4.26, 
> and today I decided to look at PAN again. I tried plain 2.4.26 this morning, with the oops
> behavior. 
> 
> It was then that I discovered the 2.4.26-mh2 patch, applied the patch and retried. 
> But the same thing happens.
> 
> If you think it will help, I can try the 2.4.26-mh1 patch and give you the results.

so I assume that it is not my patch that causes this oops and so testing
-mh1 will not give us more information. The problem is that you are not
using a vanilla 2.4.26 and this could cause the oops. Please make a diff
between your embedded kernel and the vanilla one. We must check what
they've changed.

Regards

MArcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
