Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 12:06:29 -0500
From: Aristeu Rozanski <aris@ruivo.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080129170629.GU5671@cathedrallabs.org>
References: <20080129051224.GD14674@jake.ruivo.org>
	<1201624340.6218.11.camel@violet>
MIME-Version: 1.0
In-Reply-To: <1201624340.6218.11.camel@violet>
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

Hi Marcel,
> > This patch adds support to fake HID devices. Instead of registering with
> > kernel, the fake HID will be handled in user level and an uinput device
> > will be created in order to get the events into input layer.
> 
> the filename should be fakehid.[ch].
will do

> Why do we export struct device? Why is this needed? Can't it stay local?
I thought it'd be useful in the future for new fakehid implementations.
I guess it's a better idea to not do it and do when (and if) it's
needed.

Thanks for the comments Marcel, I'll work on them and repost the
patches.

-- 
Aristeu


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
