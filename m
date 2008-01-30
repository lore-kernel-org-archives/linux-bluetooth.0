Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <50282bd30801301156w69822b14m744de8cd2374b37a@mail.gmail.com>
References: <50282bd30801290946l359dc7a6j29bb3b891ab35f9a@mail.gmail.com>
	<d89ddf300801291107y15ba6888n65c6841f8c95088f@mail.gmail.com>
	<d89ddf300801300819k583a931codf6cf224aebd8db3@mail.gmail.com>
	<1201715271.6218.106.camel@violet>
	<d89ddf300801301126o53f5d8e1rb8443767ce071e54@mail.gmail.com>
	<50282bd30801301156w69822b14m744de8cd2374b37a@mail.gmail.com>
Date: Wed, 30 Jan 2008 21:21:42 +0100
Message-Id: <1201724503.6218.113.camel@violet>
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

Hi Cidorvan,

> > The other macros are not being used and I had intended to remove them.
> > We use only MUL/MULA.
> >
> > > My idea would be to keep the semantic of MULA and only make it a two
> > > stage thing. In case of no assembler we still use MULA as it is right
> > > now, but in case of assembler it calls MULA_ARM which will do the
> > > calculations and then the assignment. Will this work? Is the compiler
> > > smart enough to optimize the code properly.
> >
> > I don't know how to do this but maybe Cidorvan can see it.
> >
> 
> Like you can see in my first e-mail (gcc-no-arm-optimization.txt), gcc
> wasn't smart enough to optimize assignments.
> The reason to do a macro with assembly code is to force the gcc to use
> the right instruction (smlal) and keep the output code clean.

I think you didn't get my idea, but I also have no time to actually put
it into code right now. So I wanna have the semantics of all macros the
same. According to Brad, the others can be removed. If so, then I am
fine with this change.

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
