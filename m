Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000501c356b7$2887faf0$1a01010a@baked>
References: <000501c356b7$2887faf0$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1059585760.26915.148.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] RE: Rfcomm qualification
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 30 Jul 2003 19:22:33 +0200

Hi Daryl,

> Yes, it's ok that the tester doesn't send the PN command. In 1.0B, the PN
> command is optional. In the 1.1 spec, part F:1, section 5.5.3 "DLC parameter
> negotiation (PN)", it says that it is optional in the TS 07.10 spec, but is
> mandatory in BT spec 1.1 and later.

welcome to the bad stories of Bluetooth RFCOMM ;)

> Will making the default value of credits zero break other things?

This is the magic question. I think it will not break anything, but I am
not 100% sure. And I haven't the time to boot up a test machine.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
