Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0802101021p2ce8de5enbe61e34232ce7bf1@mail.gmail.com>
Date: Sun, 10 Feb 2008 19:21:25 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202665966.7664.97.camel@violet>
MIME-Version: 1.0
References: <8a8adccc0802100701y384d23f6oeb12c7a8d0fe4f83@mail.gmail.com>
	<1202659315.7664.88.camel@violet>
	<8a8adccc0802100831k107d6d0akc0cfe388b61b7810@mail.gmail.com>
	<1202661736.7664.91.camel@violet>
	<8a8adccc0802100924m58527440rcd3d6ffb062c742@mail.gmail.com>
	<1202665966.7664.97.camel@violet>
Subject: Re: [Bluez-devel] [PATCH] Use new tango icon for bluez gnome
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

>
> I did my own patch to handle the update-icon-cache thing properly in
> cases of distcheck and the maintainers.
>
> For now I also only included the 22x22 icons. Still have to re-think the
> file structure. Would be nice if we had some nice templates for doing
> this properly within one directory.
>
Hi Marcel,

Just looked in CVS to your patch you are installing the an SVG of
22x22 into the scalable directory. That SVG should not be installed.
It should be just in CVS such that artists can make updates to the
icons. You need to install the SVG which in my tarball is in the
scalable directory (it has a size of 48x48)

Jaap

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
