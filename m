Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4746EC10.5080509@pracucci.com>
References: <4746EC10.5080509@pracucci.com>
Date: Mon, 26 Nov 2007 07:21:35 +0100
Message-Id: <1196058095.4217.79.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] 2.6.23.8: kernel panic
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

Hi Marco,

> I have compiled linux kernel 2.6.23.8 for a single board computer based
> on ARM architecture (EP9302 processor). I have tried to stress the
> Bluetooth subsystem, creating repeatly a lot of RFCOMM connections to
> other Bluetooth dongles (installed on remote computers) and I'm able to
> get a kernel panic in few minutes.

it would be good to know if 2.6.24-rc3 shows the same issue and if you
could also produce it on x86. And please post some example code that
would trigger this issue. I haven't seen this kind of problem so far.

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
