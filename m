Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-ID: <20060309061255.GC4516@beta.private.mielke.cc>
References: <20060308221925.17d20407.fotopiper@o2.pl> <20060308214031.GZ4516@beta.private.mielke.cc> <20060308230109.202dc5ff.fotopiper@o2.pl> <20060308221644.GA4516@beta.private.mielke.cc> <20060309064424.584539d2.fotopiper@o2.pl> <20060309055552.GB4516@beta.private.mielke.cc> <20060309070649.007fba22.fotopiper@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060309070649.007fba22.fotopiper@o2.pl>
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
Date: Thu, 9 Mar 2006 01:12:55 -0500

[quoted lines by Radek Rurarz on 2006/03/09 at 07:06 +0100]

>A simpler method would be to relly on another pinhelper (for
>instance one from the bluez-utlis) set in a config file.. juts pass the
>arguments to it.. and see if it returns a propper pin.. if not fall
>back to the internal methods (promp if allowed, the pin file shoud be
>checked first).

Do you think it should be just one, or should multiple specifications of the
option accumulate a set of helpers to try?

>Sorry, didn't noticed that... I need to work on my sh skills ;)

I'm grateful that you didn't as that gave me the idea to document the
"feature".

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://FamilyRadio.com/                   | http://Mielke.cc/bible/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
