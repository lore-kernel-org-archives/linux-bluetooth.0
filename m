Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000001c7f2f8$e40bfab0$3701a8c0@YANNIS>
References: <000001c7f2f8$e40bfab0$3701a8c0@YANNIS>
Date: Mon, 10 Sep 2007 21:07:09 +0200
Message-Id: <1189451229.687.54.camel@violet>
Mime-Version: 1.0
Cc: linux-usb-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] FW: USB Linux support for MA-720
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

Hi Yannis,

> i've STFW and found out that the MA-720(Mobile Action Technology
> Inc.) usb bluetooth adapter isn't supported under any Linux distros,
> although the previous version MA-700 is support both from Bluez and
> the Linux USB Project. Can you help me solving this problem?
>  
> The USB ID of my device is 
> 0df7 0720
> I can send you all the drivers of this device at Windows if this helps.

I don't need to see any Windows drivers. Attach your dongle to a Linux
machine and send us the content of /proc/bus/usb/devices. However my
wild guess is that this dongle will simply work.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
