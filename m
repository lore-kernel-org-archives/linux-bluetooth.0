Return-Path: <cyrus@holtmann.org>
From: Florian Echtler <floe@butterbrot.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1209043097.12684.6.camel@violet.holtmann.net>
References: <1208950651.6611.167.camel@pancake>
	<1208956070.6611.173.camel@pancake>
	<E8B28499-36A8-493E-A680-2AA6126617BB@holtmann.org>
	<1209038634.6611.209.camel@pancake>
	<1209043097.12684.6.camel@violet.holtmann.net>
Date: Thu, 24 Apr 2008 22:38:45 +0200
Message-Id: <1209069525.6611.216.camel@pancake.floe.gotdns.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Question
	about	hci_create_connection	and	clock	offset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> And no matter what you try, creating an ACL baseband connection is most
> expensive operation in Bluetooth. So it takes time and that it takes
> even more time if you have to wait for the page timeout if the device is
> not in range.
Hmm, ok.. I see that I'm probably still lacking some background
knowledge here. Can you suggest a document besides the official spec
that offers a detailed explanation of baseband and link manager?

Thanks, Yours, Florian
-- 
0666 - Filemode of the Beast


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
