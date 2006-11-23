Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200611231051.18032.denis.kenzior@trolltech.com>
References: <200611211504.42604.denis.kenzior@trolltech.com>
	<200611220959.20956.denis.kenzior@trolltech.com>
	<1164176698.23477.17.camel@localhost>
	<200611231051.18032.denis.kenzior@trolltech.com>
Date: Thu, 23 Nov 2006 05:46:55 +0100
Message-Id: <1164257215.4847.6.camel@localhost>
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

> Oof, ouch.
> 
> In my defense, I followed the advice given in Linux CodingStyle document.  
> Most of the indentation issues you had a problem with was due to me using 
> 'indent' with the suggested options.
> 
> In the future I will happily follow the code style conventions you outline.  
> However, given that this is my first serious submission I cannot be expected 
> to 'guess' the conventions if they are not written down, especially since 
> these are not outlined in the Linux CodingStyle document.  

I simply have to keep the coding style unique for the whole project,
because otherwise patching will become a nightmare. We actually follow
the Linux kernel coding style and the best documentation is the paper
from Greg KH a couple of years ago. I linked the paper and his talk from
this page:

http://www.bluez.org/development.html

And one small piece of advise. Don't use indent. Nothing good comes out
of it. Following the kernel coding style also implies to rethink the
usage of goto and some other constructs where universities tried to tell
you that these are bad. However this is a learning process and when you
submit more and more patch you will definitely get a feel for it.

> Since it seems that BlueZ has further conventions that developers should be 
> following, which are not outlined in the Linux Coding Style documents, I 
> suggest that you include them on the Coding Style section of the Development 
> page of bluez.org to avoid such problems in the future :)

I should write something about the extra conventions, but to my shame, I
am too lazy.

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
