Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000201c35614$251dcaf0$1a01010a@baked>
References: <000201c35614$251dcaf0$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1059519805.26914.127.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Rfcomm qualification
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
Date: 30 Jul 2003 01:03:18 +0200

Hi Daryl,

> We ran into another 1.0B problem with rfcomm testing. We didn't notice this
> last time because the tests were done slightly differently (without an
> automated tester).
> 
> The tester acts as a 1.0B device and establishes a connection with the IUT.
> The IUT sent credits (pf bit = 1) after the MSC echange. It shouldn't.
> Attached is an hcidump of it.

the problem is that the tester don't sends a PN CMD (btw is this really
allowed?) and so we use RFCOMM_MAX_CREDITS at two points (once for the
session and for every DLC). If the PN CMD is present and shows us a 1.0b
device we set credits to zero and don't make use of credit based flow
control. It seems that the default value of credits must be zero and not
RFCOMM_MAX_CREDITS.

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
