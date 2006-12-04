Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 4 Dec 2006 10:31:06 -0500
References: <200612011448.32667.akohlsmith-bluez@benshaw.com>
	<200612040855.29496.akohlsmith-bluez@benshaw.com>
	<1165241266.12640.30.camel@localhost>
In-Reply-To: <1165241266.12640.30.camel@localhost>
MIME-Version: 1.0
Message-Id: <200612041031.06996.akohlsmith-bluez@benshaw.com>
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

On Monday 04 December 2006 09:07, Marcel Holtmann wrote:
> if you don't believe me, then feel free to check the specification. A
> Bluetooth device is not actively participating in any communication
> unless you create a piconet. If no piconet exists, then it only scans
> for inquiry and page beacons.

I wasn't disbelieving, at least not on that kind of level.

> The radio, baseband and link manager are part of the Bluetooth chip and
> not accessible via the host operating system.

That's what I was getting at; the device *does* see all communications, but 
unless there is a method to flip on the equivalent of ethernet's promiscuous 
mode, you'll never see anything not intended for you.  Your message suggests 
that there is no HCI call to do this, which puts me out of luck.

Have you seen or heard of anyone using two BT devices in a Linux box to 
achieve a "man-in-the-middle" type of monitoring system?

-A.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
