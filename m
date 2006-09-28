Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1159435134.21120.7.camel@localhost>
References: <1159435134.21120.7.camel@localhost>
Date: Thu, 28 Sep 2006 15:11:03 +0200
Message-Id: <1159449063.5406.22.camel@localhost>
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

Hi Marcel,

Am Donnerstag, den 28.09.2006, 11:18 +0200 schrieb Marcel Holtmann:
> with the release of bluez-utils-3.6 and bluez-utils-3.6.1, I added an
> additional command to the l2test program to determine the extended
> features of the remote L2CAP implementation. This will help us to
> identify which devices will support retransmission and flow control
> and/or connectionless connections.

This sounds pretty nice. It looks like not many devices actually provide
this feature (which is already more than two years old according to the
release of the specification).
Nevertheless during my development time I encountered the Siemens S75
mobile phone to provide the full extended features mask as being
available but refusing any serious attempts during negotiation to
actually make use of it, e.g. sending a 0x0007 in the information
response, but declining any use in configuration responses ...

> # ./l2test -z 00:04:76:*:*:*
> Connectionless MTU size is 670
> Extended feature mask is not supported
> 
> The program must be run as root and can be found in the test directory
> of bluez-utils. The switch --enable-test for configure enables its
> compilation. There is not need to install it, you can run it from that
> directory directly. If it stalls, then this might be a bug in the remote
> L2CAP implementation when it doesn't answer to information requests. In
> this case you might wanna run hcidump and check what happens.

In fact from my point of view, information requests have to be answered
according to the specification. If a device (like the mighty mouse?!)
doesn't do so I consider this to be a serious bug in Apple's
implementation. Already the second sentence of section 4.10 (Vol 4 of
the Bluetooth Spec) says:
"L2CAP implementations _shall_ respond to a valid Information Request
with an Information Response."
And it is mandatory to make use of Information Requests to configure and
use Flow Control:
"An L2CAP implementation _shall_ only use optional features or attribute
ranges for which the remote L2CAP entity has indicated support through
an Information Response."

> So please report back information about your devices and I will collect
> them and make them public at this location:
> 
> 	http://www.holtmann.org/linux/bluetooth/l2cap.html

I will do so once I get the time to upgrade to the latest bluez-libs and
bluez-utils. I'd wish to see these latest versions finding their way
into Ubuntu Edgy.
Perhaps anybody has the chance to test Windows Vista of it's current
capability?

Two more things beside that.
First of all---my patch provides support for flow control but lacks any
support for retransmission mode. Supplement this mode should be a lot
easier today starting from the current code base. Perhaps it may even
serve as a student's final year project or something like that.
Further more I will get some help from someone else to go over my patch
and get some code review done. This might help fixing bugs. I am
currently writing up a paper about all my work done during the past
months. I expect this to be done within the next few days. After that I
will try to get a native speaker to look over my report (any interest?).

Bye,
Martin


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
