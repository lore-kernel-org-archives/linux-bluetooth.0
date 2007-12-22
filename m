Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <8a8adccc0712211417o3d2c8467m543e113eee1839c6@mail.gmail.com>
References: <8a8adccc0712211417o3d2c8467m543e113eee1839c6@mail.gmail.com>
Date: Sat, 22 Dec 2007 01:16:16 +0100
Message-Id: <1198282576.8050.296.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Make links in about dialog
	launch	browser/email client
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

Hi Jaap,

> Attached patch does this. It now uses the screen of the about dialog

can't we have a generic do_open function and then call it from both
hooks. From a code perspective it makes it simpler.

Also what is the deal with gnome-open and xdg-open. Wouldn't it be
enough to use only xdg-open. It should be present on all major distros
by now.

Coding style wise, please don't put a space between the function name
and the "(". I know it is unusual for GNOME stuff, but this one follows
the kernel coding style like all bluez-* packages. Also please respect
the 80 characters width rule. Meaning break long functions calls to
multiple lines.

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
