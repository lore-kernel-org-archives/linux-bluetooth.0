Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300801301126o53f5d8e1rb8443767ce071e54@mail.gmail.com>
Date: Wed, 30 Jan 2008 12:26:48 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201715271.6218.106.camel@violet>
MIME-Version: 1.0
References: <50282bd30801290946l359dc7a6j29bb3b891ab35f9a@mail.gmail.com>
	<d89ddf300801291107y15ba6888n65c6841f8c95088f@mail.gmail.com>
	<d89ddf300801300819k583a931codf6cf224aebd8db3@mail.gmail.com>
	<1201715271.6218.106.camel@violet>
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

Marcel

The other macros are not being used and I had intended to remove them.
We use only MUL/MULA.

> My idea would be to keep the semantic of MULA and only make it a two
> stage thing. In case of no assembler we still use MULA as it is right
> now, but in case of assembler it calls MULA_ARM which will do the
> calculations and then the assignment. Will this work? Is the compiler
> smart enough to optimize the code properly.

I don't know how to do this but maybe Cidorvan can see it.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
