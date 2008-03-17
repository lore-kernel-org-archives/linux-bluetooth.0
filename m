Return-Path: <cyrus@holtmann.org>
From: Wolfgang Buesser <wolfgang.buesser@web.de>
To: bluez-users@lists.sourceforge.net
Date: Mon, 17 Mar 2008 10:52:12 +0100
Message-Id: <1205747533.8285.10.camel@linuxpc9.mylocaldomain.com>
Mime-Version: 1.0
Subject: [Bluez-users] problems with permissions for sdp local
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

I am using a USB-bluetooth dongle to my mobile phone.

Everything seems to work fine when I am logged in as root.
As normal user kbluetoothd complains

>Failed to connect to the SDP server.
>Please make sure that sdpd is running
>without it, other devices will not be able to find out
>which services your computer offers.

When I run 'sdptool browse local' as normal user I get:
>Failed to connect to SDP server on FF:FF:FF:00:00:00: Permission denied

When I run it as root I get:
>Browsing FF:FF:FF:00:00:00 ...
>Service Name: OBEX Object Push
>Service RecHandle: 0x10000
>Service Class ID List:
>  "OBEX Object Push" (0x1105)
>Protocol Descriptor List:
>  "L2CAP" (0x0100)
>  "RFCOMM" (0x0003)
>    Channel: 10
>  "OBEX" (0x0008)
>Profile Descriptor List:
>  "OBEX Object Push" (0x1105)
>    Version: 0x0100

Browsing for the remote device works for both, root an normal user.

So here is my question:
What controls the permissions to access the local interface with sdp?
Is this am matter of udev?
How can I change these permissions?

Thanks
	Wolfgang





-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
