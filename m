Return-Path: <cyrus@holtmann.org>
Message-ID: <035501c8dab3$5596b380$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <1214593557.6131.26.camel@bongo>
	<1214606647.4435.71.camel@cookie.hadess.net>
	<031301c8da4d$0bce3720$6701a8c0@freqonedev>
	<1214813891.4435.149.camel@cookie.hadess.net>
Date: Mon, 30 Jun 2008 08:15:12 -0500
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Wizard patch
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


----- Original Message ----- 
From: "Bastien Nocera" <hadess@hadess.net>
To: "David Stockwell" <dstockwell@frequency-one.com>
Sent: Monday, June 30, 2008 3:18 AM
Subject: Re: [Bluez-devel] Wizard patch


> On Sun, 2008-06-29 at 20:03 -0500, David Stockwell wrote:
>> Out of curiosity, why not use C++ style (//) comments?  Do you prefer
>> the older /*...*/ comments?  Or is there some other reason.
>
> C++-style comments are for temporary comments. Almost all C codebases
> refuse to have C++-style comments in permanent code.

Fair enough.  Also the case that C-compilers sometimes do not handle // 
comments.
>
>> FWIW, it seems to me that most of the code (e.g, the DBus code) is
>> almost completely uncommented...hence very hard to figure out how
>> it actually works, or even how it is intended to work.
>
> There's documentation for D-Bus in */*.txt in bluez-utils. If the
> documentation isn't good enough, either send questions asking for
> clarifications, or patches.

I read the docs and when the code works as expected it is good enough. 
However, I have had a number of problems making the code work (partially 
implemented "experimental" 4.x features in release 3.33 and before).

Also, figuring out how to handle some of the formats (e.g., the "dict" 
with variant) are a bit hard to figure out without a code example.  SO, 
I often have to dig into the actual code and figure out just what is 
going on.
>
> BTW, could you please: reply to the list, quote properly, not 
> top-post,
> and make sure lines are cut to 72 chars in length. I know it's hard
> using Outlook...
>

OK, I normally respond to the list (note that I have not contacted you 
before, and will not again), but had a couple of questions about the 
stylistic points you raised, which I had not seen before.

I think you will also see that this is plain text, cut to 72 chars. 
Easy to do. 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
