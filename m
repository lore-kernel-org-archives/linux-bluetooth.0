Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <486BD582.9050004@aircable.net>
References: <486BD582.9050004@aircable.net>
Date: Fri, 11 Jul 2008 08:20:12 +0200
Message-Id: <1215757212.9744.13.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] CreateBonding while periodic scanning
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

Hi Manuel,

> I've sent this patch before, but for some reason I didn't got either a 
> positive or even negative response.
> 
> Problem is like this, when we're doing a periodic scan we should be able 
> to do bonding, but according to the code we can't, so then something is 
> wrong, either we can't do periodic scanning, or we need to fix a bug.

so in general you should be able to create an ACL link when even in
inquiry phase. So in theory it should stop periodic inquiry and then
create the ACL link and then continue. We might have hit some chip
limitations here and this is why it was there. I removed it since it low
risk. No so many applications use periodic inquiry :)

Regards

Marcel



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
