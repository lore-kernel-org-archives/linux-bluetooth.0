Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-ID: <20060310013307.GG4516@beta.private.mielke.cc>
References: <20060308230109.202dc5ff.fotopiper@o2.pl> <20060308221644.GA4516@beta.private.mielke.cc> <20060309064424.584539d2.fotopiper@o2.pl> <20060309055552.GB4516@beta.private.mielke.cc> <20060309070649.007fba22.fotopiper@o2.pl> <20060309061255.GC4516@beta.private.mielke.cc> <20060309192953.52ee8c2e.fotopiper@o2.pl> <20060309193423.GF4516@beta.private.mielke.cc> <20060309225521.0f407da9.fotopiper@o2.pl> <20060309230420.05dc3497.fotopiper@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060309230420.05dc3497.fotopiper@o2.pl>
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
Date: Thu, 9 Mar 2006 20:33:08 -0500

[quoted lines by Radek Rurarz on 2006/03/09 at 23:04 +0100]

>:( Unfortunatelly it doesn't.. BusyBox.. it seams to be mising some
>things..
>
>I get:
>/usr/bin/bluepin: 158: shopt: not found

shopt is a bash built-in command.

>/usr/bin/bluepin: 159: typeset: not found

typeset is a bash built-in command.

d>bluepin: 
>exit: 159: Illegal number:

Does your ipaq have /bin/bash, or did you try changing the first line of the
script so that it points to /bin/sh. It looks like it isn't running bash. If
bash isn't available on these platforms, or if a less functional version of
bash is being used, then we'll just have to change the code to not use some of
bash's cooler features.

>Any ideas for making the script more portable?

I usually have ideas, but we need to first figure out what the problem is. If
the system does have bash, can you figure out which version of bash it is?

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
