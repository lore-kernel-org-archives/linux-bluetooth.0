Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c93f2a2905012402052f2011ea@mail.gmail.com>
From: Embedded System <embed.sys@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can't init device hci0 (all information included), help! Thanx a lot!!!
In-Reply-To: <200501240919.33974.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <c93f2a2905012302107465ea43@mail.gmail.com>
	 <1106500482.9269.46.camel@pegasus>
	 <c93f2a2905012319541a6c820f@mail.gmail.com>
	 <200501240919.33974.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 24 Jan 2005 18:05:23 +0800

hi, Michal & Marcel

This doggle is based on CSR chip.

I have reinstalled Vmware (change from 5.0 beta to 4.5.2) and Red Hat
9 (use default bluez-lib-2.3-3 and bluez-util-2.2-3) just now, it
WORKS now, at least everything looks fine so far, I can l2ping the
device (Nokia 7650) properly.

Below is the hciconfig -a output of my usb doggle, you can check it
whether it's supported by lastest bluez package.

hci0:	Type: USB 
	BD Address: 00:10:60:A3:83:0E ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:1132 acl:2 sco:0 events:44 errors:0
	TX bytes:423 acl:2 sco:0 commands:26 errors:0
	Features: 0xff 0xff 0x0f 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ (0)'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x1e7 LMP Ver: 1.1 (0x1) LMP Subver: 0x1e7
	Manufacturer: Cambridge Silicon Radio (10)

I will try new kernel later, and tell you the outcome. Btw, I noticed
that many people talked 'ep0in timed out' problem, maybe it's
something wrong with latest usb subsystem?

All the best,
Andy


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
