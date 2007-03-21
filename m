Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45FE8B0B.20500@xmission.com>
References: <45FE8B0B.20500@xmission.com>
Date: Wed, 21 Mar 2007 15:11:07 +0100
Message-Id: <1174486267.15638.25.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] new sco flowcontrol patch
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

Hi Brad,

> per our conversation about this, I have reworked the sco flowcontrol 
> patch against the linus git tree (2.6.21rc2) and successfully tested it. 
> Most of the comments are out so you can more easily see what is 
> changing. I left about 3 comments in that are parts of new blocks of code.
> 
> I made a couple of changes like the signature of a function used as a fn 
> pointer and avoiding a variable rename but this is essentially the same 
> code people have been testing against older kernels.
> 
> It's also in bluetooth-alsa cvs under plugz/patches/
> 
> I used to have a testcase from Fabien that would consistently crash the 
> unpatched kernel but I couldn't dig it up. That would be good for eg 
> regression testing and I will put it in plugz cvs when we track it down.

I did an initial review and there are still some whitespace and coding
style issues that need to be fixed.

The biggest thing however is hci_sched_sco(). This function is ugly as
hell and basically unreadable. Please use break or continue instead of
cascaded if clauses. I am not gonna review this piece of the patch until
that is fixed.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
