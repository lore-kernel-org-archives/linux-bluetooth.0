Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dtl1_cs suspend bug
From: Marcel Holtmann <marcel@holtmann.org>
To: Justin Karneges <justin-qt@affinix.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200309230508.07932.justin-qt@affinix.com>
References: <200309220408.04569.justin-qt@affinix.com>
	<200309230508.07932.justin-qt@affinix.com>
Content-Type: text/plain
Message-Id: <1064319593.1619.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 23 Sep 2003 14:19:47 +0200

Hi Justin,

> I've spent way too many hours on this now, probably 12 in the last two days, 
> and still I have no solution.  This is after crashing my Zaurus an 
> uncountable number of times.  I'm about to give up, simply because I can't 
> waste away my time like this.  What I wanted was to make this thing clean, 
> but instead I spent probably more time in hacking then I'll ever do in 
> ejecting and inserting of my Bluetooth card.
> 
> I don't think I want to see another info->link or mod_timer again in my life.
> 
> I hereby commend anyone who manages to do kernel development.  Personally, I'd 
> like to start throwing things out the window.

don't expect too much, because I think this problem is not solveable
with 2.4 and I am waiting for the final 2.6 with the changes in the
PCMCIA subsystem before I ever start working on this again.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
