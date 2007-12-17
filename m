Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <8a8adccc0712162354s399a15b8v831245c951e87136@mail.gmail.com>
References: <8a8adccc0712161309m29c70a45x212bead7a823d808@mail.gmail.com>
	<1197841650.8050.39.camel@aeonflux>
	<8a8adccc0712161443w7ba67743jc06515240cfdf83d@mail.gmail.com>
	<1197847447.26210.268.camel@cookie.hadess.net>
	<1197853381.8050.58.camel@aeonflux>
	<8a8adccc0712162315v53bf668et553413d6dbc81551@mail.gmail.com>
	<8a8adccc0712162354s399a15b8v831245c951e87136@mail.gmail.com>
Date: Mon, 17 Dec 2007 10:43:01 +0000
Message-Id: <1197888181.26210.293.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Beautify about dialog
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


On Mon, 2007-12-17 at 08:54 +0100, Jaap A. Haitsma wrote:
<snip>
> I know of two solutions
> 1. Don't set program-name or name but just call a
> g_set_application_name (_("Bluetooth Applet));
> 2. Use #ifdef in which you check the version of GTK and depending on
> the version you set name or program name

That's what GTK_CHECK_VERSION() is for.


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
