Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300801300819k583a931codf6cf224aebd8db3@mail.gmail.com>
References: <50282bd30801290946l359dc7a6j29bb3b891ab35f9a@mail.gmail.com>
	<d89ddf300801291107y15ba6888n65c6841f8c95088f@mail.gmail.com>
	<d89ddf300801300819k583a931codf6cf224aebd8db3@mail.gmail.com>
Date: Wed, 30 Jan 2008 18:47:50 +0100
Message-Id: <1201715271.6218.106.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] ARM optimization
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Brad,

> Cidorvan has a new proposal. It shifts MUL/MULA around so the
> assignment happens outside the macro. The good news is the assembly is
> now limited to a single ifdef around the macro definition. If we had
> to define eg MIPS code or something specialized it would be relatively
> quick & clean.
> 
> The tricky part is he nests the use of the macro. I'll show you how he
> formatted it. Formatting it in a traditional way will get messy
> quickly unfortunately.

this is tricky since the semantic of the other macros is different.
Having to separate semantics is a bad things. So changing the semantic
of MULA is a bad idea.

My idea would be to keep the semantic of MULA and only make it a two
stage thing. In case of no assembler we still use MULA as it is right
now, but in case of assembler it calls MULA_ARM which will do the
calculations and then the assignment. Will this work? Is the compiler
smart enough to optimize the code properly.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
