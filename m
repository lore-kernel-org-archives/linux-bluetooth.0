Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1163882230.3025.18.camel@TesterBox.tester.ca>
References: <1163882230.3025.18.camel@TesterBox.tester.ca>
Date: Mon, 20 Nov 2006 09:30:00 +0100
Message-Id: <1164011400.28397.12.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Hiddev support
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

Hi Olivier,

> I recently got a logitech mx5000 bluetooth desktop. I got it to work
> with bluez without too many problems (with the CVS hid2hci). It seems to
> behave mostly like the bluetooth dinovo. I also want to control the
> display and use the special keys. But they are carried in hidp input
> reports of type 3 (what the bluetooth hid spec calls "features"). I
> looked at the 2.6.18-mh7 patch and it has support for full HID or at
> least a way to get/send reports from userspace, but it seems that hiddev
> has been removed from it? Why? Also, can't the HID code just be shared
> with the USB version since its essentially the same anmd you'd get free
> hiddev. There are events comments in the HID code saying it should be
> independant from USB, might be a good occasion to do it.

this is work in progress and I have seen some nice patches for sharing
the HID layer between USB and Bluetooth. We will also have a feature
that might be called hidraw to directly access the HID reports. So
please stay tuned.

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
