Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <003901c4df9e$a3fead20$6401000a@zool>
From: "Steffen Larsen" <zool@zool.dk>
To: <bluez-devel@lists.sourceforge.net>
References: <00c901c4df6a$f8c11f70$6401000a@zool> <1102764489.19086.15.camel@pegasus>  <016d01c4df70$a8e297d0$6401000a@zool> <1102767035.19086.18.camel@pegasus> <01a901c4df7a$666d4da0$6401000a@zool> <002d01c4df96$cc2e2080$6401000a@zool> <1102783440.19086.28.camel@pegasus>
Subject: Re: [Bluez-devel] piconet..
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Sat, 11 Dec 2004 17:29:52 +0100

Hi again Marcel,

> > My source code for most of my BTserver can be found at:
> > http://www.diku.dk/hjemmesider/studerende/zool/bt/prot.cc
> > As you can see in my souce (see the listenL2CAP method), I do almost as
you
> > told me to do and what l2test.c is doing.
> > I use the standard bind, listen and accept methods and spawns of a new
> > child, when I get a connection. But I still can't make it work when I
have
> > more than one client (a piconet). Why is that? can you see a minor flaw
in
> > my code?
> >
> > I have made a hciconfig -a with one of my USB dongles (it is a DBT 120
> > unit):
> >
> > hci0: Type: USB
> >  BD Address: 00:40:05:60:41:0D ACL MTU: 192:8  SCO MTU: 64:8
> >  UP RUNNING PSCAN ISCAN
> >  RX bytes:653 acl:0 sco:0 events:19 errors:0
> >  TX bytes:314 acl:0 sco:0 commands:18 errors:0
> >  Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
> >  Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> >  Link policy: RSWITCH HOLD SNIFF PARK
> >  Link mode: SLAVE ACCEPT
> >  Name: 'fsck-0'
> >  Class: 0x000100
> >  Service Classes: Unspecified
> >  Device Class: Computer, Uncategorized
> >  HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
> >  Manufacturer: Cambridge Silicon Radio (10)
> >
> > I can only give you this one, because one of my friends have the other
two
> > dongles. I will though sent the output later tonight, when I get them
back.
> > :-)

I got the two others:

 hci0: Type: USB
BD Address: 00:01:53:00:14:EE ACL MTU: 192:8 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN
RX bytes:81 acl:0 sco:0 events:10 errors:0
TX bytes:39 acl:0 sco:0 commands:10 errors:0
Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy:
Link mode: SLAVE ACCEPT
Name: 'knoglen'
Class: 0x000000
Service Classes: Unspecified
Device Class: Miscellaneous,
HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
Manufacturer: Cambridge Silicon Radio (10)

hci0: Type: USB
BD Address: 00:01:53:00:0D:B5 ACL MTU: 192:8 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN
RX bytes:87 acl:0 sco:0 events:11 errors:0
TX bytes:39 acl:0 sco:0 commands:10 errors:0
Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy:
Link mode: SLAVE ACCEPT
Name: 'JESPER'
Class: 0x000000
Service Classes: Unspecified
Device Class: Miscellaneous,
HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
Manufacturer: Cambridge Silicon Radio (10)


> so far so good, but check with "hciconfig hci0 revision" for the
> firmware version. This one is too old. It should be HCI 16.4 or newer,
> but if this is a DBT-120 Rev. B3 you might have a chance to update it.

Well. It is the B3 revision, so I would be able to do that. :-)

> I think you should use fork(). What is wrong with using poll() or
> select() and an event loop.

Hmm.. This dosn't really answer my question. I am using fork()., and would
like to get my application to work. I tried to compare it towards the
l2test, but couldn't see that much difference. And the l2test works with the
same dongles; connecting two clients against one server. Can you point
somewhere in my code, where I should do some changes, so it could work??

I really starts to nag me, why my code dosn't work. All things works fine
(like connecting/disconnecting etc.) with one clients, but with two... :-(
And I have tried to make my server MASTER by setting the L2CAP_LM_MASTER in
the link manager.

> And btw since you use code from l2test.c etc. you should include the GPL
> license statement at the top of your code.

No worry.. I will.

-Thanks again for a quick answer! :-)

/Steffen Larsen



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
