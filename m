Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44C881B5.7060809@infitsrl.com>
References: <44BE5DB3.7090406@gmail.com>
	<1153356539.4094.9.camel@aeonflux.holtmann.net>
	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>
	<20060724103824.1ff98fa6@McGee-XPC> <44C4CC37.1060308@infitsrl.com>
	<20060724155621.02cd5e11@localhost.localdomain>
	<1153758912.25058.3.camel@localhost>
	<20060724203433.7184d301@localhost.localdomain>
	<7359D844-F738-4AD1-A1FD-F59BEFD149EC@infitsrl.com>
	<1153775541.25058.6.camel@localhost>  <44C881B5.7060809@infitsrl.com>
Date: Fri, 28 Jul 2006 13:14:21 +0200
Message-Id: <1154085261.2298.34.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] It's rfcomm connect problem
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

Hi Fabrizio,

> I'm trying to use the patch to handle multiple l2cap connection, I'm not 
> a kernel/modules expert developer so
> I need a little help.
> Firts I'm trying to understand what the patch do and I think it's clear 
> (is used a linked list to handle multiple connection).

one warning up-front. I never actually ran this patch on any machine. It
is only compile tested. So it might crash your system.

> My problems are with kernel programming enviromnment:
> 
> 1) I'm using kernel-2.6.10 I have to update to a more recent version?

It might work, but I advise you to develop against 2.6.18-rc2 or even
the Git repository from Linus.

> 2) Is there some documentation about bluez kernel modules? I need to 
> understand how modules works to make try to make the patch.

Check out the kernel documentation itself. There exists no specific
BlueZ documentation for kernel programming.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
