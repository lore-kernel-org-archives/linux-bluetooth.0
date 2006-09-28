Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1159449063.5406.22.camel@localhost>
References: <1159435134.21120.7.camel@localhost>
	<1159449063.5406.22.camel@localhost>
Date: Thu, 28 Sep 2006 15:38:02 +0200
Message-Id: <1159450682.21120.62.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] L2CAP device specific information
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

Hi Martin,

> > with the release of bluez-utils-3.6 and bluez-utils-3.6.1, I added an
> > additional command to the l2test program to determine the extended
> > features of the remote L2CAP implementation. This will help us to
> > identify which devices will support retransmission and flow control
> > and/or connectionless connections.
> 
> This sounds pretty nice. It looks like not many devices actually provide
> this feature (which is already more than two years old according to the
> release of the specification).

no profile is really making use of it and that is the actual problem.
Even if nobody likes RFCOMM, they still use it as base for a couple of
new profiles.

> Nevertheless during my development time I encountered the Siemens S75
> mobile phone to provide the full extended features mask as being
> available but refusing any serious attempts during negotiation to
> actually make use of it, e.g. sending a 0x0007 in the information
> response, but declining any use in configuration responses ...

It seems that only the Symbian 9.x based devices support the extended
features of L2CAP.

> In fact from my point of view, information requests have to be answered
> according to the specification. If a device (like the mighty mouse?!)
> doesn't do so I consider this to be a serious bug in Apple's
> implementation. Already the second sentence of section 4.10 (Vol 4 of
> the Bluetooth Spec) says:
> "L2CAP implementations _shall_ respond to a valid Information Request
> with an Information Response."
> And it is mandatory to make use of Information Requests to configure and
> use Flow Control:
> "An L2CAP implementation _shall_ only use optional features or attribute
> ranges for which the remote L2CAP entity has indicated support through
> an Information Response."

It was the old wireless mouse from Apple and I can't really complain
since old kernels have the same problem. We had a bug in the kernel that
didn't respond the information requests. The problem is that this got
never caught, because in the qualification process you can say that you
don't support the information request and then they don't check it. Even
if you don't support it, you still have to answer it the a command
rejected response. Neverless I found our bug by pure luck.

> I will do so once I get the time to upgrade to the latest bluez-libs and
> bluez-utils. I'd wish to see these latest versions finding their way
> into Ubuntu Edgy.

I hope that Edgy moves, but according to the release schedule they are
already in beta freeze by now.

> Perhaps anybody has the chance to test Windows Vista of it's current
> capability?

And the Widcomm stack please.

> Two more things beside that.
> First of all---my patch provides support for flow control but lacks any
> support for retransmission mode. Supplement this mode should be a lot
> easier today starting from the current code base. Perhaps it may even
> serve as a student's final year project or something like that.
> Further more I will get some help from someone else to go over my patch
> and get some code review done. This might help fixing bugs. I am
> currently writing up a paper about all my work done during the past
> months. I expect this to be done within the next few days. After that I
> will try to get a native speaker to look over my report (any interest?).

The features mask and the actual implementation might differ in the end,
but to collect the actual offered features is a good start. And if you
have an updated patch, please post it. I also heard some rumors that
your patch might be tested at the next UnPlugFest.

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
