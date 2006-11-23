Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 23 Nov 2006 10:51:17 +1000
References: <200611211504.42604.denis.kenzior@trolltech.com>
	<200611220959.20956.denis.kenzior@trolltech.com>
	<1164176698.23477.17.camel@localhost>
In-Reply-To: <1164176698.23477.17.camel@localhost>
MIME-Version: 1.0
Message-Id: <200611231051.18032.denis.kenzior@trolltech.com>
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

Marcel,

Oof, ouch.

In my defense, I followed the advice given in Linux CodingStyle document.  
Most of the indentation issues you had a problem with was due to me using 
'indent' with the suggested options.

In the future I will happily follow the code style conventions you outline.  
However, given that this is my first serious submission I cannot be expected 
to 'guess' the conventions if they are not written down, especially since 
these are not outlined in the Linux CodingStyle document.  

Since it seems that BlueZ has further conventions that developers should be 
following, which are not outlined in the Linux Coding Style documents, I 
suggest that you include them on the Coding Style section of the Development 
page of bluez.org to avoid such problems in the future :)

Regards,
-Denis

> You are doing way too much casts. Especially all casts for malloc() and
> free() are totally unneeded. Make sure you include malloc.h and
> everything will be fine. Check the manual pages for needed includes if
> you are unsure. Every cast has a potential to hide an error. Please do
> only casts if you really have to and you are 100% sure it is the only
> way to make this code working.
>
> Pointer are never initialized  with "= 0". Never. If you have to, then
> it is "= NULL". The same applies to any comparison and I prefer doing
> this with "!" as NULL check.
>
> In general, the assigned of a variable when declaring it will only hide
> programming mistakes that a compiler warning might have found. This
> applies to any compiler warning you see. Don't try to hide. Understand
> the real cause for it and fix that.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
