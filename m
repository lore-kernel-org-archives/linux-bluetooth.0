Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification testing.
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002a01c4d7f9$d4424d40$1a01010a@baked>
References: <002a01c4d7f9$d4424d40$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1101972944.15615.78.camel@pegasus>
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
Date: Thu, 02 Dec 2004 08:35:44 +0100

Hi Daryl,

> > do you have a hcidump or another trace for me?
> 
> An hcidump is attached. Though I don't think you'll learn much from it.

actually I learned that hcidump can't deal with the hint bit and that it
don't understand the QoS option. Both is fixed in CVS and looks now like
this:

> L2CAP(s): Config req: dcid 0x0040 flags 0x0001 clen 4
  [MTU 672] 
< L2CAP(s): Config rsp: scid 0x0040 flags 0x0001 result 0 clen 0
> L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 28
  [FlushTO 65535] [QoS 0x01 (Best effort)] 
< L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0

We send two empty resposonses, but from my current understanding this is
fine. All of the options have set the hint bit (indicated by []). Maybe
I am missing something, but the specification says:

	option is a hint; if the option is not recognized then
	skip the option and continue processing

So our responses are valid, because we answer both requests.

> > Not at the moment and maybe not so fast. This needs a little bit more
> > work.
> 
> Agreed - doing it right is probably not something that's going to happen
> quickly.
> 
> We will probably have to go with the hack (probably with some overflow
> checking added) for the sake of expediency, unless one of us comes up with a
> better solution shortly.

For you it is the best to go with the hack, because I don't think that I
will backport such a change to the 2.4 kernel series.

However do you also have a hcidump from that test for me?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
