Return-Path: <cyrus@holtmann.org>
Message-ID: <0a9801c8e045$1725d620$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <062301c8de19$144dc990$6701a8c0@freqonedev><1215278245.4349.16.camel@californication><098d01c8def8$6cef31d0$6701a8c0@freqonedev>
	<1215341948.7112.8.camel@californication>
Date: Mon, 7 Jul 2008 10:21:10 -0500
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Creating a 4.x org.bluez.Agent (more on SSP)
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

Hello again, Marcel...

> Hi David,
>
> you will need the kernel patches from my bluetooth-2.6 repository to
> enable Simple Pairing.

I have them and have installed them.  The problem is that I am using a 
BT2.0 compliant USB dongle.  Alas, no BT2.1 compliant dongle is 
available in the US market at this time.

>> At the same time, CreateDevice does not appear to attempt to pair at
>> all.
>
> With Simple Pairing it is just-works model. Otherwise no pairing.

As above, Simple Pairing is not possible, but it does not appear to even 
attempt to fall back to legacy mode.  No messages, no errors thrown, no 
debug messages.

>> For CreatePairedDevice, a bad path (e.g., /x/y/zzy) is fine and 
>> causes
>> fall-back to the Register(ed)Agent if any.  Maybe a little inelegant
>> (imho), but fine.
>
> The right way is to actually implement an agent if you wanna use
> CreatePairedDevice. This fallback happens to work. Use it if you must,
> but we are not encouraging people to do so. Also when writing real UI
> application you do want a specific agent in this case anyway.

Agreed...my comment has to do with the fact that one MUST use 
CreatePairedDevice (at least at this point) to pair.  CreateDevice does 
not even attempt to pair (or at least that is the case if SSP is not 
available).

If you use CreatePairedDevice, you must supply an object path (valid or 
invalid) for the agent.  Therefore, as far as I am concerned, there is 
no real point to registering an agent at all, given that I must supply 
the path to CreatePairedDevice in any event.

On the other hand, if CreateDevice should trigger pairing and actually 
does, and if it can fall back to some default legacy pairing mode, well 
and good.  No agent needed at all.

> I have to fixup the passkey-agent.c example, but there was simply no
> time.

I will be happy to send you mine to save you the effort, unless it 
totally sucks.

Cheers... 


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
