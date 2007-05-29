Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <465B4079.8000509@imperial.ac.uk>
References: <4656FDE4.5070001@imperial.ac.uk> <465AC8C7.1020502@imperial.ac.uk>
	<1180360514.21432.102.camel@aeonflux.holtmann.net>
	<465B4079.8000509@imperial.ac.uk>
Date: Tue, 29 May 2007 06:02:08 +0200
Message-Id: <1180411328.21432.111.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hid keyboard events get lost
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

Hi Konrad,

> yes, i totally agree not to screw things up for a non-standard device.
> however, to understand things better, could you explain to me why l2cap
> sends more config requests to change the mtu although it already agreed
> on the one suggested by the keyboard (hcidump is in one of my recent
> postings), or do i misinterpret what's going on?

I removed the L2CAP MTU settings from the input service. So this one
should now work for you perfectly fine. However your kernel should some
weird behavior with a MTU size of 0. That is strange. Can you test a
2.6.22-rc3 kernel, because that contains a fix for the MTU config
setting.

It also contains the full HID report support. This means that the
missing report id in front of the report should be handled correctly. If
not than we need a quirk for that. My understanding is that even if this
is valid according to the HID specification, it is not valid for
Bluetooth based HID devices.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
