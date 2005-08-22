Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Reset card
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <430A2579.2060609@hasborg.com>
References: <43038D0B.1060209@hasborg.com>
	 <20050819092419.715FE479@arbetsmyra.dyndns.org>
	 <4305A63E.7020507@soft.uni-linz.ac.at> <1124462989.6398.8.camel@notepaq>
	 <430606F9.3060906@hasborg.com> <1124632986.6260.9.camel@notepaq>
	 <430A2579.2060609@hasborg.com>
Content-Type: text/plain
Message-Id: <1124743329.23599.84.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 22 Aug 2005 22:42:09 +0200

Hi Josh,

> > I modified it a little bit to make it more generic, but it is in the CVS
> > now. Feel free to test it. Do I get also a patch for bccmd for a reset
> > command and a patch for decoding this command in hcidump?
> 
> Why, yes!  Attached is a patch to add decoding for hcidump, and a few
> extras for bccmd.  I added "disabletx", "enabletx" and "rand", as well
> as "coldreset" to bccmd.
> 
> Note that coldreset will be decoded in hcidump properly, but hcidump
> dies shortly afterward when it isn't getting a response from the card
> during reset.

thanks for the patch, but always keep the coding style in mind and
follow it.

The coldreset, disabletx and enabletx commands are valueless and so you
must handle them like this.

I fixed that and added also the missing BCCMD variables to hcidump.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
