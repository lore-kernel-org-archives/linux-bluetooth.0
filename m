Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200611220959.20956.denis.kenzior@trolltech.com>
References: <200611211504.42604.denis.kenzior@trolltech.com>
	<1164094861.28429.13.camel@localhost>
	<200611220959.20956.denis.kenzior@trolltech.com>
Date: Wed, 22 Nov 2006 07:24:58 +0100
Message-Id: <1164176698.23477.17.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] XML SDP Record Registration
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Denis,

> Here's a fixed up version of the patch.

not it is not. I spent the last hours to fix your coding style mistakes.
I really like the stuff you do, but the more time I have to spent to fix
your code, the unlikelier I might include it. Here are some tips:

You are doing way too much casts. Especially all casts for malloc() and
free() are totally unneeded. Make sure you include malloc.h and
everything will be fine. Check the manual pages for needed includes if
you are unsure. Every cast has a potential to hide an error. Please do
only casts if you really have to and you are 100% sure it is the only
way to make this code working.

Pointer are never initialized  with "= 0". Never. If you have to, then
it is "= NULL". The same applies to any comparison and I prefer doing
this with "!" as NULL check.

In general, the assigned of a variable when declaring it will only hide
programming mistakes that a compiler warning might have found. This
applies to any compiler warning you see. Don't try to hide. Understand
the real cause for it and fix that.

No public function when they are not needed. I prefer you declare
everything as static first and then non-static if needed. In this case
the compiler also warns you about unused code.

Keep the API simple. All of this is internal stuff and we can change it
without breaking any other applications. Having only one function for
the XML parsing makes it really simple and you don't have to play any
nasty typedef tricks. Speaking of which, typedefs should be avoided
whenever possible. Our SDP API is not a good example for that, I know
that, but it is too late to change it.

> I've made a script that dumps all profiles that sdptool supports and registers 
> them back using XML and compares the results.  It seems to work for all of 
> them, but further testing would be appreciated.

Care to send a patch for sdptool that retrieves SDP records in XML
format.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
