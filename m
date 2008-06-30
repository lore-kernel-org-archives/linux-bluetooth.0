Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jun 2008 17:46:50 +0200
From: Martin Mueller <lists@sig21.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20080630154650.GB4425@caesar.sig21.net>
References: <200806301502.05323.bluez-users-mlist@malte-wetz.de>
MIME-Version: 1.0
In-Reply-To: <200806301502.05323.bluez-users-mlist@malte-wetz.de>
Subject: Re: [Bluez-users] Belkin USB-Dongle blocks USB subsystem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

On Mon, Jun 30, 2008 at 03:02:05PM +0200, Malte J. Wetz wrote:
> Hello!
> 
> I have the following problem: Whenever I plug in my Belkin USB dongle, its 
> blue led is constantly on and the USB subsystem appears to be blocked.
> 
> It looks like this ("_" indicates cursor position):

I have the same dongle and it's incorrctly indentified as "peagsus
100Mbit/s Ethernet". Just add the line:

blacklist pegasus

into the file

/etc/modprobe.d/blacklist

and it should work.

bye
  MM
--
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
