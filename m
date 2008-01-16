Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <478DDB4C.2080007@bluecellnetworks.com>
References: <478DDB4C.2080007@bluecellnetworks.com>
Date: Wed, 16 Jan 2008 16:42:30 +0100
Message-Id: <1200498150.7978.56.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] use more than 16 HCI Devices at a time with	BlueZ?
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

Hi Uli,

> is there a possibility to use more than 16 HCI-Devices at a time with BlueZ?
> And if not, where is this limitation set? (i would try to raise it on my 
> own then :) )

the kernel has no limit besides memory and the usual integer limit. In
userspace the limit is set to 16. A modified Bluetooth library would be
enough. I think the constant you look for is HCI_MAX_DEV or something.
Check the source code. It is easy to spot.

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
