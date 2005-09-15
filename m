Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: AndreasBeckbecka-bzdvl@bedatec.de
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] skype_bt_hijacker released/updated
Message-ID: <20050915115712.GA5233@uni-duesseldorf.de>
References: <20050827193154.GA7618@uni-duesseldorf.de> <4327AD9A.6010500@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4327AD9A.6010500@xmission.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 15 Sep 2005 13:57:12 +0200

Hi Brad,
> > I've played around with integrating skype and btsco a little further,
> > and now it starts making some sense to publish the current state:
> I put this in contrib/ in our btsco cvs and modified/applied your patch. 
> I tweaked a couple of things, so can you make sure it looks good?

Looks great. The -s switch is a good idea. I wonder if one should make
it take the lockfile path as a parameter.

I've seen you also added the AGC/LostByte fixup. Looks fine, too.

I'll update my package to reflect your Changes for those that grab it
from my site and put a pointer there, that it has been integrated into
the contrib dir and will be maintained there.

If I have major changes (don't think so, works like a charm for me, but
maybe users have some ideas on how to enhance it), I'll send them to 
you, or you can give me (ggibecka on sf) CVS write to the 
contrib/skype_bt_hijacker subdir.


Thanks and CU, Andy

-- 
= Andreas Beck                    |  Email :  <becka-sig@bedatec.de>         =


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
