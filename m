Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080129170629.GU5671@cathedrallabs.org>
References: <20080129051224.GD14674@jake.ruivo.org>
	<1201624340.6218.11.camel@violet>
	<20080129170629.GU5671@cathedrallabs.org>
Date: Tue, 29 Jan 2008 18:09:52 +0100
Message-Id: <1201626592.6218.20.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH 3/4] add support to fake HID devices
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

Hi Aristeu,

> > Why do we export struct device? Why is this needed? Can't it stay local?
> I thought it'd be useful in the future for new fakehid implementations.
> I guess it's a better idea to not do it and do when (and if) it's
> needed.

having things local is better. Unnecessary exports are more trouble than
it is worth.

> Thanks for the comments Marcel, I'll work on them and repost the
> patches.

Please do. And then I can check if we can get them in before the next
release.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
