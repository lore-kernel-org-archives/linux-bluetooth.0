Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1190483342.7150.224.camel@pmac.infradead.org>
References: <1190483342.7150.224.camel@pmac.infradead.org>
Date: Sat, 22 Sep 2007 20:57:15 +0200
Message-Id: <1190487435.5133.66.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: Claudio Takahasi <cktakahasi@gmail.com>
Subject: Re: [Bluez-devel] [PATCH] Attempt bonding with keyboards.
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

Hi David,

> My Nokia SU-8W keyboard will never attempt to reconnect to the computer
> after a power cycle unless we actually pair with it. With the input
> service as it currently stands, we don't -- so it works once, but then
> next time I want to use it I need to go through the whole search and
> 'add new input device' process again (and the bluetooth-properties
> applet crashes when you try to add a device which already exists, which
> is not so cute).

the main questions is if we wanna make that policy of pairing a device
first part of the input service or the the UI creating the device.

I think it should be part of the UI and it should create the pairing
before connecting the input device.

With the move to CreateDevice and CreatePairedDevice this all will
become obsolete anyway.

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
