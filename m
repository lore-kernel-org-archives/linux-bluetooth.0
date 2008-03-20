Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1205747533.8285.10.camel@linuxpc9.mylocaldomain.com>
References: <1205747533.8285.10.camel@linuxpc9.mylocaldomain.com>
Date: Thu, 20 Mar 2008 14:56:36 +0100
Message-Id: <1206021396.7678.18.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problems with permissions for sdp local
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

Hi Wolfgang,

> I am using a USB-bluetooth dongle to my mobile phone.
> 
> Everything seems to work fine when I am logged in as root.
> As normal user kbluetoothd complains
> 
> >Failed to connect to the SDP server.
> >Please make sure that sdpd is running
> >without it, other devices will not be able to find out
> >which services your computer offers.
> 
> When I run 'sdptool browse local' as normal user I get:
> >Failed to connect to SDP server on FF:FF:FF:00:00:00: Permission denied

have you started hcid with the -s option? Do you have SELinux or
something alike activated?

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
