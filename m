Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202694454.3491.129.camel@cookie.hadess.net>
References: <1202692346.7664.129.camel@violet>
	<1202693028.3491.112.camel@cookie.hadess.net>
	<1202693468.7664.135.camel@violet>
	<1202694454.3491.129.camel@cookie.hadess.net>
Date: Mon, 11 Feb 2008 03:33:17 +0100
Message-Id: <1202697197.7664.144.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [BlueZ-Announce]
	Release	of	bluez-libs-3.26	and	bluez-utils-3.26
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

Hi Bastien,

> > And I am thinking about simply adding the support for FTP to bluez-gnome
> > since the dependencies of gnome-user-share are a little bit too much.
> 
> The same as bluez-gnome plus httpd and avahi. Could you add a way to
> disable the bluez-gnome code? I'm thinking of adding obexpush support in
> gnome-user-share as well, as it's the better place to have it, thinking
> desktop-wide.

I have OPP and FTP support in bluez-gnome now. Was actually pretty
simple. The only problem is that we can't reject requests and that no
pairing is triggered.

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
