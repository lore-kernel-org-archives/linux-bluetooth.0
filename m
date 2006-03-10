Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Mielke <dave@mielke.cc>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-ID: <20060310205503.GL4516@beta.private.mielke.cc>
References: <20060309192953.52ee8c2e.fotopiper@o2.pl> <20060309193423.GF4516@beta.private.mielke.cc> <20060309225521.0f407da9.fotopiper@o2.pl> <20060309230420.05dc3497.fotopiper@o2.pl> <20060310013307.GG4516@beta.private.mielke.cc> <20060310082859.57eaf23b.fotopiper@o2.pl> <20060310172525.GJ4516@beta.private.mielke.cc> <20060310191346.077462e0.fotopiper@o2.pl> <20060310183933.GK4516@beta.private.mielke.cc> <20060310202247.0ae102c2.fotopiper@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060310202247.0ae102c2.fotopiper@o2.pl>
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
Date: Fri, 10 Mar 2006 15:55:04 -0500

[quoted lines by Radek Rurarz on 2006/03/10 at 20:22 +0100]

>bluepin: invalid file permission modes:

Fixed. Thanks. Here's a newer version which implements 
/etc/bluetooth/bluepin.conf.  Try putting the following lines in it (indent not 
required):

   prompt no
   modes off

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
