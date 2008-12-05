Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <89b6ba3a0812050920q1dea080i148d9c4677b6ed04@mail.gmail.com>
References: <COL102-W12443FB0254944C58D2F2FA8020@phx.gbl>
	<e343e5940812050154i52fb8eb3x46cf6e73e5a0c8f9@mail.gmail.com>
	<BAY127-W1206CF6F607105AA558C2DA8FE0@phx.gbl>
	<89b6ba3a0812050920q1dea080i148d9c4677b6ed04@mail.gmail.com>
Date: Fri, 05 Dec 2008 19:40:17 +0100
Message-Id: <1228502417.28839.33.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] MA-720 does not work
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Patryk,

> > modprobe hci_usb gives no error, but
> >
> > modprobe  vendor=0df7 or modprobe product=0722
> > gives
> >
> > FATAL: Module vendor=0df7 not found
> 
> You are supposed to pass all 3 in a single line. product and vendor
> are options for the hci_usb module.

no they are not.

Regards

Marcel



------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
