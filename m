Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <CB055E3B-083D-4B4A-B42C-2ADB2E3DEFC6@pepper.com>
References: <822EACFA-537D-4382-BA97-4192E5EBCF4A@pepper.com>
	<1148908353.31689.28.camel@localhost>
	<CB055E3B-083D-4B4A-B42C-2ADB2E3DEFC6@pepper.com>
Date: Tue, 30 May 2006 16:23:14 +0200
Message-Id: <1148998994.11251.9.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Bluez Bluetooth certification tests?
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

Hi Michael,

> Are there any resulting test harness or supporting code from TomTom's  
> effort?  Or does the fact the if someone uses the Bluez stack, they  
> are by default certified?

you can use the current BlueZ qualification to qualify your own product.
It will save you a lot of time, because most test have are already been
done. And I think we spent 4 days with the L2CAP, RFCOMM and SDP testing
and you don't wanna do it again normally.

At some point the BlueZ qualification must be updated to PRD 2.0, but I
only wanna do that after the Lisbon specification has been released. It
makes no real sense to do it again now. With PRD 2.0 it should also
include some kind of HCI qualification so you basically don't even have
to re-qualify your hardware. However I haven't fully looked into the new
qualification program. I will do that when the next specification
version gets public and I have found a sponsor for it. We still have to
pay the listing fee.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
