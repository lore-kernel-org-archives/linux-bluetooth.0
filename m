Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Alon Bar-Lev <alon.barlev@gmail.com>
In-Reply-To: <9e0cf0bf0710231057lf60ce17ldd38489850cdf7c5@mail.gmail.com>
References: <200710231950.31313.alon.barlev@gmail.com>
	<1193162106.6184.208.camel@violet>
	<9e0cf0bf0710231057lf60ce17ldd38489850cdf7c5@mail.gmail.com>
Date: Tue, 23 Oct 2007 20:26:46 +0200
Message-Id: <1193164006.6184.217.camel@violet>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
        bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [BUG] rfcomm]
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

Hi Alon,

> > first of all, please check if this still happens with 2.6.23, because we
> > had some patches in the area of the RFCOMM TTY code that might have
> > fixed this.
> 
> These messages are of 2.6.23.

still another one to go :( Anyway since you have experience and you have
a way to reproduce it, please test the latest kernel from Linus' Git
tree.

I can also whip up a patch that disables the device_move() usage and see
if that is the reason for the falling over.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
