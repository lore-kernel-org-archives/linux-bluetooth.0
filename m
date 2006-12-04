Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200612040855.29496.akohlsmith-bluez@benshaw.com>
References: <200612011448.32667.akohlsmith-bluez@benshaw.com>
	<1165152757.19590.7.camel@localhost>
	<200612040855.29496.akohlsmith-bluez@benshaw.com>
Date: Mon, 04 Dec 2006 15:07:46 +0100
Message-Id: <1165241266.12640.30.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] "promiscuous mode" for hci devices?
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

Hi Andrew,

> > a Bluetooth chip doesn't receive any packets that are not meant for it.
> > You must understand that Bluetooth works totally different than for
> > example Ethernet or Wireless LAN.
> 
> With all due respect, that simply cannot be true.  Any device in a shared 
> medium would by its very nature have to receive all messages in order to 
> determine whether a message was intended for it.

if you don't believe me, then feel free to check the specification. A
Bluetooth device is not actively participating in any communication
unless you create a piconet. If no piconet exists, then it only scans
for inquiry and page beacons.

This means that even if another piconet has been established right next
to it, your passive device will ignore it. All chips are designed this
way and unless you implement your own baseband, you don't see any of
these beacons at all.

The radio, baseband and link manager are part of the Bluetooth chip and
not accessible via the host operating system.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
